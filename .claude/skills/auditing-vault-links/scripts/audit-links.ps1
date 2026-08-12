<#
Reports dangling wikilinks (link targets with no matching note) and orphaned
notes (notes no other note links to) in an Obsidian vault.
#>
param(
    [string]$VaultPath = (Resolve-Path (Join-Path $PSScriptRoot "..\..\..\..")).Path
)

$excludedDirs = @('.obsidian', '.claude', '.git', '.trash')

function Test-ExcludedPath {
    param([string]$FullName)
    foreach ($dir in $excludedDirs) {
        if ($FullName -match [regex]::Escape("\$dir\")) { return $true }
    }
    return $false
}

$allFiles = Get-ChildItem -Path $VaultPath -Recurse -Filter '*.md' -File |
    Where-Object { -not (Test-ExcludedPath $_.FullName) }

if (-not $allFiles) {
    Write-Output "No .md files found under $VaultPath"
    return
}

# Read each file once (UTF-8 via .NET: Windows PowerShell 5.1's Get-Content
# autodetection mangles accented characters in BOM-less UTF-8 files, which
# Obsidian writes by default).
$fileContent = @{}
foreach ($f in $allFiles) {
    try {
        $fileContent[$f.FullName] = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    } catch {
        $fileContent[$f.FullName] = ''
    }
}

# Resolvable titles = filename (Obsidian's link target) plus any frontmatter
# aliases, since Obsidian resolves [[Target]] against both. Without this,
# every alias added to fix the numbered-file naming pattern would still be
# misreported as a dangling link.
$titleToPath = @{}
foreach ($f in $allFiles) {
    $relPath = $f.FullName.Substring($VaultPath.Length + 1)
    $titleToPath[$f.BaseName.ToLowerInvariant()] = $relPath

    $content = $fileContent[$f.FullName]
    if ($content -match '(?s)^---\r?\n(.*?)\r?\n---') {
        $fm = $Matches[1]
        if ($fm -match '(?ms)^aliases:\s*(.*?)(^\S|\z)') {
            $aliasBlock = $Matches[1]
            $inlineMatch = [regex]::Match($aliasBlock, '^\s*\[(.*?)\]', 'Singleline')
            if ($inlineMatch.Success) {
                foreach ($a in $inlineMatch.Groups[1].Value -split ',') {
                    $clean = $a.Trim().Trim('"').Trim("'")
                    if ($clean) { $titleToPath[$clean.ToLowerInvariant()] = $relPath }
                }
            } else {
                $itemMatches = [regex]::Matches($aliasBlock, '(?m)^\s*-\s*(.+?)\s*$')
                foreach ($im in $itemMatches) {
                    $clean = $im.Groups[1].Value.Trim().Trim('"').Trim("'")
                    if ($clean) { $titleToPath[$clean.ToLowerInvariant()] = $relPath }
                }
            }
        }
    }
}

$linkPattern = '\[\[([^\]\|#\^]+)'
$linkedPaths = New-Object 'System.Collections.Generic.HashSet[string]'
$dangling = @()

foreach ($f in $allFiles) {
    $content = $fileContent[$f.FullName]
    if (-not $content) { continue }
    $matches = [regex]::Matches($content, $linkPattern)
    foreach ($m in $matches) {
        $target = $m.Groups[1].Value.Trim()
        if (-not $target) { continue }
        $key = $target.ToLowerInvariant()
        if ($titleToPath.ContainsKey($key)) {
            [void]$linkedPaths.Add($titleToPath[$key])
        } else {
            $dangling += [PSCustomObject]@{
                SourceFile = $f.FullName.Substring($VaultPath.Length + 1)
                Target     = $target
            }
        }
    }
}

$orphans = $allFiles | Where-Object {
    -not $linkedPaths.Contains($_.FullName.Substring($VaultPath.Length + 1))
} | ForEach-Object { $_.FullName.Substring($VaultPath.Length + 1) }

Write-Output "=== Dangling wikilinks ($($dangling.Count)) ==="
if ($dangling.Count -eq 0) {
    Write-Output "(none)"
} else {
    $dangling | Sort-Object Target, SourceFile | Format-Table -AutoSize | Out-String -Width 200 | Write-Output
}

Write-Output ""
Write-Output "=== Orphaned notes - no incoming wikilinks ($($orphans.Count)) ==="
if ($orphans.Count -eq 0) {
    Write-Output "(none)"
} else {
    $orphans | Sort-Object | ForEach-Object { Write-Output "- $_" }
}

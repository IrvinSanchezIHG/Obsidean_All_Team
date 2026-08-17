---
aliases:
  - Region Language Codes
  - Language Locale Codes
  - Códigos de Región e Idioma
tags:
  - sfmc
  - locales
  - reference
  - localization
  - lfc
created: 2026-08-11
status: Active
---

# Region Language Codes

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[Region Language Codes]]
> WHERE file.path != this.file.path
> ```

> [!info] Fuente oficial
> [Region Language Codes.xlsx](https://ihg-my.sharepoint.com/:x:/r/personal/patricia_fernandez1_ihg_com/_layouts/15/Doc.aspx?sourcedoc=%7B6A94993F-151F-42A1-883D-00663C75887B%7D&file=Region%20Language%20Codes.xlsx&action=default&mobileredirect=true&isSPOFile=1&ovuser=2762c43f-29c1-448a-89f6-7ac903cf8316%2CGerardo.Avina%40ihg.com&wdExp=TEAMS-TREATMENT&web=1&clickparams=eyJBcHBOYW1lIjoiVGVhbXMtRGVza3RvcCIsIkFwcFZlcnNpb24iOiI0OS8yNjA3MDIxNTcxMSJ9) — SharePoint, El Grupo. Esta nota es una copia de referencia rápida para consulta dentro del vault; ante cualquier discrepancia, el Excel de SharePoint es la fuente de verdad.

## Tabla completa

| #   | Language | Locale | Language from Smartling      | Region/Language Code | Path used in web | Activo en campaña  |
| --- | -------- | ------ | ---------------------------- | -------------------- | ---------------- | ------------------ |
| 1   | en       | en_US  | English (United States)      | USEN                 | us/en            | Activos en campaña |
| 2   | en       | en_US  | English (United States)      | CAEN                 | us/en            | Activos en campaña |
| 3   | en       | en_US  | English (United States)      | MSEN                 | us/en            | Activos en campaña |
| 4   | en       | en_GB  | English (United Kingdom)     | EUEN                 | gb/en            | Activos en campaña |
| 5   | en       | en_GB  | English (United Kingdom)     | AMEN                 | gb/en            | Activos en campaña |
| 6   | en       | en_GB  | English (United Kingdom)     | GCEN                 | gb/en            | Activos en campaña |
| 7   | es       | es_US  | Spanish (International)      | USES                 | us/es            | No activo          |
| 8   | es       | es_US  | Spanish (International)      | MSES                 | us/es            | Activos en campaña |
| 9   | es       | es_US  | Spanish (International)      | EUES                 | us/es            | Activos en campaña |
| 10  | es       | es_ES  | Spanish (Spain)              | ESES                 | es/es            | Activos en campaña |
| 11  | pt       | pt_BR  | Portuguese (Brazil)          | MSPT                 | br/pt            | Activos en campaña |
| 12  | pt       | pt_PT  | Portuguese (Portugal)        | EUPT                 | pt/pt            | Activos en campaña |
| 13  | pl       | pl_PL  | Polish (Poland)              | EUPL                 | pl/pl            | Activos en campaña |
| 14  | nl       | nl_NL  | Dutch (Netherlands)          | EUNL                 | nl/nl            | Activos en campaña |
| 15  | de       | de_DE  | German (Germany)             | EUDE                 | de/de            | Activos en campaña |
| 16  | it       | it_IT  | Italian (Italy)              | EUIT                 | it/it            | Activos en campaña |
| 17  | ru       | ru_RU  | Russian                      | EURU                 | ru/ru            | Activos en campaña |
| 18  | fr       | fr_FR  | French (France)              | EUFR                 | fr/fr            | Activos en campaña |
| 19  | fr       | fr_FR  | French (France)              | CAFR                 | fr/fr            | No activo          |
| 20  | ar       | ar_AE  | Arabic (International)       | AMAR                 | ae/ar            | Activos en campaña |
| 21  | jp       | ja_JP  | Japanese                     | AMJP                 | jp/ja            | Activos en campaña |
| 22  | tr       | tr_TR  | Turkish (Turkey)             | AMTR                 | tr/tr            | Activos en campaña |
| 23  | th       | th_TH  | Thai (Thailand)              | AMTH                 | th/th            | Activos en campaña |
| 24  | id       | id_ID  | Indonesian (Indonesia)       | AMID                 | id/in            | Activos en campaña |
| 25  | ko       | ko_KR  | Korean (South Korea)         | AMKO                 | kr/ko            | Activos en campaña |
| 26  | vi       | vi_VN  | Vietnamese (Vietnam)         | AMVI                 | vn/vi            | Activos en campaña |
| 27  | zh       | zh_CN  | Chinese (China-Simplified)   | GCZH                 | cn/zh            | Activos en campaña |
| 28  | tw       | zh_TW  | Chinese (Taiwan-Traditional) | TWZH                 | tw/zh            | Activos en campaña |

## Notas rápidas

- Un mismo `locale` (ej. `en_US`, `en_GB`, `fr_FR`) puede mapear a **varios Region/Language Codes** distintos (ej. `USEN`, `CAEN`, `MSEN` todos apuntan a `en_US`).
- El **Path used in web** se repite para todos los region codes que comparten el mismo locale/idioma.
- Casos particulares a tener en cuenta:
  - `jp` usa el locale `ja_JP` (el código de idioma real es `ja`, no `jp`).
  - `id_ID` (Indonesio) usa el path `id/in`, no `id/id`.
  - `tw` (Chino Taiwán) usa locale `zh_TW`.

## Relacionado

[[Email Properties]]
[[CRF]]
[[Translation Workflow]]
[[Subject & Preheader Localization]]
[[Glosario de Términos y Herramientas LFC]]

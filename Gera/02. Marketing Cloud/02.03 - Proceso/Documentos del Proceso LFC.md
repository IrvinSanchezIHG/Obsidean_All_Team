---
aliases:
  - "Documentos LFC"
  - "Documentos del Proceso"
  - "Tipos de Documentos LFC"
tags:
  - documentos
  - lfc
  - sfmc
  - proceso
  - reference
  - timeline
created: 2026-08-17
status: Active
---

# Documentos del Proceso LFC

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[Documentos del Proceso LFC]]
> WHERE file.path != this.file.path
> ```

> [!abstract]- Qué es esta nota
> Catálogo de **solo los documentos** (no herramientas, no roles) que circulan a lo largo del proceso LFC, más **cuándo** aparece cada uno dentro del ciclo de una campaña. Las definiciones completas ya viven en el [[Glosario de Términos y Herramientas LFC|Glosario]] — esta nota se enfoca en el orden y el "quién se lo entrega a quién". Para el flujo técnico completo (no solo documentos), ver [[End-to-End Flow]] y [[Mejores Prácticas de Desarrollo LFC]].

## Catálogo de documentos

| Documento | Quién lo arma / entrega | Para qué sirve |
|---|---|---|
| **Master Deck** | El Grupo (estratégico, por fase de #LFC) | Overview estratégico, user journey y detalle de cada email de una fase completa (Educate/Engage/Nurture/Retain) — más amplio que una campaña individual. |
| **Briefing document** | El Grupo → La agencia | Requisitos iniciales de una campaña específica: KPIs, canal, módulos históricos, librería de imágenes. Punto de partida del ciclo. |
| **Comms plan** | Campaign Manager (El Grupo) | Mapea la secuencia completa de touch-points de una campaña multi-touch y a qué stage pertenece cada uno. |
| **Copy deck** | Copywriters | Tono de marca, subject lines alternativos, ubicación de contenido dinámico y CTAs — insumo para Creative antes de Figma. |
| **[[Figma Assets\|Figma]]** | Creative Services | Fuente oficial de todos los assets de diseño, exportados en 2x. Pasa por rondas (1, 2, 3…) hasta "approved creative". |
| **List Pull / List Pool** | Developer (La agencia), validado con Data Team | Qué campo de la Data Extension trae qué valor — base para escribir AMPscript y test cases. Se prepara en paralelo al Figma. |
| **[[CRF]]** (Campaign Requirements File) | Business Analyst | Fuente de verdad para desarrollo: Email Details, Subject/Preheader, MRM ID, Content ID, Assets, Tracking, traducciones, business requirements — incluye la matriz de links. "Punto de no retorno" antes del handoff a desarrollo. |
| **Work-back schedule** | Project Manager | Cronograma con fecha límite de cada asset/entregable — usado para planear traducciones, QA y deployment. Corre en paralelo durante todo el ciclo. |
| **URL Metrics sheet** | Campaign Team (El Grupo) → integrado al CRF | Matriz de links y sus parámetros de tracking — referencia al construir/validar cada URL. Ver [[Link Matrix (LinkHelper)]] para la implementación técnica en SFMC. |
| **Translation document** (Smartling) | Localization Team / Smartling | Documento donde se llenan las traducciones solicitadas por [[Content ID]] (subject/preheader/contenido dinámico) — se copian manualmente al AMPscript al recibirlas de vuelta. |
| **Test Case Document** | QA (La agencia) | Documento central del proceso de QA — segregado por email y por push, con hojas por cada email de la campaña. Figma es su fuente de verdad. |
| **Feedback Tracker** (Smartsheet) | QA | Registra cada hallazgo de QA: ronda, quién lo encontró, captura, respuesta del desarrollador. Reemplaza el feedback suelto por chat. |
| **[[Deployment Plan]]** | Developer | Centraliza el detalle técnico final: historial de revisiones, propósito, detalles de la DE, capturas del journey, schedule y decision splits. Se construye **después** de que build y QA están completos, nunca en paralelo. Se archiva en SharePoint. |
| **ESSR** (Email Send Summary Report) | Automatizado | Reporte diario (~2 veces al día) que resume envíos de los últimos 7 días para journeys always-on; resalta caídas/incrementos >25% y "zero sends". |

## Línea de tiempo

Momento del ciclo en que aparece cada documento — no todos corren en serie estricta: algunos se preparan en paralelo (marcado abajo), otros son continuos durante todo el proceso.

```text
Master Deck (contexto de fase, ya existe antes de la campaña)
        ↓
Briefing document  (El Grupo → La agencia)
        ↓
   ┌────────────────┬──────────────────┐
   ↓                ↓                  ↓
Copy deck        Comms plan       Work-back schedule (continuo, no puntual)
   ↓
Figma  ══════════ en paralelo ══════════  List Pull / List Pool
   ↓                                          ↓
   └──────────────────┬───────────────────────┘
                       ↓
              CRF  (+ URL Metrics sheet integrado)
                       ↓
              Build (USEN) — no genera documento nuevo, consume el CRF
                       ↓
              Translation document  (ida y vuelta con Smartling)
                       ↓
              Test Case Document  +  Feedback Tracker  (rondas de QA)
                       ↓
              Deployment Plan  (build + QA ya completos)
                       ↓
              Deployment / Activación
                       ↓
              ESSR  (monitoreo continuo post-activación)
```

**Regla de secuencia crítica**: el **Deployment Plan siempre se construye después** de terminar build y QA — nunca en paralelo, porque documenta el estado ya validado, no el plan de lo que se va a hacer (ver [[Mejores Prácticas de Desarrollo LFC#8. Deployment y monitoreo]]).

## Relacionado

[[Glosario de Términos y Herramientas LFC]]
[[End-to-End Flow]]
[[Mejores Prácticas de Desarrollo LFC]]
[[CRF]]
[[Deployment Plan]]
[[Figma Assets]]
[[Link Matrix (LinkHelper)]]
[[Translation Workflow]]
[[QA Process]]

---
aliases:
  - "Journey Builder"
  - "Entry Source"
tags:
  - journey-builder
  - entry-source
  - sfmc
  - qa
created: 2026-08-09
status: Active
---

# Journey Builder

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[20 - Journey Builder]]
> WHERE file.path != this.file.path
> ```

## Función

Orquesta el envío: conecta una Data Extension específica de stage con la actividad de canal correcta (Email o MobilePush). No es donde se decide la audiencia — esa lógica ya debe venir resuelta en la [[Data Layer|DE]].

## Modelo recomendado

```text
Entry Source (DE) → Activity (Email/Push) → Exit
```

Mientras más simple el canvas, más seguro el lanzamiento. Decision splits solo si la campaña específicamente lo requiere — si la lógica de audiencia ya está en la DE, un split la duplica y complica el QA.

## Entry Source

La decisión más crítica del journey: determina quién entra. Antes de activar, verificar nombre de la DE, stage, idioma/mercado, campos requeridos, y si es DE de prueba o producción. La mayoría de errores de lanzamiento vienen de una DE fuente equivocada, no de un canvas roto.

## Prueba de Decision Splits (cuando existen)

Seleccionar registros de distintos idiomas desde la DE y validar que cada uno siga la ruta correcta (o salga sin enviar si no hay split para ese idioma). Conviene un journey de prueba apuntando a una DE de prueba (sin mailing date) antes de copiarlo a producción.

## Validar antes de activar

La validación de la plataforma solo confirma que el setup es técnicamente aceptable — no confirma que la DE, el asset o el stage sean los correctos. Combinar siempre validación de plataforma + QA manual + aprobación de stakeholders.

## Monitoreo post-activación

- **Golden Hour Check**: poco después del envío, revisar en Interactions que corre sin errores.
- **End of Day Check**: revisar Journey History (tasa de éxito/completado).
- Solo detener el journey si el problema es de **contenido**; problemas de **datos** suelen resolverse solos.

## Relacionado

[[Data Layer]]
[[QA Process]]
[[Deployment Plan]]
[[Monitoring]]
[[LFC_20260507_Lifecycle Email Development & Data Integration#Paso 7: Construir el Journey desde cero|Manual de Onboarding – Paso 7]]
[[LFC_20260508_Marketing Cloud Journey Monitoring & Reporting]]

#journeybuilder #entrysource #sfmc #qa

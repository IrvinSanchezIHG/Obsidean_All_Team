---
aliases: []
tags:
  - smartling
  - herramienta
  - translation-management
  - localization
  - saas
created: 2026-08-10
status: Active
---

# Smartling

> [!abstract]- Resumen
> Plataforma SaaS de gestión de traducciones (TMS) que orquesta el flujo de localización end-to-end. El Grupo es cliente directo — es la herramienta detrás del [[Translation Workflow]] de LFC.

## Qué es

Smartling se define como una "solución integral de orquestación de traducciones": una plataforma empresarial que automatiza y acelera los flujos de traducción para no tener que gestionar múltiples proveedores lingüísticos por separado. Promete resultados hasta 10 veces más rápidos, hasta 70% de reducción de costo y flujos hasta 100% automatizados.

## Funcionalidades principales

**Plataforma core:**
- Sistema de Gestión de Traducciones (TMS)
- LQA Agent — evaluación automática de calidad de la traducción
- Proxy de traducción para sitios web
- Herramientas CAT (traducción asistida por computadora)
- Analítica en tiempo real

**Traducción:**
- Traducción por IA con múltiples LLM, vía **AI Hub** (acceso a 20+ motores de traducción automática)
- Servicios de traducción profesional (red de 4,000+ lingüistas humanos)
- **LanguageAI™** — orquestación de LLM, post-edición automática, detección de sesgos y ajuste de tono

## Integraciones

Más de 50 conectores, incluyendo Adobe Experience Manager, Salesforce, HubSpot, GitHub, WordPress y plataformas de almacenamiento en la nube. No se documentó públicamente el conector específico usado con Salesforce Marketing Cloud para el flujo de [[Translation Workflow|LFC]] — ver esa nota para el proceso tal como se usa aquí.

## Seguridad y certificaciones

SOC 2 Tipo II, HIPAA, GDPR, ISO/IEC 42001:2023 (estándar de gestión de IA).

## Uso en este vault

- **Cliente confirmado**: El Grupo aparece listado como cliente notable de Smartling (junto con Pinterest, Netskope y Lyft), lo que confirma que es la herramienta real detrás de las traducciones LFC, no solo una mención genérica.
- El proceso concreto de cómo se usa dentro del flujo LFC — build en USEN, envío a Smartling, qué traduce y qué no (Subject/Preheader quedan fuera) — está documentado en [[Translation Workflow]], no en esta nota. Esta nota cubre la herramienta en sí; esa otra cubre el proceso local.

## Relacionado

[[Translation Workflow]]
[[Subject & Preheader Localization]]
[[Figma Assets]]

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[Smartling]]
> WHERE file.path != this.file.path
> ```

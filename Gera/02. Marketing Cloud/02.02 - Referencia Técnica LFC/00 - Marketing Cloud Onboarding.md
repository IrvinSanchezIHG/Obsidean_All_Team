---
aliases:
  - "Salesforce Marketing Cloud"
  - "SFMC"
tags:
  - sfmc
  - onboarding
  - campaign-delivery
  - el-grupo
created: 2026-08-05
status: Active
---

# Onboarding El Grupo - Marketing Cloud & Campaign Delivery

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[00 - Marketing Cloud Onboarding]]
> WHERE file.path != this.file.path
> ```

> Nota maestra para entender cómo funciona Marketing Cloud dentro de El Grupo, cuál es el rol de Guadalajara, cómo se relacionan los equipos y cuál es la visión estratégica de largo plazo.

---

# Resumen Ejecutivo

El Grupo está construyendo una capacidad interna de [[Salesforce Marketing Cloud]] y [[Campaign Delivery Management]] para absorber progresivamente actividades actualmente ejecutadas por un vendor externo.

El equipo de Guadalajara funciona como una extensión del equipo de Atlanta y está enfocado principalmente en la construcción, validación, despliegue y operación de campañas. 【1-f3d43c】【2-ac6ba9】

---

# Ecosistema General

```text
Atlanta
│
├─ Estrategia
├─ Priorización
├─ Marketing
└─ Business Requirements

        ↓

Data
        ↓

Content Operations
        ↓

Creative Services
        ↓

Localization
        ↓

Marketing Governance
        ↓

Marketing Cloud Guadalajara
        ↓

QA
        ↓

Producción
```

---

# El Rol de Guadalajara

## Qué recibimos

Los equipos especializados entregan:

- Audiencias
- Segmentaciones
- Data Extensions
- Diseño
- Copy
- Traducciones
- Requerimientos

Nuestra responsabilidad comienza cuando la campaña debe implementarse dentro de [[Salesforce Marketing Cloud]].

---

# Lo Que Hacemos

## Desarrollo

Desarrollo técnico dentro de [[Salesforce Marketing Cloud]].

Incluye:

- Responsive Email Development
- Dynamic Content
- Personalization Logic
- AMPscript
- Journey Configuration
- Automation Support

Relacionados:

- [[SFMC Tech Developer]]
- [[Salesforce Marketing Cloud]]

---

## Quality Assurance

Validación previa a producción.

Incluye:

- Functional Testing
- Rendering Validation
- Personalization Testing
- Journey Validation
- Data Validation

El objetivo es asegurar que la experiencia del cliente sea correcta antes del lanzamiento.

---

## Deployment

Activación y soporte productivo.

Incluye:

- Scheduling
- Journey Activation
- Production Releases
- Monitoring
- Troubleshooting

---

## Campaign Delivery

Además del desarrollo, el equipo también participa en actividades de [[Campaign Delivery Management]].

Incluye:

- Requirements Gathering
- Stakeholder Alignment
- Timeline Management
- Risk Management

---

# Secuencia de Onboarding Técnico

Mapa de contenido: orden recomendado de lectura de la curricula técnica LFC/SFMC.

1. [[LFC]] — visión general del proceso end-to-end
2. [[CRF]] — fuente de verdad de requisitos
3. [[Email Build Process]] — flujo de construcción del email
4. [[Email Properties]] — Campaign Tag, Category Tag, MRM ID, Language Parameter
5. [[Figma Assets]] — origen de los assets de diseño
6. [[Translation Workflow]] — Smartling y el flujo de traducción
7. [[Subject & Preheader Localization]] — la excepción que Smartling no traduce
8. [[Data Layer]] — Data Extensions, campos, personalización
9. [[Content ID]] — selección de contenido dinámico
10. [[AMPscript]] — orden de ejecución y variables comunes
11. [[TreatAsContent]] — interpretar contenido dinámico
12. [[Shared Content Blocks]] — reutilización antes de construir
13. [[Dynamic Date Block]] — formato de fecha por locale
14. [[Tracking]] — EM/LM y su función en analytics
15. [[QA Process]] — validación previa a producción
16. [[Internal Send]] — validar experiencia real
17. [[Deployment Plan]] — último control antes de producción
18. [[Monitoring]] — Tableau y la ventana crítica de 24h
19. [[End-to-End Flow]] — el flujo completo, de punta a punta
20. [[Journey Builder]] — orquestación en Journey Builder, Entry Source y monitoreo post-activación
21. [[HTML & CSS para Email]] — referencia de propiedades y técnicas de HTML/CSS específicas de email coding

## Relacionado

[[Índice de Onboarding LFC]]
[[LFC Developer Onboarding Guide]]
[[Mejores Prácticas de Desarrollo LFC]] — referencia rápida condensada de todo lo anterior, por fase

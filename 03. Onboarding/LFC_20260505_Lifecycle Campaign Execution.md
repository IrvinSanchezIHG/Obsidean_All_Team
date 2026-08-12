---
date: 2026-05-05
tags:
  - lfc
  - sfmc
  - onboarding
  - meeting-notes
  - ihg
  - gale
type: meeting-notes
participants:
  - Tamara
  - Oscar
  - Kamaria
  - Laura
  - Anu
  - Kapil
related:
  - "[[LFC Developer Onboarding Guide]]"
  - "[[Salesforce Marketing Cloud]]"
---

# LFC Training — Lifecycle Campaign Execution

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[LFC_20260505_Lifecycle Campaign Execution]]
> WHERE file.path != this.file.path
> ```

`#lfc #onboarding #ihg #gale`

> [!info] Contexto Sesión de capacitación (~2h30) sobre el proceso de **Lifecycle Campaign Execution (LFC)** para la cuenta de **IHG**, dentro del onboarding del equipo de Guadalajara. Participan [[Tamara]] (PM) y [[Oscar]] (developer), guiados por [[Kamaria]] e [[Laura|Laura]] (IHG), con sesiones a cargo de [[Anu]] (ejecución/desarrollo) y [[Kapil]] ([[GALE]], [[Project Manager|Project Management]]).

---

## 1. Proceso general de Lifecycle (Kamaria)

Flujo macro:

```
Necesidad de negocio → Estrategia → Creativo → Delivery → Ejecución → Mantenimiento
```

- **Delivery**: documentación, mapeo de contenido dinámico, proofing, casos de prueba.
- **Ejecución** (#guadalajara): build de emails, journeys, QA, revisión de journey, deployment.
- **Mantenimiento**: monitoreo de performance + identificación de optimización (equipo de analytics).
- El ciclo **nunca termina** — se revisa, actualiza y optimiza continuamente.

> [!note] Aclaración clave Las reuniones marcadas con ⭐ son lideradas por los **campaign managers**. En el caso del "list pull meeting", Guadalajara agenda la reunión y arma el list pull, pero **a solicitud** del campaign manager — la propiedad del requerimiento sigue siendo de campaña.

---

## 2. Detalle de ejecución (Anu)

### Orden de trabajo

- El desarrollo arranca **solo después** de que el creativo en Figma esté aprobado (etapa _"uproot creative"_).
- Se construye primero en **inglés** — nunca todos los idiomas en paralelo (riesgo de caos y error manual ante cambios de último momento).

### Data / List Pool

- El **list pull / data list request** define qué campo trae qué valor (`F_name`, `date_expiry`, etc.).
- Se prepara en paralelo a la revisión del Figma — idealmente listo el mismo día del walkthrough.
- Junto con el Figma, es lo mínimo que el equipo de HTML necesita para arrancar.

### Rondas de revisión

- **Alpha**: autovalidación interna (developer → segundo developer → Kamaria/GALE).
- **Beta**: revisión del cliente (IHG).
- Feedback típico: typos, alineación, formatos de fecha regionales (MX/US/India difieren).

### Traducciones

- SLA estándar: **10–15 días** (incluye buffer).
- Solicitudes urgentes → se priorizan a través de Kamaria.

### Pre-deployment

- Antes de salir a producción se usa **data en vivo** (no dummy) para un proof final — detecta sorpresas que el test data no anticipa.

### Monitoreo post-deploy

- **Golden hour check**: primera hora tras el envío.
- **Check del día siguiente**: para campañas grandes (millones de contactos, envío distribuido en 8–9h).

### Push notifications

- Proceso similar pero más corto; normalmente solo en inglés (global/US), salvo excepciones multilenguaje.

---

## 3. Mapa de stakeholders (Kamaria)

|Persona/Equipo|Rol|
|---|---|
|Megan, Matt|Campaign managers — desarrollan campaña/estrategia, aprueban proofs|
|[[Raunak]]|Data — provee archivo de audiencia, trabaja con GT (General Technology)|
|Krishna, Jessica, Connor|Martech — dueños de **Data Cloud / Loyalty data** (emails triggered)|
|Loyalty team|Configura ofertas Evergreen y **privadas** (elegibilidad de miembros)|
|Sarah Kulp, Jason Longnecker|Marketing Effectiveness — insights de performance, channel shift|

> [!tip] Dato útil ~75–80% de los emails usan datos de **CDP** (vía Raunak); el resto (emails triggered, ej. _milestone rewards_) usa **Data Cloud/Loyalty**, propiedad del equipo de Krishna.

---

## 4. Proceso GAIL–IHG CRM completo (Kapil)

### 4.1 Briefing

- IHG entrega el **briefing document** (requisitos) a GAIL — compartido con el _client partner_.
- Se destaca que los briefs de IHG son de alta calidad: incluyen KPIs, canal, módulos históricos, librería de imágenes.

### 4.2 Estrategia

- El equipo de estrategia toma el brief, itera con el campaign manager, ajusta scope/audiencia.
- PM aún no tiene rol activo aquí, pero se mantiene cerca para anticipar riesgos de timing/esfuerzo.
- Al aprobarse scope y timeline → se arma el **work-back schedule**.

### 4.3 Copy y Creativo

- Copywriters generan el **copy deck** (tono de marca, subject lines alternativos, ubicación de dinámicos/CTAs).
- Copy aprobado → pasa a equipo creativo → construye en **Figma** (múltiples rondas: 1, 2, 3… hasta _"approved creative"_).
- ⚠️ Cualquier cambio de copy post-Figma debe reportarse al equipo de copy/creativo para mantener ambos documentos alineados.

### 4.4 CRF (Campaign Request Form)

- Documento **fuente de verdad** para el equipo de desarrollo — mismo formato para **todas** las campañas.
- Lo arma el **Business Analyst** (Isa/Ezer), llenándolo con:
    - Contenido dinámico y reglas de negocio
    - Matriz de links (incluye tracking)
    - Audience split / lógica de journey
- Se nutre de: comms plan (Matt), list pool (Raunak), Figma aprobado.
- Es el **"punto de no retorno"** antes de handoff a desarrollo (Bangalore).

### 4.5 Kickoff con desarrollo (Bangalore)

- Se socializan assets antes del kickoff formal para evitar sorpresas de capacidad.
- Desarrollo construye con dummy data o test data real (si está disponible).

### 4.6 Testing — Alpha / Beta

|Ronda|Quién revisa|Idioma|
|---|---|---|
|Alpha|Interno GAIL (visual QA + PM)|US English|
|Beta|Campaign manager (IHG)|US English|
|Alpha (2)|Interno GAIL|Traducciones|
|Beta (2)|Campaign manager (IHG)|Traducciones|

- Visual QA tiene checklist propio: headers, footer, T&Cs, links, CTAs, módulos, **accesibilidad (ADA/alt text)**.
- Feedback se centraliza en **Smartsheet** (tracker de alpha/beta por campaña).

### 4.7 Traducciones

- **Smartling = fuente de verdad** (no Google Translate).
- Google Translate se usa como **doble-chequeo**, no como referencia oficial.
- Discusión relevante: diferencias de estructura gramatical en idiomas asiáticos/latinos pueden _parecer_ errores sin serlo — se requiere criterio entrenado.
- Regla práctica: escalar solo si el error cambia **intención, contexto o promoción** — no por diferencias de forma.

### 4.8 Pre-launch / Deployment

- Antes del deploy: refresh de la data extension con **data en vivo** (Raunak).
- Proof final con data real hacia campaign manager / Kamaria (y a veces leadership).
- Se documenta todo en el **Deployment Plan** (setup técnico completo en Marketing Cloud, decisiones de split, nombres de DE) — archivado en **SharePoint IHG** por campaña (histórico desde 2023/2024).

### 4.9 Monitoreo

- Golden hour check (~1h post-envío, a veces se detectan fallas incluso a los 15 min).
- End-of-day check (aprovechando diferencia horaria con Bangalore).

### 4.10 Cierre del ciclo

- Aprendizajes se retroalimentan al equipo de estrategia para futuras campañas.

---

## 5. Herramientas mencionadas

- **Smartsheet** → work-back schedule, alpha/beta tracker, feedback log (162+ líneas por campaña)
- **Figma** → creativo aprobado
- **Smartling** → traducciones (fuente de verdad)
- **Google Translate** → doble-chequeo de traducciones
- **SharePoint (IHG)** → repositorio de deployment plans históricos
- **Gmail compartido** → envío/recepción de proofs

---

## 6. Preguntas abiertas / seguimiento

- [ ] Posible sesión dedicada al proceso de **QA en traducciones** (quién es responsable de detectar qué)
- [ ] Confirmar nombre de la herramienta de accesibilidad (ADA) usada por Visual QA — _pendiente de Laura_
- [ ] Últimos 2-3 días de la capacitación: **hands-on** de build + proceso de traducción (sin llegar a submit real, por costo)

---

## 7. Notas laterales (contexto de equipo)

- Oscar es de Mazatlán, Sinaloa; Tamara menciona ser de un pueblo en la línea Jalisco/Nayarit.
- Feedback positivo sobre los breaks de 10 min entre sesiones — se mantienen para próximas sesiones.
---
aliases:
  - "Resumen del Proceso LFC"
  - "Proceso Completo de Campañas LFC"
tags:
  - glosario
  - lfc
  - sfmc
  - proceso
  - reference
created: 2026-08-11
status: Active
---

# Resumen del Proceso Completo de Campañas LFC

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[Resumen del Proceso Completo de Campañas LFC]]
> WHERE file.path != this.file.path
> ```

> [!info] Qué es esta nota
> Recorrido narrativo de punta a punta del proceso de una campaña [[LFC]], desde la necesidad de negocio hasta el cierre y la retroalimentación a estrategia — construido a partir de todas las sesiones de onboarding documentadas en el vault. Es el mapa general; cada etapa enlaza a la nota que la cubre en detalle. Para definiciones puntuales de cada término, ver el [[Glosario de Términos y Herramientas LFC]]. Para el flowchart técnico condensado (sin narrativa), ver [[End-to-End Flow]].

## El ciclo, en una frase

```text
Necesidad de negocio → Estrategia → Creativo → Delivery → Ejecución → Mantenimiento
```

El ciclo **nunca termina**: cada campaña se revisa, actualiza y optimiza continuamente, y los aprendizajes de monitoreo retroalimentan a estrategia para la siguiente iteración.

---

## 1. Necesidad de negocio y briefing

Todo comienza con El Grupo entregando un **briefing document** a La agencia — requisitos, KPIs, canal, módulos históricos, librería de imágenes. El equipo de estrategia toma el brief, itera con el campaign manager, ajusta scope y audiencia, y al aprobarse arma el **work-back schedule** que va a marcar el ritmo de todo lo que sigue.

## 2. Copy y creativo (Figma)

Los copywriters generan el **copy deck** (tono, subject lines alternativos, ubicación de dinámicos/CTAs). Ese copy aprobado pasa al equipo creativo, que construye en **[[Figma Assets|Figma]]** — normalmente varias rondas (1, 2, 3…) hasta llegar a "approved creative". Cualquier cambio de copy después de este punto debe reportarse de vuelta al equipo de copy para que ambos documentos no se desalineen.

## 3. List Pull (en paralelo al Figma)

Mientras el Figma avanza, el **developer de La agencia redacta y organiza el List Pull** — a solicitud del campaign manager, que mantiene la propiedad del requerimiento — y lo revisa/valida junto con el **equipo de Datos** (Raunak), que construye la Data Extension real siguiendo exactamente lo que dice el documento. Junto con el Figma, es lo mínimo que desarrollo necesita para poder arrancar. Es también la base de la que depende **todo** lo que viene después: si un atributo está mal aquí, tanto el build como los test cases terminan validados contra el dato equivocado sin que nadie lo note — por eso nunca se avanza sin esa validación conjunta.

## 4. CRF — el punto de no retorno

El **[[CRF]]** lo arma el Business Analyst, nutriéndose del comms plan, el List Pull y el Figma ya aprobado: contenido dinámico, reglas de negocio, matriz de links/tracking, audience split. Es el documento fuente de verdad para desarrollo y marca el **handoff formal** hacia el equipo de build (mayormente en Bangalore).

## 5. Build técnico

El desarrollo arranca **solo después** de que el creativo está aprobado, y siempre se construye primero en **inglés (USEN)** — nunca todos los idiomas en paralelo, para evitar caos si hay cambios de último momento. El build combina:

- **[[AMPscript]]** para toda la lógica dinámica — declaración de variables, branching por [[Content ID]], singular/plural, traducción de tier vía `Lookup()`, módulos condicionales con Impression Regions.
- **[[Shared Content Blocks]]** y **[[Dynamic Date Block]]** — siempre se busca si ya existe un bloque reutilizable antes de construir uno nuevo.
- **[[Email Properties]]** — Campaign Tag, Category Tag, MRM ID y Language Parameter, que controlan header/footer/unsub block y tracking.
- Para el detalle práctico de un build real con código, ver [[LFC_20260508_Lifecycle Email Build & Journey Setup]] y [[LFC_20260511_Tier Translation Logic & Dynamic Content QA]].

## 6. QA interno — Alpha y Beta

Antes de que nada salga del equipo, pasa por **Alpha** (revisión interna: developer → segundo developer → lead) y luego **Beta** (revisión del cliente, El Grupo). El **Visual QA** tiene su propio checklist: headers, footer, T&Cs, links, CTAs, módulos, accesibilidad (alt text, ARIA labels). Todo el feedback se centraliza en el **Feedback Tracker (Smartsheet)** — nunca por mensaje suelto. Para la metodología completa de test cases (subject line, contenido, links, rendering cross-cliente, otros idiomas), ver [[LFC_20260623_La agencia QA Test Case Methodology & Feedback Tracking]] y la nota general de [[QA Process]].

## 7. Traducción (Smartling)

Una vez aprobado en inglés, el email se duplica en una subcarpeta dedicada y se envía a **[[Smartling]]** — la fuente de verdad para traducciones (Google Translate solo como doble-chequeo interno). Dos matices importantes:

- **Subject y preheader son la excepción**: Smartling no los traduce; van por un formulario de localización separado. Ver [[Subject & Preheader Localization]].
- **El AMPscript nunca se toca** — ni la lógica dinámica ni las palabras que viven dentro de declaraciones de variable (esas se extraen y se envían aparte, en un documento de contenido dinámico).

Cuando las traducciones regresan, hay que actualizar el region language code placeholder de cada versión, pegar el subject/preheader traducido, y reemplazar manualmente las palabras dinámicas en el AMPscript. El flujo completo, con capturas de cada paso, está en [[LFC_20260512_Comprehensive Onboarding for Email Campaign Development and Deployment]].

## 8. Journey Builder

Con el email/push ya construido y traducido, se arma el journey en **[[Journey Builder]]**:

1. **Entry Source** — la Data Extension correcta, la decisión más crítica (la mayoría de errores de lanzamiento vienen de una fuente equivocada, no de un canvas roto).
2. **Decision splits** — típicamente: mailing date = hoy, luego idioma (excluyendo todos los códigos de inglés antes de separar English/non-English), luego sub-splits por variante regional.
3. **Configuración del journey** — reentry (única vez vs. recurrente), exit criteria (`SubscriberKey is not null`), high throughput solo para audiencias grandes.
4. **Datos de prueba seguros** — nunca se edita la DE real; se usan registros reales con subscriber key/email sobrescritos por direcciones de prueba.

## 9. Deployment Plan

Solo cuando el build **y** el QA están 100% terminados se construye el **[[Deployment Plan]]** — nunca en paralelo al desarrollo, porque los cambios constantes durante el build desincronizarían el documento. Centraliza historial de revisiones, propósito del journey, detalles de la DE, y capturas de la configuración completa. Se archiva en SharePoint por proyecto.

## 10. Validación final y walkthrough

Antes de activar: un **live proof** con datos reales (no test data) para atrapar sorpresas que el test data no anticipa, y un walkthrough del journey con los marketing managers donde se explica la configuración completa y se hace una validación en vivo en la misma llamada. Solo con luz verde de ese walkthrough se activa el journey.

## 11. Activación y monitoreo post-lanzamiento

Tras activar, dos checks son obligatorios:

- **Golden Hour Check** — dentro de la primera hora, revisar en Interactions/Triggered Emails que el envío corre sin errores.
- **End of Day Check** — al final del día (a veces manejado por el equipo de Bangalore por diferencia de zona horaria), confirmar que la cola se completó y reconciliar conteos.

Cualquier problema detectado en estos checks se trata como **P0** y se resuelve de inmediato — es, en la práctica, la única vez que el equipo usa una escalación de prioridad formal.

## 12. Monitoreo continuo y cierre

Pasada la ventana crítica de 24 horas, el monitoreo continúa vía **Tableau** y el reporte diario **ESSR** (Email Send Summary Report) para los journeys always-on. Ver [[Monitoring]] y [[LFC_20260508_Marketing Cloud Journey Monitoring & Reporting]]. Los aprendizajes de esta etapa — qué funcionó, qué generó reclamos, qué patrón de datos sorprendió al equipo — se retroalimentan al equipo de estrategia, cerrando el ciclo para la siguiente campaña.

---

## Casos especiales que rompen el flujo estándar

No todas las campañas siguen esta secuencia limpia. Vale la pena conocer estas excepciones:

| Caso | Por qué se desvía |
|---|---|
| **Proyectos de Data Cloud/Loyalty Cloud** (ej. cambios de tier, cancelación de vouchers) | El dato no viene del equipo de datos habitual sino de Salesforce Data Cloud, con delay de sincronización variable — requieren una fase de "mock setup" (1–2 semanas sin enviar) antes de activar en vivo. Ver sección 6 de [[LFC_20260512_Comprehensive Onboarding for Email Campaign Development and Deployment]]. |
| **Ad hoc complejos** (ej. Points Expiration) | Pueden tener problemas de clasificación commercial/transactional con implicaciones legales (CAN-SPAM) — ver sección 5 de la misma nota. |
| **Proyectos donde el desarrollador construye su propia query** (ej. Milestone Rewards 2025) | El Deployment Plan se desvía de la plantilla estándar para documentar también la automatización/query — puede crecer a cientos de páginas. |
| **Reservation Confirmation (Rescon)** | Escala de complejidad excepcional (miles de test cases, mock data creada con un partner externo, ambiente de staging con logins simulados) — solo ha ocurrido una vez en 2 años. |

## Relacionado

[[Glosario de Términos y Herramientas LFC]]
[[LFC]]
[[End-to-End Flow]]
[[00 - Índice de Onboarding LFC]]
[[00 - Marketing Cloud Onboarding]]
[[Mejores Prácticas de Desarrollo LFC]]

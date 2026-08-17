---
aliases:
  - "Glosario LFC"
  - "Glosario de Términos LFC"
  - "Glosario de Términos y Herramientas LFC"
tags:
  - glosario
  - lfc
  - sfmc
  - reference
created: 2026-08-11
status: Active
---

# Glosario de Términos y Herramientas LFC

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[Glosario de Términos y Herramientas LFC]]
> WHERE file.path != this.file.path
> ```

> [!info] Qué es esta nota
> Referencia rápida de todos los documentos, herramientas, roles y siglas que aparecen a lo largo del onboarding LFC — construida a partir de las sesiones de capacitación y las notas técnicas del vault. Los términos que ya tienen su propia nota de referencia aparecen como wikilink; los que no, tienen su definición completa aquí mismo. Para el recorrido narrativo del proceso completo, ver [[Resumen del Proceso Completo de Campañas LFC]].

## Documentos y fuentes de verdad

> [!tip] Línea de tiempo completa
> Para ver cuándo aparece cada documento dentro del ciclo de una campaña (qué se prepara en paralelo, qué es continuo, orden real) ver [[Documentos del Proceso LFC]].

| Término                                          | Qué es                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| ------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Briefing document**                            | Documento inicial que El Grupo entrega a La agencia con los requisitos de la campaña — KPIs, canal, módulos históricos, librería de imágenes. Punto de partida de todo el ciclo.                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| **Comms plan**                                   | Spreadsheet que mapea la **secuencia completa de touch-points** de una campaña multi-touch (ej. anuncio → recordatorio de registro → recordatorio de booking → completion) y a qué stage pertenece cada uno. Lo arma el **campaign manager** del lado El Grupo (ej. Matt) y es una de las tres fuentes que nutren al CRF, junto con el List Pull y el Figma aprobado. Se consulta junto con el List Pull antes de construir un asset, para saber a qué stage pertenece y qué DE lo alimenta. Distinto del **Master Deck** (documento estratégico más amplio, uno por fase de #LFC: Educate/Engage/Nurture/Retain). |
| **[[CRF]]** (Campaign Requirements/Request File) | El documento **fuente de verdad** para desarrollo — mismo formato para todas las campañas. Lo arma el Business Analyst con contenido dinámico, reglas de negocio, matriz de links/tracking y audience split. Es el "punto de no retorno" antes del handoff a desarrollo.                                                                                                                                                                                                                                                                                                                                           |
| **List Pull / List Pool**                        | Documento que define qué campo de la Data Extension trae qué valor — la base para escribir tanto el AMPscript como los test cases. Lo **redacta/organiza el developer de La agencia** (a solicitud del campaign manager, que mantiene la propiedad del requerimiento), y se **revisa y valida junto con el equipo de Datos**, que construye la Data Extension real siguiendo exactamente lo que dice el documento. Se prepara en paralelo a la revisión del Figma.                                                                                                                                                 |
| **Copy deck**                                    | Documento de los copywriters: tono de marca, subject lines alternativos, ubicación de contenido dinámico y CTAs — insumo para el equipo creativo antes de construir en Figma.                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| **Master Deck**                                  | Documento extenso, uno por cada fase de #LFC (Educate, Engage, Nurture, Retain), con overview estratégico, user journey, overview de comunicaciones y el detalle de cada email de esa fase. Se consulta para entender el contexto de negocio completo de una fase antes de trabajar en ella — más amplio y estratégico que el Comms Plan, que es específico de una campaña.                                                                                                                                                                                                                                        |
| **[[Figma Assets\|Figma]]**                      | Fuente oficial de todos los assets de diseño. Se exporta siempre en 2x. Puede incluir variantes de subject/preheader por tier o por idioma. Pasa por múltiples rondas (1, 2, 3…) hasta "approved creative".                                                                                                                                                                                                                                                                                                                                                                                                        |
| **Work-back schedule**                           | Cronograma con la fecha límite de cada asset/entregable de la campaña, usado para planear traducciones, QA y deployment.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| **[[Deployment Plan]]**                          | Documento en SharePoint que centraliza todo el detalle técnico de un proyecto: historial de revisiones, propósito, detalles de la Data Extension, capturas del journey, schedule y decision splits. Se construye **después** de que el build y el QA están completos, nunca en paralelo.                                                                                                                                                                                                                                                                                                                           |
| **Test Case Document**                           | El documento central del proceso de QA de La agencia — segregado por email y por push, con hojas por cada email de la campaña e hipervínculos entre ellas.                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| **Feedback Tracker (Smartsheet)**                | Documento donde se registra cada hallazgo de QA (ronda, quién lo encontró, captura, respuesta del desarrollador) — reemplaza el feedback suelto por chat, que es imposible de rastrear a escala.                                                                                                                                                                                                                                                                                                                                                                                                                   |
| **URL Metrics sheet**                            | Hoja con la matriz de links y sus parámetros de tracking, usada como referencia al construir y validar cada URL del email.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| **ESSR** (Email Send Summary Report)             | Reporte diario (~2 veces al día) que resume los envíos de los últimos 7 días para los journeys **always-on**; resalta caídas/incrementos >25% y "zero sends".                                                                                                                                                                                                                                                                                                                                                                                                                                                      |

## Plataformas y herramientas

| Herramienta | Para qué se usa |
|---|---|
| **Salesforce Marketing Cloud (SFMC)** | La plataforma central donde se construyen, personalizan, envían y monitorean los emails/push. |
| **Content Builder** | Módulo de SFMC donde se construye el email/push (bloques, AMPscript, contenido compartido). |
| **[[Journey Builder]]** | Orquesta el envío: conecta una Data Extension de entrada con la actividad de canal correcta. |
| **Automation Studio** | Automatizaciones programadas en SFMC (queries SQL, refresh de datos, importaciones). |
| **Query Studio** | Para correr manualmente una query SQL contra las Data Extensions — útil para verificar datos sin depender del preview de la plataforma. |
| **Contact Builder** | Para buscar contactos por email/subscriber key y revisar su historial de envíos y estado de suscripción. |
| **Data Cloud / Loyalty Cloud** (Salesforce) | Origen de ciertos disparadores basados en cambios de comportamiento del miembro (ej. cambio de tier) — se sincronizan hacia Marketing Cloud con delay variable. |
| **[[Smartling]]** | Plataforma de traducción — la fuente de verdad para todas las traducciones (no Google Translate). |
| **Google Translate** | Se usa únicamente como doble-chequeo interno, nunca como referencia oficial. |
| **SharePoint (El Grupo)** | Repositorio donde se archivan los Deployment Plans históricos, por campaña. |
| **Smartsheet** | Herramienta para el work-back schedule y el feedback tracker de QA. |
| **Email on Acid / Litmus / Inbox Monster** | Herramientas de rendering cross-cliente y cross-dispositivo — permiten validar cómo se ve un email en combinaciones de cliente/SO/modo oscuro sin tener cada dispositivo físico. **Litmus está visible dentro del tab Preview and Test de SFMC, pero el equipo no tiene acceso** — por eso la herramienta realmente usada para esto es Email on Acid (junto con Inbox Monster del lado El Grupo). |
| **Text compare tool** | Herramienta para comparar bloques de texto largos (ej. Terms & Conditions) contra el Figma, resaltando diferencias palabra por palabra. |
| **Tableau** | Herramienta de monitoreo/reporting post-envío — ventana crítica de revisión: primeras 24 horas. |
| **ServiceNow (mySupport)** | Portal corporativo de soporte de El Grupo — tickets, solicitudes de acceso, incidentes. |
| **Gmail compartido de prueba** | Cuenta de correo compartida (ej. `gale.ihgqa@gmail.com`) usada para todos los proofs internos — con acceso controlado y organizada por labels de proyecto/ronda. |

## Conceptos técnicos de SFMC / AMPscript

| Término | Qué es |
|---|---|
| **[[AMPscript]]** | Lenguaje de scripting de SFMC para personalizar contenido — se ejecuta del lado del servidor, de arriba hacia abajo. |
| **[[Content ID]]** | Atributo que determina qué variante de contenido (subject, preheader, dynamic content, oferta, traducción) recibe cada registro. |
| **[[Data Layer\|Data Extension (DE)]]** | Tabla de datos en SFMC — la unidad base de personalización y segmentación. |
| **[[TreatAsContent]]** | Función que interpreta un string almacenado como si fuera código AMPscript/HTML real, en vez de mostrarlo como texto literal. |
| **[[Shared Content Blocks]]** | Bloques de contenido reutilizables (header, footer, legal copy, fechas dinámicas) — filosofía: buscar si ya existe antes de construir de cero. |
| **[[Dynamic Date Block]]** | Bloque compartido que formatea fechas según el locale/region language code. |
| **Impression Region** (`Begin`/`End Impression Region`) | Sintaxis AMPscript que marca qué bloque de HTML cuenta como una sola impresión para efectos de reporting — va fuera del `IF`/`ENDIF` aunque envuelva un módulo condicional. |
| **Region Language Code** | Atributo que identifica idioma+mercado de un contacto (ej. `USEN`, `AMJP`) — controla qué header/footer/unsub block/contenido dinámico se renderiza. Ver tabla de códigos más abajo. |
| **Entry Source** | La Data Extension que alimenta el journey — la decisión más crítica del journey, ya que determina quién entra. |
| **Decision Split** | Punto de ramificación dentro de un journey según una condición (idioma, mailing date, tier, etc.). |
| **Exit Criteria** | Condición de salida de un journey — el estándar más común es `SubscriberKey is not null`. |
| **Reentry** (No re-entry / Allow re-entry) | Configuración de si un contacto puede volver a entrar al mismo journey — depende de si el touch-point es único o recurrente. |
| **High Throughput Sending** | Configuración de journey que acelera el envío para audiencias muy grandes (cientos de miles+) — reduce un despliegue de 8–9h a 2–3h. |
| **[[Email Properties]]** | Campaign Tag, Category Tag (siempre "LFC"), MRM ID y Language Parameter — controlan tracking y qué contenido regional se renderiza. |
| **[[Tracking\|EM / LM]]** | EM = Email (tracking de aperturas/clics del email); LM = Link Metrics (tracking por link específico). |
| **[[Subject & Preheader Localization]]** | El flujo de traducción de subject/preheader es una excepción — Smartling NO los traduce; van por un formulario separado y se almacenan en una Translation DE. |
| **Auto-suppression DE** | Data Extension conectada a una relación de datos de Contact Builder — nunca se edita directamente, o se rompe la relación con todos los journeys conectados. |
| **Standard Segmentation** | Capa de segmentación sobre Contact Data usada como fuente del journey, en vez de la DE compartida cruda. |
| **Seed List / Internal Test List** | Lista pequeña reservada para revisión interna antes de activar un journey real — distinta de las DEs de producción/predicción. |
| **Mailing Date checkpoint** | Primer decision split de casi todo journey — compara la fecha de refresh de la DE contra "hoy", para evitar enviar con datos desactualizados. |

## Roles y equipos

| Rol / Equipo | Función |
|---|---|
| **La agencia** | Agencia/equipo que ejecuta el desarrollo — oficinas en Guadalajara (delivery/PM) y Bangalore (~90% del build y del testing). |
| **El Grupo** | El cliente — dueño de la marca, la estrategia y la aprobación final de cada campaña. |
| **Campaign Manager** | Dueño del requerimiento de negocio del lado El Grupo (ej. Megan, Matt) — desarrolla la estrategia y aprueba los proofs. |
| **Business Analyst (BA)** | Arma el CRF con toda la información técnica y de negocio necesaria para desarrollo. |
| **Equipo de Datos** (Raunak, Prasad) | Provee el List Pull, mantiene las Data Extensions de producción/prueba, refresca la data antes del deploy final. |
| **Martech / Data Cloud team** (Krishna y equipo) | Dueños de los datos de Data Cloud/Loyalty — power los emails triggered por cambio de comportamiento (ej. cambio de tier). |
| **Loyalty Team** | Configura ofertas Evergreen y privadas — define elegibilidad de miembros. |
| **Marketing Effectiveness** | Equipo de insights de performance y channel shift — retroalimenta a estrategia. |
| **QA Team** (Anu y equipo Bangalore) | Ejecuta el testing completo — test cases, rendering, traducciones, revisión de journey. |
| **Platform Team** (ej. Sumanth) | Valida la configuración técnica del journey **antes** de que llegue a QA — QA no debe ser la primera línea de defensa. |
| **Developer** (ej. Oscar) | Construye el email/push y el journey en SFMC. |
| **Project Manager** (ej. Tamara, y Mita del lado Bangalore) | Coordina timelines, feedback tracker y comunicación entre equipos/zonas horarias. |

## Region Language Codes

Tabla completa de locale → region/language code → path web, con su fuente oficial (SharePoint El Grupo), ahora vive en su propia nota: **[[Region Language Codes]]**.

## Tipos de campaña (ejemplos reales usados en el onboarding)

| Campaña | Qué es |
|---|---|
| **FTD** (Fast Track to Diamond) | Campaña de 3 emails (registro, booking, completion) + push, usada como ejemplo de entrenamiento de QA. |
| **Rescon** (Reservation Confirmation) | El proyecto más grande y complejo documentado — miles de test cases, múltiples marcas; solo ocurrió una vez en 2 años. |
| **Next Day** | Serie de campañas (A–F) corriendo simultáneamente, cada una con oferta de 10K/20K puntos. |
| **Nurture** | Campaña recurrente trimestral (Q1, Q2, Q3, Q4) — buen ejemplo de reutilización de plantillas de test cases. |
| **Anniversary / Anniversary Offer Completion** | Campaña de aniversario del miembro. |
| **Points Expiration** | Comunicaciones automáticas (día 7/30/60 antes de expirar) — reclasificadas a transactional tras un problema de opt-out documentado. |
| **Milestone Rewards** | Proyecto de 2025 donde el desarrollador construyó su propia query — el Deployment Plan resultante llegó a 305 páginas. |

## Rondas y checks de QA

| Término | Qué es |
|---|---|
| **Alpha** | Ronda de revisión interna (developer → segundo developer → lead) — primer filtro antes de mostrarle nada al cliente. |
| **Beta** | Ronda de revisión con el cliente (El Grupo / campaign manager). |
| **Pre-alpha** | Capa adicional agregada tras 2024 para atrapar errores incluso antes de la ronda Alpha formal. |
| **[[LFC_20260508_Marketing Cloud Journey Monitoring & Reporting|Golden Hour Check]]** | Verificación en la primera hora después de activar un journey — confirma que está enviando sin errores. |
| **End of Day Check** | Verificación al final del día (o al inicio del siguiente, según cobertura de zona horaria) de que la cola de envío se completó sin errores. |
| **Live Proof** | Proof final hecho con **data real** (no test data) justo antes de producción — detecta sorpresas que el test data no anticipa. |
| **Round 1 / 2 / 3** | Ciclos de revisión dentro del test case document — fail en Round 1 pasa al desarrollador, se revalida en Round 2, etc. |

## Niveles de tier / status de lealtad

`Club` → `Silver` → `Gold` → `Platinum` → `Diamond` — niveles de estatus del programa de lealtad El Grupo #OR, usados constantemente como base de personalización dinámica y de elegibilidad de audiencia en las campañas LFC.

## Relacionado

[[Resumen del Proceso Completo de Campañas LFC]]
[[LFC]]
[[QA Process]]
[[Translation Workflow]]
[[00 - Índice de Glosario]]

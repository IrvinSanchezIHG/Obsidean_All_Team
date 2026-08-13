---
aliases:
  - "Examen LFC Developer"
  - "LFC Developer Exam"
tags:
  - lfc
  - sfmc
  - developer-guide
  - assessment
  - reference
created: 2026-08-12
status: Active
---

# Examen LFC - Developer

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[Examen LFC - Developer]]
> WHERE file.path != this.file.path
> ```

> [!abstract]- Qué es esta nota
> 32 preguntas (conceptual, teórico, práctico) construidas sobre el contenido real del vault — no trivia genérica. Complementa [[Mejores Prácticas de Desarrollo LFC]] y el [[LFC_20260507_Lifecycle Email Development & Data Integration|Manual de Onboarding]]: mientras esas notas explican el proceso, esta evalúa si se entendió. Existe también como página interactiva: [Examen LFC — Developer (artifact)](https://claude.ai/code/artifact/3dbba509-6013-4bcf-b0e3-4040e7e7bf4f).

> [!tip] Mecánica de comodines
> Hasta 5 comodines para hacerle una pregunta al examinador durante el examen. Cada pregunta se evalúa aparte y puede sumar o restar puntos — criterio y valor exacto pendientes de definir con el manager (ver tabla al final).

## Sección 1 · Conceptual (12 preguntas)

1. ¿Qué es el [[CRF]] y qué tres fuentes lo nutren?
2. ¿Qué diferencia hay entre la carpeta "Working" y la carpeta "Final DE" de Data Extensions?
3. Menciona al menos 3 elementos que controla el Region Language Code en un email.
4. ¿Qué es el [[Link Matrix (LinkHelper)]] y quién entrega el contenido de origen de las URLs?
5. ¿Qué dos cosas NO traduce [[Smartling]]?
6. ¿Qué es un [[Content ID]] y para qué se usa?
7. Nombra los 4 tipos de prueba del flujo LFC y qué valida cada uno.
8. ¿Qué es el [[Deployment Plan]] y dónde se archiva?
9. ¿Qué diferencia hay entre la ronda Alpha y la ronda Beta de QA?
10. ¿Qué función de [[AMPscript]] usarías para interpretar un string almacenado como si fuera código/markup renderizable?
11. ¿Qué es la regla USCN?
12. La regla de "avisar con 2 semanas de anticipación" aplica a dos tipos de cambio — ¿cuáles?

## Sección 2 · Teórico (10 preguntas)

1. ¿Por qué nunca se debe enviar a traducción inmediatamente después de terminar el desarrollo de USEN?
2. ¿Por qué el Deployment Plan se construye hasta que el build y el QA están 100% terminados, y no en paralelo?
3. Explica por qué el primer split de idioma en [[Journey Builder]] usa lógica negativa (exclusión con AND) en vez de OR.
4. ¿Por qué la validación de plataforma de Journey Builder no es suficiente por sí sola antes de activar?
5. ¿Por qué es tan importante avisar a Analytics cuando cambia el nombre de un email o campaña?
6. ¿Por qué el Link Matrix DE la construye el equipo de desarrollo y no el Data Team, aunque es "datos"?
7. Explica la diferencia funcional entre QA Test y Live Proofing — ¿por qué ninguno reemplaza al otro?
8. Si la personalización se rompe de forma dispersa en varios emails no relacionados, ¿por qué se debe sospechar primero de un cambio upstream en la fuente de datos?
9. ¿Por qué nunca se pausa un journey o automation "solo para ver" su configuración?
10. ¿Por qué el Region Language Code del registro de prueba puede hacer que un proof parezca tener un bug de código cuando en realidad el AMPscript está bien?

## Sección 3 · Práctico (10 preguntas)

1. Un decision split usa este filtro de entrada: `SubscriberKey is null`. ¿Qué está mal y cuál es el fix?
2. Un email de aniversario muestra el nombre en blanco para un solo contacto. Da 2 causas probables y en qué orden las descartarías.
3. Llega un reclamo: un miembro no recibió su aviso de expiración de puntos (día 7). ¿Qué dos herramientas usarías para investigar, y qué gotcha crítico debes recordar en una de ellas?
4. Te piden construir el Link Matrix DE de una campaña nueva. ¿De dónde sale el contenido de las URLs y qué estructura (filas/columnas) debe tener la DE?
5. Un journey en producción sigue jalando de la DE de prueba. ¿En qué checklist debió haberse atrapado esto antes de activar?
6. Recibes la traducción de Smartling y el email sigue mostrando el logo/footer en inglés aunque el copy ya está traducido. ¿Qué paso se saltaron?
7. Un campo que viene de Data Cloud (ej. `offer_opt_in`) no tiene rama para el caso null, y el journey solo maneja "Y". ¿Qué les pasa a los contactos cuyo valor no se sincronizó a tiempo, y cuál es el fix estándar documentado?
8. Estás armando los [[QA Process|Test Cases]] de un subject line con first name + tier + noches. Da 3 escenarios mock obligatorios más allá del caso feliz.
9. Dentro de la rama de inglés, separas American English de Global English. ¿Qué operador lógico usarías (AND u OR) y por qué es distinto al primer split de idioma?
10. Te piden clasificar un correo automático de expiración como commercial o transactional. ¿Qué factor real determina la clasificación correcta, y qué consecuencia legal tiene clasificarlo mal?

## Comodines usados

| Comodín | Pregunta hecha | Categoría | Puntos |
|---|---|---|---|
| 1 | | | |
| 2 | | | |
| 3 | | | |
| 4 | | | |
| 5 | | | |

> [!warning] Pendiente
> Valor en puntos por categoría (sumar/restar) todavía no definido con el manager — la tabla es solo el formato a llenar.

## Respuestas de referencia

> [!note]- Ver respuestas (autoevaluación — no sustituye el criterio del examinador en la sección práctica)
>
> **Conceptual**
> 1. El CRF es el documento fuente de verdad para desarrollo: contenido dinámico, reglas de negocio, matriz de links/tracking y audience split. Se nutre del comms plan, el List Pull y el Figma ya aprobado.
> 2. "Working" tiene DEs intermedias/staging — nunca se conecta un journey ahí. "Final DE" es la única carpeta válida como entry source de un journey de producción.
> 3. Header, footer, unsubscribe block, contenido dinámico/shared content blocks, y formato de fecha.
> 4. DE compartida (`LinkMatrix_[Campaña]_[Año]`) que resuelve cada link/CTA al mercado correcto vía `@linkhelper_rgn_lang`. El contenido de las URLs lo entrega el Campaign Team; el equipo de desarrollo construye la DE.
> 5. AMPscript (nunca lo toca) y subject line/preheader (van por un formulario de localización separado).
> 6. Atributo que determina qué variante de contenido (subject, preheader, oferta, traducción) recibe cada registro.
> 7. Internal Test (contenido/diseño), QA Test (tracking real), Live Proofing (calificación dinámica 1 a 1 con data real), Seed List (versión final a liderazgo con data dummy).
> 8. Documento único por proyecto en SharePoint que centraliza historial de revisiones, propósito, detalles de DE y configuración del journey.
> 9. Alpha = revisión interna (developer → segundo developer → lead). Beta = revisión del cliente.
> 10. `TreatAsContent()`.
> 11. Cualquier cambio en la versión USCN requiere reenvío completo del mail y rehacer la solicitud de traducción desde cero — no se parcha solo el fragmento modificado.
> 12. Actualización del List Pull y cambio de nombre de email/campaña.
>
> **Teórico**
> 1. Porque si USEN cambia después de enviarse a traducción, los cambios no se propagan solos a los demás idiomas — hay que replicarlos manualmente en cada uno.
> 2. Porque el email cambia demasiado durante el desarrollo; documentar en paralelo generaría reescritura constante y desincronización.
> 3. Por limitación de Journey Builder para armar muchos splits de golpe — la exclusión con AND agrupa correctamente a "todo lo que no es ninguno de los códigos de inglés" en una sola rama.
> 4. Solo confirma que el setup es técnicamente aceptable para la plataforma — no confirma que la DE, el asset o el stage seleccionados sean los correctos de negocio.
> 5. Porque si Analytics no se entera, el dashboard muestra la línea de tendencia cayendo a cero, dando la falsa impresión de que se dejó de enviar la campaña.
> 6. Es una práctica del equipo de desarrollo para optimizar el contenido dinámico, no un entregable de segmentación/audiencia — por eso cae fuera del alcance del Data Team.
> 7. QA Test es la única forma de validar tracking (aliases, impression regions) antes del lanzamiento; Live Proofing es la única forma de confirmar que la calificación dinámica real del miembro coincide con lo que ve.
> 8. Porque un patrón disperso en el tiempo, no simultáneo, es la firma típica de un cambio en un sistema upstream ajeno a SFMC — no de un bug de AMPscript local en cada email.
> 9. Porque si se olvida reactivarlo, los clientes futuros dejan de recibir el correo silenciosamente, a veces sin que nadie lo note por días.
> 10. Porque el proof va a mostrar el idioma incorrecto aunque el AMPscript esté perfecto — es fácil confundir un registro mal elegido con un bug de código.
>
> **Práctico**
> 1. Excluye por accidente al 90% de los registros válidos. El filtro correcto es `SubscriberKey is not null`.
> 2. Campo faltante o naming distinto entre AMPscript y DE; o el registro de prueba no trae ese campo. Descartar comparando primero cada variable referenciada contra los nombres reales de campo y valores de muestra de la DE.
> 3. Contact Builder (rápido, ~1 año de historial) y Query Studio (SQL, más detalle). Gotcha: el lookback period por default de Query Studio es de solo 60 días — hay que ampliarlo o dirá falsamente que no se envió nada.
> 4. El contenido lo entrega el Campaign Team de El Grupo. Estructura: una fila por región/idioma, una columna por cada link/CTA, con el AMPscript de RedirectTo/Concat correspondiente.
> 5. Checklist final de activación del journey — verificación explícita de DE de producción antes de activar.
> 6. Actualizar el region language code placeholder en las Email Properties — sin eso, el AMPscript nunca jala el idioma correcto aunque el copy ya esté traducido.
> 7. Nunca reciben el correo (no solo tarde). Fix estándar: decision split explícito para null con wait steps de 4h, revalidando hasta 2 rondas (delay real observado hasta 8h).
> 8. Nombre en mayúsculas/minúsculas/mixed case, singular vs. plural (1 night vs 5 nights), y un valor null/fallback si el campo no es garantizado no-nulleable.
> 9. OR — porque aquí se prueba pertenencia a un grupo (cualquiera de varios códigos), no exclusión de todos como en el primer split.
> 10. Si es transaccional (notificación de cuenta) está exento de honrar el opt-out bajo CAN-SPAM; si es comercial, no. Clasificarlo mal como comercial puede hacer que miembros dados de baja nunca reciban un aviso crítico — como pasó realmente con Points Expiration antes de su reclasificación.

## Relacionado

[[Mejores Prácticas de Desarrollo LFC]]
[[LFC_20260507_Lifecycle Email Development & Data Integration]]
[[Resumen del Proceso Completo de Campañas LFC]]
[[QA Process]]
[[Link Matrix (LinkHelper)]]
[[Translation Workflow]]

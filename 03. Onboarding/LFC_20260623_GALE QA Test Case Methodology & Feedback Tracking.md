---
date: 2026-06-23
tags:
  - lfc
  - sfmc
  - qa
  - test-cases
  - testing
  - feedback-tracker
  - rendering
  - translations
  - onboarding
  - meeting-notes
type: meeting-notes
related:
  - "[[QA Process]]"
  - "[[LFC_20260508_Marketing Cloud Journey Monitoring & Reporting]]"
  - "[[LFC_20260512_Comprehensive Onboarding for Email Campaign Development and Deployment]]"
created: 2026-08-11
status: Active
---

# LFC Training — GALE QA Test Case Methodology & Feedback Tracking

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[LFC_20260623_GALE QA Test Case Methodology & Feedback Tracking]]
> WHERE file.path != this.file.path
> ```

> [!info] Contexto
> Sesión del 23 de junio de 2026, liderada por Anu (lead de QA del equipo GALE en Bangalore) para Francisco, un nuevo miembro del equipo de testing con experiencia previa en QA de sistemas de punto de venta y dispositivos médicos. Cubre, de punta a punta, el proceso completo de testing de GALE: el documento de test cases, validación de contenido/links/accesibilidad/rendering, QA de otros idiomas, testing de push, la revisión a nivel de journey (que no usa test cases escritos), el feedback tracker, y la evolución histórica del proceso de QA del equipo.

## 1. Contexto del equipo de testing

- La mayoría del **testing** ocurre en la oficina de GALE en **Bangalore** (equipo de Anu), no en Toronto ni en oficinas de EE. UU.
- El **build** de los emails también ocurre mayormente en Bangalore (~90%), con una porción parcial en EE. UU./Canadá.
- Por la diferencia de 12 horas con Bangalore, Anu asiste en vivo a las llamadas con el equipo de LFC/IHG y luego, por la noche (hora India), transmite el resumen completo a su equipo — feedback, decisiones, contexto — para que ellos retomen el trabajo con la información completa.
- El **test case document** es, en palabras de Anu, "el centro de todo el proceso de testing" — el documento único que cubre tanto email como push.

## 2. El documento de test cases — estructura y prerrequisitos

- **Estructura**: el documento se divide en múltiples hojas. La primera es la hoja **Overview**, que tiene hipervínculos a cada sub-hoja (una por email/push de la campaña) para navegar rápido. También incluye una sección con los documentos de referencia usados (Figma, CRF, List Pull) — con su versión específica (ej. "round 3", "production version"), para asegurar que todos estén viendo la misma versión aprobada.
- **6 secciones de navegación** en el panel izquierdo de cada hoja (sección de foto, módulo 1, módulo 2, etc.) para ubicarse rápido dentro de un email largo.
- El documento **es personalizable** — no es "una Biblia que hay que seguir exactamente igual".

> [!warning] Nunca escribir test cases sobre documentos en borrador
> Antes de empezar, siempre se revisa si el Figma, el CRF y el List Pull están **completamente aprobados** — si el Figma sigue en revisiones, se espera. Escribir test cases sobre un borrador significa tener que rehacerlos cuando el documento cambie, revisarlos de nuevo con el equipo, y perder mucho más tiempo del que se ahorra empezando temprano.

## 3. Cuánto tiempo toma escribir test cases

- La **primera vez** que se escriben test cases para un tipo de campaña nueva: 4 a 6 horas.
- Campañas **repetidas** (ej. Nurture Q1 → Q2 → Q3 → Q4 cada año): al reutilizar la plantilla ya creada, no debería tomar más de **2–3 horas**.
- **Excepción real**: el proyecto de **Rescon** (reservation confirmation email) generó **miles de test cases** repartidos en cientos de filas, across múltiples marcas — por la enorme cantidad de permutaciones (tier, país, moneda, tipo de pago, promo). En dos años de colaboración con IHG, ese nivel de complejidad solo se dio **una vez**.

## 4. Test cases de subject line y preheader

Usando **FTD (Fast Track to Diamond)** como ejemplo de entrenamiento — 3 emails (offer registration, booking, completion) + push:

- **Preheader estático**: un solo test case, para confirmar que coincide exactamente con lo que dice el Figma.
- **Subject line dinámico**: se prueba el campo variable (ej. el año) y el **first name** en sus distintas variantes de formato:
  - Proper case (`Oscar`)
  - Todo mayúsculas (`OSCAR`)
  - Todo minúsculas (`oscar`)
  - Mixed case (`OsCaR`)
  - La razón: la data cruda no siempre llega limpia, y en email development es estándar **normalizar el first name** (vía `ProperCase()`) para que el saludo se vea profesional sin importar cómo venga el dato.
- **Valores null**: se agrega un test case para "sin valor" (ej. mostrar "Dear Valued Customer") **salvo que el equipo de datos confirme que el campo es no-nulleable** — en este proyecto, Ronic confirmó que `first_name` no podía venir vacío, así que el equipo quitó ese test case. Si se trabaja con alguien que no sea Ronic, es buena práctica incluirlo de todas formas, por seguridad.
- **Content ID como parte del testing**: FTD tenía 4 subject lines distintos controlados por Content ID (`A1`–`A4`) — eso solo, multiplicado por las variantes de first name, generó **28 test cases** únicamente para subject line y preheader.

> [!warning] El List Pull es la base de todo
> Si el List Pull tiene un atributo incorrecto, tanto el build como los test cases terminan validados contra ese atributo equivocado — el error se propaga sin que nadie lo note. Por eso se revisa el List Pull con el equipo de datos (Ronic) **antes** de empezar a escribir test cases, y se recomienda incluir a QA en esa llamada de revisión.

### Columnas del documento de test cases

| Columna | Qué captura |
|---|---|
| Test case # / Test scenario | Identificador y descripción del caso |
| Atributos usados | Qué campos de la DE están involucrados |
| Condición primaria / condiciones adicionales | La lógica exacta que se está probando |
| Expected outcome / Actual status | Resultado esperado vs. lo observado |
| Comentarios adicionales | Contexto extra — el documento se comparte con GALE **e** IHG, así que ayuda a tener espacio para notas |

Ciclo de rondas: si el contenido no coincide, se marca **fail**, pasa al desarrollador, se corrige, y se revalida en **Round 2** (o Round 3 si hace falta). También existe el estado **blocker** cuando algo impide seguir probando.

## 5. Test data: estrategia de datos maestros

El equipo mantiene un **dataset maestro de prueba** que se reutiliza y recorta según el proyecto — no se recrea desde cero cada vez.

- La cantidad de test data necesaria depende de cuántos campos personalizados tiene la Data Extension: FTD (simple) solo necesitaba `first_name`, `content_id` y `custom1num`; Nurture (más rico) necesita además `chase_card`, `as_of_date`, niveles de tier y `custom2string` — más campos personalizados significa más combinaciones que cubrir.
- **Push necesita mucho menos test data**: sin contenido dinámico más allá de lo básico (member ID, subscriber key, email), no hace falta crear las 4–5 variantes de first name que sí se necesitan para email.

### Elegibilidad de tier por campaña

No todas las campañas aplican a los mismos niveles de tier — se determina leyendo el **criterio de targeting del List Pull**, no se asume:

- FTD Offer Registration: solo **Platinum** (audiencia calificada = miembros que aún no llegaron a Diamond pero están al menos en Platinum).
- Otro email de la misma campaña (downgrade): **4 niveles** (Club, Silver, Gold, Platinum).

Si no está claro cuántos niveles aplican, se pregunta directamente a Ronic — y **mientras Oscar desarrolla el List Pull con el equipo de datos, ya se debería estar pensando en qué preguntas hacer** para poder planear los test cases con esa misma llamada.

### Validación de colores por tier

Los bloques de contenido reutilizables (drag-and-drop en el email build) ya traen colores de tier pre-validados — el equipo no hace color-picking manual en cada envío porque, con más de 2 años de experiencia repitiendo el mismo trabajo, reconocen visualmente si un color está mal. Lo que sí se valida siempre es que **el tier correcto muestre el color correcto** (ej. dar test data de "Gold" y confirmar que no salga con el formato visual de "Silver").

## 6. Links: clic real, no solo comparación de string

> [!tip] No basta con comparar el URL esperado contra el real
> Comparar el string del URL contra lo documentado en el CRF es útil, pero **a veces las páginas de destino en IHG todavía no están listas** — la única forma de confirmarlo es haciendo clic y viendo que la página realmente carga. Por eso el equipo hace clic en **todos los links del email, de header a footer, incluyendo el privacy statement**, tanto en desktop como en mobile. Es más testing del estrictamente necesario, pero "hacer de más siempre es mejor que hacer de menos".

### Anatomía de una URL de tracking

Un link final incluye: **URL base** + **region language code** + slug de página + **parámetros de tracking**. Algunos parámetros son auto-generados por el sistema (ej. el MID, que sale de una concatenación basada en Email Properties); otros se agregan manualmente (ej. PID = business unit, u otros parámetros definidos en las propiedades del email). Al mínimo se valida que la URL base coincida; idealmente se hace clic y se renderiza la página.

Relacionado: [[CRF]] · [[Email Properties]]

## 7. Accesibilidad: alt text y ARIA labels

- **Alt text**: crítico por dos razones — (1) usuarios que no descargan imágenes automáticamente ven el placeholder con el alt text en su lugar, y (2) lectores de pantalla lo usan para describir la imagen a personas con dificultades de lectura.
- **ARIA labels**: se empezaron a incluir a partir del **Q1 de 2026**, por una petición del equipo legal derivada de **regulaciones europeas** — antes no era un requisito estándar del Figma.
- Ambos se validan **incluso antes del proof**, apenas Oscar dice que terminó el build — se revisa el email sin editar nada, comparando contra lo que especifica el Figma.

## 8. Rendering cross-cliente y dispositivo

Es técnicamente imposible probar manualmente cada combinación de cliente de correo (Outlook, Gmail, Yahoo…) × dispositivo (desktop, iOS, múltiples fabricantes Android). Para eso el equipo usa una herramienta de rendering (**Email on Acid**, similar en concepto a Litmus) — configurada con las combinaciones más frecuentemente usadas por la audiencia real (ej. Gmail app en Pixel 9/Pixel 7, modo oscuro vs. normal, iOS modo oscuro vs. normal). Del lado de IHG existe además acceso a **Inbox Monster** para el mismo propósito.

### Gmail compartido de prueba

El equipo usa una cuenta compartida (`gale.ihgqa@gmail.com`) para pruebas, ya que aproximadamente el 50% de la audiencia real usa Gmail. Tiene controles de acceso: solo quienes tienen la contraseña pueden entrar, y las notificaciones push al dispositivo solo se habilitan si tanto el manager en Bangalore como Kamaria lo aprueban. Los correos se organizan con **labels por proyecto y por ronda de proof**, así que queda un historial completo para volver a revisar si algo se reporta como incorrecto después.

> [!danger] Nunca hacer clic en el link de unsubscribe durante un proof
> Si el proof se está previsualizando usando un registro real de la DE (no uno de prueba), hacer clic en unsubscribe **da de baja esa dirección de correo real** — aunque quien hace clic sea alguien del equipo QA, no el cliente. Por eso ese link nunca se prueba en un live proof.

## 9. QA de otros idiomas — alcance limitado, RTL y formatos

Una vez que el inglés está 100% aprobado y probado a fondo, el resto de los idiomas reciben un QA **más ligero** — la asunción es que si funciona en inglés, funciona estructuralmente en los demás:

- Se valida que el **contenido y el layout visual** se vean bien.
- **No se hace revisión gramatical** — una traducción técnicamente correcta puede sonar "graciosa" gramaticalmente, pero eso no se valida, por restricciones de tiempo de entrega.
- **Árabe (RTL)**: se valida específicamente que la alineación de cada bloque sea de derecha a izquierda, no solo el texto.
- **Formato de fecha y número por locale**: EE. UU. escribe "August 25, 2026" mientras Canadá escribe "25th August 2026"; el separador de miles también varía (espacio para español global, punto para turco, etc.) — el equipo mantiene una guía de referencia de formatos (originada por Kamaria) para consultar caso por caso.
- **Japón**: la salutación usa el **apellido**, no el first name — es la convención inversa a como se hace en inglés.

> [!note] Qué NO cubre el QA de traducción
> Explícitamente, el equipo **no** hace: chequeo de alt-tags, chequeo de lógica gramatical de la traducción, ni chequeo de copy — por restricciones de turnaround time.

Relacionado: [[Translation Workflow]] · [[Subject & Preheader Localization]]

## 10. Herramienta de comparación de texto (para contenido largo)

Para bloques de texto largos (ej. Terms & Conditions) donde leer manualmente y detectar una sola palabra distinta es poco confiable, el equipo usa una **herramienta de comparación de texto**: se pega el contenido del email a un lado y el del Figma al otro, y la herramienta resalta cualquier palabra que difiera entre ambos lados.

## 11. Testing de Push

Push es "lo más simple de todo el testing":

- Si el push tiene URL, se valida que funcione correctamente en cada idioma.
- Si no tiene URL, solo se valida el contenido.
- Aun así, se abre el **mensaje original/raw** (no solo la vista renderizada) para confirmar que se incluyeron los alt tags/labels correctos.
- Se sigue validando personalización dinámica cuando aplica — ej. el push de FTD tenía 4 test cases (Gold Elite, Platinum Elite, Diamond Elite, Silver Elite) para validar `custom1string`.
- Se envía un test push a la propia cuenta antes de mandar a proof, para reducir la cantidad de idas y vueltas.

## 12. Revisión a nivel de journey — sin test cases escritos

Existe una capa adicional de QA que **no se documenta como test cases formales** — vive en el conocimiento/experiencia del equipo y se valida cruzando la configuración del journey contra el CRF y el List Pull:

- El nombre de la Data Extension coincide con lo que entregó Ronic.
- El schedule coincide con lo documentado en el CRF (fecha y hora — si el CRF no trae la hora, se debe pedir que la agreguen).
- El primer decision split es **mailing date = hoy**.
- Los splits de idioma están correctamente armados: primero se excluyen **todos** los códigos en inglés con una cadena de "not equals" encadenada con AND (quien no coincide con ninguno cae en la rama "S", no inglés); dentro de la rama inglesa, **American English** (`USEN` + `MSEN`) vs. **Global English** (`AMEN` + `CAEN` + `GCEN` + `EUEN`).
- **Exit criteria** = `SubscriberKey is not null`.
- La DE de auto-suppression tiene la fuente y configuración correctas.
- La configuración de **reentry** coincide con lo documentado en el List Pull.
- La **convención de naming** es correcta — el sufijo de idioma coincide (ej. `_AMAR` para árabe), y se revisan los últimos 4 dígitos del nombre para confirmar que el agrupamiento de emails sea consistente.
- La **clasificación de envío** (commercial vs. transactional) coincide con el tipo de proyecto, la publication list es "All Subscribers", track clicks está en "yes", y el throttling está configurado como corresponde.

> [!note] High Throughput Sending
> Se activa solo para audiencias muy grandes (cientos de miles en adelante) — reduce un despliegue típico de 8–9 horas a 2–3 horas. Para push a escala de ~1 millón de contactos, es más experimental: se puede activar y observar el comportamiento sin comprometerse a que sea la configuración estándar todavía.

Relacionado: [[Journey Builder]] · [[Data Layer]]

## 13. Feedback tracker (Smartsheet)

> [!warning] Nunca dar feedback por mensaje suelto
> Si el feedback se comunica por chat directo ("oye, esto está mal", "esto otro también") en vez de un documento estructurado, rápidamente se vuelve imposible de rastrear — "van a ser 1050 problemas" sueltos sin ningún registro ordenado.

En vez de eso, el equipo usa un **Smartsheet dedicado por proyecto** (típicamente creado por Tamara), con una fila por hallazgo:

- Ronda en la que se encontró (Round 1, 2, 3…).
- Quién lo encontró y captura de pantalla del problema.
- Respuesta del desarrollador: **addressed** (y QA revalida), **defect** (se documenta pero no bloquea el lanzamiento), o **not an issue** (se explica por qué el gap es esperado).

Es un documento **obligatorio** para todo proyecto — la forma en que QA y desarrollo se comunican de forma rastreable. El entrenamiento de cómo construir uno desde cero se puede pedir a Kapil o a Anu (rundown de ~15 minutos).

## 14. Priorización de issues: pre-lanzamiento vs. producción

- **Antes del lanzamiento**, el equipo **no usa una tabla formal de prioridad tipo P0/P1/P2/P3** — ese nivel de triage es más propio de ciclos de desarrollo de software masivos, repartidos en meses/años. En LFC, la meta es simplemente validar y probar todo lo posible **antes** de que el email salga.
- **Después del lanzamiento**, sí existe una tabla de escalamiento por prioridad (con tiempos de respuesta y puntos de contacto por nivel) — pero se usa muy raramente, porque el proceso de QA pre-lanzamiento captura la gran mayoría de los problemas antes de que lleguen a producción. Cualquier problema detectado en el **Golden Hour Check** o **End of Day Check** se trata automáticamente como **P0** y se resuelve de inmediato.

## 15. Evolución del proceso de QA — por qué existen tantas capas

En 2024 el equipo tenía notablemente más incidentes. La respuesta fue introducir una estructura de rondas progresivas: **pre-alpha → alpha → beta → live proofs → checks del día de lanzamiento** — como mínimo, **3 rondas de QA interna** más una ronda de traducciones más una ronda de proofs con el cliente. Esa estructura es la razón por la que hoy el volumen de incidentes es mucho menor.

> [!note] Caso real visto en vivo durante esta sesión
> Mientras se grababa la sesión, Anu descubrió que la automatización de **Points Expiration** llevaba fallando desde el domingo/lunes anterior — un email transaccional que, técnicamente, no está bajo la responsabilidad directa de QA de GALE, pero que Anu detectó durante su revisión rutinaria de **End of Day Check** antes de mandar el reporte diario. Escaló de inmediato a Kamaria y Ronic como solicitud de alta prioridad. Es el ejemplo perfecto de por qué el hábito del End of Day Check importa — atrapa problemas que de otra forma pasarían desapercibidos por días.

## 16. Qué NO se testea (y por qué)

Francisco preguntó si el equipo prueba datos malformados (ej. números dentro de un campo de nombre). Respuesta: **no** — se considera un problema de calidad de datos que debe resolverse en el origen (equipo de datos), no algo que el desarrollador deba sanear con AMPscript ("si llega así, llega así"). Agregar esa lógica de saneamiento incrementaría la complejidad del código sin necesidad real. Lo que sí se prueba consistentemente son las **variaciones de mayúsculas/minúsculas** (upper/lower/mixed case), porque eso sí es un patrón real y frecuente en los datos.

## 17. Timing y paralelismo: escribir test cases mientras se construye el email

El tiempo que toma un proyecto varía mucho según su complejidad — una campaña con 8 emails y 2 configuraciones de push toma mucho más tiempo que un proyecto de un solo email en un solo idioma.

> [!tip] Los test cases no se escriben después del build
> En cuanto el List Pull está listo, el desarrollador empieza a construir el email **y, en paralelo, QA ya empieza a escribir los test cases y preparar el test data** — no se espera a que el email esté terminado para arrancar. Así, en el momento exacto en que el desarrollador termina el build, QA ya puede empezar a validar de inmediato.

## 18. Validación final antes de activar: test send

Antes de dar luz verde, se hace un envío de prueba final:

1. Click en **Validate**, luego **Test**.
2. Seleccionar registros que cubran cada idioma/región relevante.
3. Enviar solo al Gmail de prueba compartido del equipo.
4. Al recibir los correos, confirmar: personalización correcta (incluyendo el caso de Japón, con apellido en vez de nombre), que cada registro haya caído en la ruta de idioma correcta, y que el contenido dinámico se vea bien.
5. Si el preheader se ve cortado visualmente en el cliente, se puede leer completo reduciendo el zoom del navegador o usando la opción **"Show Original"** de Gmail.

> [!note] QA no es la primera línea de defensa
> Antes de que el journey llegue a QA para el click de Validate, el desarrollador y el equipo de platform ya hicieron su propia validación — la meta es que QA no sea quien encuentre los problemas básicos, sino quien confirme que ya fueron resueltos.

## Relacionado

[[QA Process]]
[[LFC_20260508_Marketing Cloud Journey Monitoring & Reporting]]
[[LFC_20260512_Comprehensive Onboarding for Email Campaign Development and Deployment]]
[[Journey Builder]]
[[CRF]]
[[Email Properties]]
[[Data Layer]]
[[Translation Workflow]]
[[Deployment Plan]]

---
date: 2026-08-12
tags:
  - lfc
  - sfmc
  - translations
  - smartling
  - localization
  - link-matrix
  - ampscript
  - qa
  - onboarding
  - meeting-notes
type: meeting-notes
related:
  - "[[Translation Workflow]]"
  - "[[Subject & Preheader Localization]]"
  - "[[Link Matrix (LinkHelper)]]"
  - "[[LFC_20260511_Tier Translation Logic & Dynamic Content QA]]"
  - "[[LFC_20260623_La agencia QA Test Case Methodology & Feedback Tracking]]"
created: 2026-08-12
status: Active
---

# La agencia Training | Translation Project Walkthrough

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[LFC_20260812_La agencia Training - Translation Project Walkthrough]]
> WHERE file.path != this.file.path
> ```

> [!info] Contexto
> Sesión de capacitación liderada por [[Aruni Patel]] (La agencia), enfocada en las actividades que el equipo de desarrollo LFC (incluyendo a Gera y Ana) debe realizar **después** de que [[Smartling]] devuelve un correo traducido. Al momento de la sesión no existía todavía ningún email real que hubiera pasado por el proceso completo de traducción, así que Aruni construyó un ejemplo simulado para recorrer el flujo. Ya se anticipaba esta sesión en [[LFC_20260511_Tier Translation Logic & Dynamic Content QA]] ("Aruni se integraría específicamente para la parte de traducciones"). Preguntas de: [[Irvin Sánchez]], [[Francisco|Francisco Galván]], [[Juan Pablo Chavez]]. Otros presentes: [[Tamara|Tamara Patrón]], [[Andrea Regla]], [[Oscar|Oscar Cordero]], [[Ana Corona]].

> [!warning] Nota sobre la fuente
> Esta nota combina un resumen ejecutivo generado por una herramienta de transcripción y fragmentos del transcript automático (closed captions) de la grabación. Ambas fuentes tienen errores conocidos de transcripción — el más relevante: **"SmartLink" es casi con certeza [[Smartling]]** mal transcrito por el motor de captions (ya confirmado como la herramienta real en el vault). Se marca explícitamente cualquier otro punto que no se pudo verificar contra documentación existente.
>
> **Cobertura de timestamps**: solo las secciones 2 (paso de renombrado), 3 (Link Matrix) y 5 (testing en Email on Acid) tienen citas `[!quote]` con minuto exacto — son las únicas partes de esta nota que vinieron del fragmento de transcript con timestamps (00:06–28:05) compartido en el chat. El resto de la nota (secciones 1, 4, 6, 7, 8 y la tabla de acciones) viene del resumen ejecutivo sin timestamps o de mensajes sueltos del usuario — no se les puede poner minuto exacto sin inventarlo.

## 1. Qué era nuevo vs. qué ya estaba documentado

Buena parte de lo que cubrió Aruni ya vivía en el vault desde antes de esta sesión — ver [[Translation Workflow]] y [[Subject & Preheader Localization]] para el flujo base (qué traduce Smartling, qué no, y por qué Subject/Preheader son una excepción). Esta nota se concentra en lo que la sesión agregó de nuevo.

## 2. Al recibir las traducciones — pasos nuevos

1. **Duplicar** el correo (la versión USEN aprobada) una vez que la traducción está lista.
2. Los emails regresan de Smartling con el **idioma agregado entre paréntesis** al nombre original — primer paso es **renombrar** el email según la convención interna de naming.

   > [!quote]- Mencionado en la grabación (2026-08-12)
   > - **00:14–00:35** — "Currently we don't really have any e-mail that has just gone through the smart link process of translation. So what I did is I tried to mimic one of the e-mail that we are going to work on."
   > - **00:40–01:12** — "Usually the emails when we submit from translation in SmartLink you would receive in the folder it was submitted location of the emails... the name that you would have submitted along with the USEN. There would be a language appended to the e-mail name."
   > - **01:12–01:18** — "So first step we usually do when we receive the translations back is update the e-mail names according to the naming convention... when we receive it back from translation, the emails usually have the language in parenthesis. So I would first update the e-mail names."
3. Actualizar el campo de idioma en las **Email Properties** para que coincida con el idioma recibido (ej. `USEN` → `EUFR`).
4. Ir al translation document/DE, tomar el contenido correcto para el idioma en turno y **pegarlo manualmente**: subject line, preheader, y cualquier texto que no sea contenido dinámico — porque Smartling **solo traduce el HTML copy** (Body Content, Assets, Legal Copy, Content Modules; ver [[Translation Workflow]]). Todo lo que vive fuera del HTML (variables AMPscript, subject/preheader dinámicos, lógica personalizada) se actualiza a mano.
5. Modificar el **AMPscript** correspondiente donde aplique.
6. Revisar los links usando el **[[Link Matrix (LinkHelper)]]** — confirmar que sean dinámicos y no URLs estáticas; si el código de región/idioma configurado no coincide con la región real, el usuario puede terminar redirigido a la página incorrecta (ej. cae en USEN por default).
7. Validar **formatos regionales** (fecha, numéricos) — refuerza lo ya documentado en [[LFC_20260623_La agencia QA Test Case Methodology & Feedback Tracking#9. QA de otros idiomas — alcance limitado, RTL y formatos]].

### Content IDs y variantes

Algunos correos tienen múltiples variantes de subject line/preheader (`B1`, `B2`, `A1`, `A2`...) controladas por **[[Content ID]]**. Para traducirlas: Smartling llena el documento de traducciones → el desarrollador identifica el Content ID correspondiente → copia manualmente la traducción al AMPscript. Detalle a agregar en [[Subject & Preheader Localization]].

### Componentes que NO requieren modificación manual

Vienen del template y se ajustan solos según la configuración regional — **no** se tocan por idioma:
- Brand Bar
- Footer estándar
- Tier Status
- Términos y condiciones globales del template

## 3. Link Matrix — de dónde sale el contenido

Pregunta de [[Juan Pablo Chavez]]: ¿existe un documento con las URLs correctas? Respuesta de Aruni:

> "The URL matrix does come from El Grupo itself, like the campaign team, whoever is leading the campaign."

El **Campaign Team de El Grupo** (quien lidere esa campaña específica) es quien entrega el contenido del URL matrix. La agencia toma ese documento y construye la implementación técnica en SFMC — el detalle completo de esa DE (estructura, naming, ejemplo real `LinkMatrix_Enrolment_Booking_2026`) vive ahora en **[[Link Matrix (LinkHelper)]]**, nota nueva de esta sesión.

> [!note] Matiz con [[CRF]]
> La nota de [[CRF]] dice que el Business Analyst "arma" el CRF con la matriz de links/tracking incluida. No es necesariamente una contradicción — el BA arma/compila el documento completo, pero según Aruni el contenido del URL matrix específicamente lo origina el Campaign Team. Se deja anotado por si el usuario quiere confirmarlo con el proceso actual del lado GDL.

Ejemplo mostrado en sesión: URL matrix de la campaña de "points purchase" — todas las filas son idénticas excepto el **region language code** del link helper.

> [!quote]- Mencionado en la grabación (2026-08-12)
> - **24:09** — Francisco: "The URLs should be, or must be, in the documents, right? All the URLs."
> - **24:28** — Juan Pablo Chavez: "Aruni, do you have an example of like a document with all the correct URLs that you can share with us, please?"
> - **24:39** — Aruni: "So usually the URL matrix does come from IHG itself, like the campaign team, whoever is leading the campaign. But I can show you a sample." *(nota: "IHG" en el audio original — anonimizado a "El Grupo" en el cuerpo de esta nota por la [[Reglas de Confidencialidad y Uso del Vault|regla de confidencialidad del vault]])*
> - **24:57–25:18** — "This is a sample from the points purchase e-mail that we recently worked on... everything is same except for the... region language called the link helper."
> - **25:30–25:39** — "I will just add this in the URL, in the place where it goes... When you test it, they all would redirect to the correct [page]. If the region language code in the data is accurate, it would redirect to that particular language page."

## 4. QA con dummy data

Cuando no hay data de prueba real disponible: se crea/usa una **Test Data Extension**, replicando escenarios y variando el **Region Language Code** por fila. Esto permite hacer previews, enviar proofs y validar comportamiento dinámico sin depender de data real. Ejemplo visto en sesiones previas de este mismo proyecto: DE `LFC_UNIVERSAL_TEST_DE`, con filas por combinación de `RGN_LANG_CD` + `MEMLVL` (nivel de membresía), todas apuntando al mismo correo de prueba (`gale.ihgqa+1@gmail.com`).

## 5. Testing en Email on Acid — cobertura por variante, no por idioma

Pregunta de [[Irvin Sánchez]]: ¿se manda un test de Email on Acid por idioma, usando dummy data por región?

Respuesta de Aruni — matiz importante:
- Si **solo cambian** subject line/preheader (todo el resto del módulo es igual) → **un solo test en Email on Acid** que cubra todas las variantes dinámicas (ej. ambos `B1` y `B2`) es suficiente. El look & feel no cambia por idioma, así que no hace falta un test por cada uno.
- Para el **testing/proof interno del equipo** sí se cubren todos los escenarios dinámicos por separado (todas las variantes de Content ID, etc.), porque ahí se está validando contenido y traducción, no solo renderizado.

> [!quote]- Mencionado en la grabación (2026-08-12)
> - **25:54–26:12** — Irvin: "When you need [to] test all languages in e-mail on a[c]id, you select a subscriber with the correct languages or a dummy data in the data st[at]ion and send — you send one e-mail per language[] at email on a[c]id, right?"
> - **26:14–26:20** — Aruni: "On email on acid, yes. If there is only subject line and preheader change, everything else is same. For that particular module, I would just send one email on acid test. But coming to the internal team testing, I would send one [per escenario]."
> - **26:34–26:53** — "All the dynamic scenarios. So in this case, there are two subject lines and three headers. I would also send B1 and B2 both for our team to check both the subject lines and preheaders... anything that is dynamic, I would cover all the scenarios in the test that I sent to the team. But [for] an email on acid[, ] the actual look and feel of the emails would be just one is enough."

## 6. Litmus — por qué no se usa

El equipo **no tiene acceso** a Litmus, aunque está visible dentro del tab **Preview and Test** de SFMC (hallazgo original de Francisco). Por eso la herramienta real usada para QA visual/cross-cliente es **Email on Acid** — ya documentada junto con Inbox Monster en el [[Glosario de Términos y Herramientas LFC]]. Se actualiza esa entrada para reflejar la razón de la ausencia de Litmus.

## 7. Regla de timing: cuándo solicitar traducción

Pregunta de [[Irvin Sánchez]]; respuesta de [[Tamara|Tamara Patrón]] y Aruni.

**Regla**: NO enviar a traducción inmediatamente después de terminar el desarrollo. Flujo correcto:

`Desarrollo USEN → QA → Aprobación interna → Aprobación del Campaign Team/cliente → Solicitud de traducción a Smartling`

**Motivo**: si se modifica USEN después de haberlo enviado a traducción, los cambios **no se propagan automáticamente** a los demás idiomas — hay que replicarlos manualmente en cada uno. Evitar este retrabajo es la razón de toda la regla.

## 8. Regla USCN

Cualquier cambio necesario en la versión **USCN** del email requiere un **envío completo** (no parcial) del mail, y **rehacer la solicitud de traducción desde cero** — no se puede parchar solo el fragmento modificado.

## Acciones y responsables

| Quién | Acción | Motivo/resultado esperado |
|---|---|---|
| [[Aruni Patel]] | Continuar capacitación sobre gestión de traducciones, validación de idiomas, config. regional y QA de correos traducidos | En progreso |
| [[Irvin Sánchez]] | Aplicar el flujo correcto antes de solicitar traducciones: dev USEN → QA → aprobación → envío a Smartling | Evitar cambios duplicados en todos los idiomas |
| [[Francisco\|Francisco Galván]] | Validar en futuros proyectos: uso del Link Matrix, existencia de URLs traducidas por idioma, cobertura de traducciones dinámicas | Reducir incidencias durante QA multilenguaje |
| Equipo de Desarrollo LFC (Gera, Ana) | Al recibir traducciones: renombrar, actualizar propiedades, actualizar AMPscript, revisar formatos regionales, validar links, preview, Email on Acid, enviar proofs | Deployment sin retrabajo |
| Smartling / equipo de traducción | Completar los documentos de traducción enviados junto con los correos | Entregables: traducciones, subject lines, preheaders, contenido dinámico solicitado |

## Relacionado

[[Translation Workflow]]
[[Subject & Preheader Localization]]
[[Link Matrix (LinkHelper)]]
[[CRF]]
[[Content ID]]
[[Region Language Codes]]
[[Aruni Patel]]
[[LFC_20260511_Tier Translation Logic & Dynamic Content QA]]
[[LFC_20260623_La agencia QA Test Case Methodology & Feedback Tracking]]
[[Glosario de Términos y Herramientas LFC]]

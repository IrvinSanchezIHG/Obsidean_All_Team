---
date: 2026-08-14
tags:
  - lfc
  - sfmc
  - journey-builder
  - content-blocks
  - nearly
  - anniversary
  - tier
  - localization
  - governance
  - qa
  - onboarding
  - meeting-notes
type: meeting-notes
related:
  - "[[20 - Journey Builder]]"
  - "[[12 - Shared Content Blocks]]"
  - "[[23 - Dynamic Attributes]]"
  - "[[15 - QA Process]]"
  - "[[17 - Deployment Plan]]"
  - "[[A O C Campaign]]"
created: 2026-08-14
status: Active
---

# La agencia Training | Nearly & Anniversary

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[LFC_20260814_La agencia Training - Nearly & Anniversary]]
> WHERE file.path != this.file.path
> ```

> [!info] Contexto
> Sesión del 14 de agosto de 2026 para revisar el flujo completo de activación de journeys, usando como caso real el journey **Nearly_Elite_Silver_Deployment_2026** en Journey Builder. La parte de gobernanza de templates fue preguntada por [[Oscar|Oscar Cordero]] y respondida por **Alex Wilkinson-Sanchez** (ver [[Alex Wilkinson-Sanchez]]). Presentes también: [[Irvin Sánchez]], [[Andrea Regla]], [[Francisco|Francisco Galván]] y [[Juan Pablo Chavez]]. Esta sesión retoma el tema de decision splits por idioma ya anticipado en una sesión de journey previa con Alex (2026-05-08) — ver [[23 - Dynamic Attributes#`region_language_code`|Dynamic Attributes → region_language_code]].

> [!warning] Nota sobre la fuente
> Esta nota se construyó a partir de las notas que el usuario fue compartiendo en vivo durante la sesión (texto libre + un resumen ya redactado de la parte DEV/QA), no de una transcripción con timestamps — por eso no lleva citas `[!quote]` con minuto exacto, a diferencia de otras notas de esta serie. El nombre real de la agencia ("GALE") mencionado por el usuario al pedir el título de esta nota se sustituyó por **La agencia** siguiendo la [[Reglas de Confidencialidad y Uso del Vault|regla de confidencialidad del vault]] — mismo tratamiento para el código de marca real dentro del naming de la Data Extension mostrada en pantalla (ver sección 1).

## 1. Arquitectura del journey — Nearly por tier

- Existe **un Journey por TIER**: Silver, Gold, Platinum, Diamond. El caso mostrado en pantalla fue `Nearly_Elite_Silver_Deployment_2026`.
- Cada Journey usa su **propia Data Extension** como Entry Source, con naming del estilo `FINAL_MC_ElGrupo_RS_GLO_LFC_Nearly_Elite_Slvr_Ind_CDP_P_YYYYMMDD` (código de marca real sustituido por "ElGrupo" en esta nota, ver aviso arriba).
- Dentro del canvas, la cadena de **Decision Splits** filtra progresivamente (ej. Club Members, Mailing Date) hasta llegar a un split dedicado por **idioma** — cada rama de idioma (Arabic, Japanese, Korean, German, …) lleva a su propio Email + espera de 1 minuto + Exit. Confirma en la práctica lo ya anotado en [[23 - Dynamic Attributes#`region_language_code`|Dynamic Attributes]]: un split por idioma, cada uno con su asset propio.
- Los **content blocks** dentro del contenido del email se referencian a veces **by Key** y a veces **by ID** — inconsistencia observada en el journey actual, no un patrón intencional (ver [[12 - Shared Content Blocks]] para el detalle y la recomendación que salió de esta sesión).
- Dentro del contenido de cada email hay bloques **ELSIF** que van seteando las variables correspondientes a cada idioma.
- Se revisaron cambios recientes en los **parámetros** de ese contenido — se mostró específicamente el **parámetro #5** como ejemplo en pantalla (no se profundizó en su función exacta durante la sesión).
- El journey en sí está dirigido a la Data Extension del tier correspondiente — es esa DE, no el canvas, la que determina la audiencia real (mismo principio ya documentado en [[20 - Journey Builder#Entry Source|Journey Builder → Entry Source]]).

## 2. Deploy y activación

Flujo confirmado en la sesión:

```text
Aprobación del manager → Test → Activación (puede ser al día siguiente)
```

## 3. Gobernanza de templates — pregunta de Oscar

Oscar quería entender cómo se manejan **cambios estructurales de plantilla** (no cambios de copy/traducción) sin afectar otras campañas que comparten la misma base.

**Su pregunta, en resumen**: si existe una **Master Template** que sirve de base a múltiples campañas, ¿cómo se implementa un cambio estructural (ej. reemplazar `ContentBlockByID` por `ContentBlockByKey`, renombrar componentes, reorganizar la estructura técnica del email) en una sola campaña — por ejemplo Nurture — sin romper las demás que usan esa misma Master Template? Y, más arriba en el proceso: ¿de dónde surge la solicitud de un cambio así, quién la aprueba, y cómo se aplica solo a una campaña específica?

**Respuesta de Alex:**

1. **No modificar directamente una Master Template compartida.** Cualquier cambio a la plantilla base puede impactar todas las comunicaciones que dependen de ella.
2. **Si el cambio es exclusivo de una campaña** (ej. solo Nurture): crear una **plantilla nueva o una variante**, no tocar la Master Template. Esto aplica también a nivel de contenido — ver la recomendación de content blocks nuevos en la sección 4.
3. **Cambios de estructura interna** (`ContentBlockByID` → `ContentBlockByKey`, renombrado de componentes, reorganización técnica) son viables, pero si modifican la lógica base del template conviene crear una **versión nueva** del template en vez de editar el actual.
4. **Cambios globales** (ej. footer, App Logo, App Links, componentes compartidos) se tratan distinto: deben discutirse con los equipos involucrados, no aplicarse directamente en producción, y pasar por revisión + validación + pruebas antes de implementarse. Ver [[Marketing Governance]] / [[Content Governance]] para el equipo que típicamente entra en este tipo de revisión.
5. **Proceso general para cambios globales**: definir el cambio → validar con los equipos involucrados → pruebas → revisión de resultados → implementación en producción.

**Insight clave para el equipo LFC**: si el cambio es exclusivo de una campaña o de una necesidad puntual del equipo, se crea una plantilla nueva — nunca se toca la Master Template compartida. Esto mantiene estables las campañas activas, reduce el riesgo de impacto masivo, permite probar estructuras nuevas de forma controlada, y facilita mejoras futuras sin afectar otros programas.

## 4. Recomendación reforzada — content blocks nuevos, no modificados

Al implementar un template nuevo, cuidar especialmente los **content blocks** que se están reutilizando para no romper nada. La recomendación concreta: **crear content blocks nuevos** para el template nuevo en vez de modificar los existentes — así se evita afectar todo lo que ya está implementado y en producción.

## 5. QA — dos rounds

El QA se hace básicamente en **2 rounds**:

1. Con la primera versión del email, **antes** de recibir las traducciones.
2. Una vez recibidas las traducciones.

El QA final ya se hace **integrado con el journey**, no como validación aislada del email.

## DEV Considerations

1. **Flujo de actualización de contenido** (campañas Nearly/Anniversary): actualizar primero USEN → aprobación de negocio → enviar a traducción → reemplazar versiones traducidas → crear nueva versión del Journey → asociar los nuevos emails al Journey → Live Proofs → activar.
2. **Nunca modificar assets productivos directamente**: duplicar antes de cambiar, trabajar siempre en una nueva versión del asset.
3. **Arquitectura de Nearly**: un Journey por tier (Silver/Gold/Platinum/Diamond), cada uno con su propia DE, emails por idioma, content blocks compartidos para la lógica dinámica.
4. **Content blocks críticos observados** (validar su impacto antes de tocarlos): `Subject_Preheader_Nearly_LFC` (emails), `EDS_Logic_LEV_20220228`, `Campaign_Configuration_File`. Contienen traducciones, cálculo de noches, cálculo de puntos y texto dinámico por idioma — modificarlos o eliminar referencias mal puede romper múltiples idiomas a la vez.
5. **Idiomas**: no se generan dinámicamente en la mayoría de los casos — es un email por idioma. Se modifica primero USEN, se envía a traducción, se crea una nueva versión por idioma, y se reemplaza en el Journey.
6. **Master Templates**: no modificar la compartida si el cambio es solo para una campaña — crear plantilla/variante nueva (ver sección 3).
7. **Cambios globales** (footer, App Logo, App Links, componentes compartidos): requieren revisión de stakeholders, validación cross-team y pruebas exhaustivas antes de producción.
8. **Coordinación con Data Team** (ej. [[Raunak]]) antes de activar: confirmar cuándo corre la automatización y evitar activar justo después de una ejecución diaria, para no perder registros durante el cambio de versión.
9. **Anniversary — lógica dinámica**: variable principal `year_celb`, que controla el año aniversario, los bonus points, los mensajes mostrados y los términos y condiciones. DEV debe entender esa lógica completa antes de modificarla.

## QA Considerations

1. **El Journey no es la primera validación.** Flujo recomendado: 1ª ronda = QA del email (layout, dynamic content, idioma, personalización); 2ª ronda = QA del Journey completo (routing, decision splits, entry criteria, emails asociados).
2. **Esperar traducciones completas** (inglés + todos los idiomas requeridos) antes de probar el Journey, para no rehacer validaciones por cambios posteriores.
3. **Live Proofs son obligatorios** antes de activar: generar previews reales, enviar a Marketing Managers, obtener aprobación.
4. **Registros reales**: se pueden usar para pruebas en campañas ya productivas, pero el envío siempre debe ir a miembros del equipo — nunca a usuarios finales.
5. **Validación por idioma, sin mezclar**: registro japonés → email japonés, alemán → alemán, coreano → coreano. Mezclar idiomas puede ocultar defectos o mostrar bloques incorrectos.
6. **Validar lógica dinámica**:
   - Nearly: stay X more nights, earn X more points, tier correcto, nombre correcto, traducciones correctas.
   - Anniversary: `year_celb` correcto, bonus points correctos, copys correctos por milestone (1, 2, 3, 4, 5, 10, 15, 20 y 25 años).
7. **Sanity check / Final QA** antes de activar: email correcto, journey correcto, traducciones correctas, records correctos, dynamic content correcto, links correctos.

## Resumen Ejecutivo

- **DEV**: duplicar antes de modificar, trabajar con versiones nuevas, entender los content blocks compartidos, validar el impacto de cambios globales, coordinar con Data Team, no modificar Master Templates sin evaluación previa.
- **QA**: validar el email antes que el journey, esperar traducciones completas, hacer Live Proofs, probar con registros reales del idioma correspondiente, verificar toda la lógica dinámica, ejecutar un QA final antes de activar.

## Relacionado

[[20 - Journey Builder]]
[[12 - Shared Content Blocks]]
[[23 - Dynamic Attributes]]
[[15 - QA Process]]
[[17 - Deployment Plan]]
[[A O C Campaign]]
[[Marketing Governance]]
[[Content Governance]]
[[Alex Wilkinson-Sanchez]]
[[Oscar]]
[[Raunak]]

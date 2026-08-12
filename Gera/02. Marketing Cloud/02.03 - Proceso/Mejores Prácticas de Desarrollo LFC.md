---
aliases:
  - "LFC Dev Quick Reference"
  - "Guía Rápida de Desarrollo LFC"
  - "Developer Best Practices Guide"
tags:
  - lfc
  - sfmc
  - developer-guide
  - best-practices
  - reference
created: 2026-08-12
status: Active
---

# Mejores Prácticas de Desarrollo LFC

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[Mejores Prácticas de Desarrollo LFC]]
> WHERE file.path != this.file.path
> ```

> [!abstract]- Qué es esta nota
> **Referencia rápida y escaneable**, organizada por fase (archivos → Figma → Data → build → traducción → journey → QA → deployment), condensada a partir de todas las sesiones de onboarding y la referencia técnica del vault. No repite el detalle completo — para el recorrido paso a paso, ver [[LFC_20260507_Lifecycle Email Development & Data Integration|Manual de Onboarding para Desarrolladores LFC]] (18 pasos) y [[Resumen del Proceso Completo de Campañas LFC]] (narrativa de punta a punta). Existe también como página visual: [Guía de Mejores Prácticas (artifact)](https://claude.ai/code/artifact/9c6c28b9-3bda-45dd-9dfb-f56afb74a0a2).

## 1. Archivos, carpetas y naming

- **Dónde vive cada cosa**: Email/Push en [[Content Builder]]; Journeys en Journey Builder → My Journeys → Lifecycle; DEs de trabajo ("Working") vs. **carpeta Final DE** (única válida como entry source de producción) en Contact Builder.
- **Patrón Live / Dev / Archive** dentro de cada carpeta de campaña — nunca se edita directamente en Live; al archivar, se renombra con `Archive` + fecha `AAAAMMDD`.
- **Convención de nombres**: `Región_Categoría_Campaña_Identificador_Versión_Idioma`, formato **camelCase**, sin espacios, sin guiones bajos/medios dentro del nombre de campaña. El identificador ya no usa MRM — usa el número de Smartsheet.

Detalle completo: [[LFC_20260507_Lifecycle Email Development & Data Integration#Paso 2 Ubicar dónde vive cada cosa (estructura de carpetas)|Paso 2]] y [[LFC_20260507_Lifecycle Email Development & Data Integration#Paso 3 Aplicar la convención de nombres|Paso 3]] del Manual.

## 2. Figma

- Fuente oficial de todo asset visual. Exportar siempre en **2x**.
- El equipo de creative etiqueta cada bloque con su ID de componente SFMC (ej. `10A`, `10D`) — ante discrepancia entre etiqueta y librería real, compara visualmente, no confíes solo en la etiqueta.
- Clasifica cada elemento antes de construir: campo directo de DE, variable derivada, valor de content block, o dirigido por traducción.

Ver [[Figma Assets]].

## 3. Data: List Pull y Data Extensions

- El List Pull se prepara **en paralelo** al Figma — junto con él, es lo mínimo para arrancar el build.
- Flujo real de la audiencia: **GCP** (tablas base) → **Data Cloud** (segmentación) → **activación/Customer 360** → **Automation Studio** (staging + contact history append) → **Final DE**.

> [!warning] Regla no negociable
> Cualquier List Pull debe estar actualizado con **al menos 2 semanas de anticipación**. Ante un cambio de criterio: correo a todo el equipo + **confirmación explícita por correo** de que el list pull ya se actualizó, antes de asumir que se puede avanzar.

> [!danger] Nunca
> Editar directamente una DE conectada a una relación de datos de Contact Builder (ej. auto-suppression) — rompe la relación silenciosamente y todos los journeys conectados dejan de enviar correos.

La [[Link Matrix (LinkHelper)]] es la excepción: esa DE la construye el equipo de desarrollo (La agencia), no el Data Team.

Detalle completo: [[LFC_20260507_Lifecycle Email Development & Data Integration#Paso 8 Aplicar las reglas compartidas de Data Extensions|Paso 8]] del Manual, [[Data Layer]].

## 4. Build de Email

`CRF → Email Name → Email Properties → Template → Assets → Build → QA` — ver [[Email Build Process]].

- Se construye siempre primero en **USEN**, nunca todos los idiomas en paralelo.
- **Definition of Ready** antes de construir: CRF, Figma aprobado, List Pull, DE del stage con todos los campos, URL Matrix, registros de prueba, traducciones requeridas.
- Declarar toda variable [[AMPscript]] referenciada más adelante — nunca asumir que ya existe solo porque funcionó en otra campaña.
- `v()` para valores ya finales, [[TreatAsContent]] para markup/código renderizable, `ProperCase()` para normalizar formato.
- Todo elemento clickeable necesita **alias** — si no, el reporting lo cuenta como `null`/`other`.
- Links dinámicos vía [[Link Matrix (LinkHelper)]] — nunca URLs estáticas.

Checklist completo: [[LFC_20260507_Lifecycle Email Development & Data Integration#Paso 12 Verificar con los checklists finales|Paso 12]] del Manual.

## 5. Traducción

Ver [[Translation Workflow]] y [[Subject & Preheader Localization]] para el detalle completo.

> [!warning] Regla de timing
> No enviar a traducción inmediatamente después del desarrollo: `Desarrollo USEN → QA → Aprobación interna → Aprobación Campaign Team/cliente → Solicitud de traducción`. Cambios post-envío no se propagan solos a los demás idiomas.

- [[Smartling]] traduce Body Content, Assets, Legal Copy, Content Modules — **nunca** AMPscript, y **nunca** subject/preheader (excepción, van por formulario separado).
- Al recibir: renombrar (el idioma llega entre paréntesis), actualizar el region language code en [[Email Properties]], pegar subject/preheader por [[Content ID]] (`B1`, `B2`...), reemplazar palabras dinámicas en AMPscript, revisar links vía [[Link Matrix (LinkHelper)]].
- **Excepción USCN**: cualquier cambio requiere reenvío completo del mail y rehacer la solicitud desde cero.
- Testing en Email on Acid: si solo cambia subject/preheader, un solo test cubriendo todas las variantes basta — no uno por idioma.

## 6. Journey Builder

- **Entry Source** es la decisión más crítica — solo la carpeta **Final DE** es válida en producción.
- Decision splits estándar: `Mailing Date = Today` → split de idioma con lógica negativa (excluir todos los códigos en inglés con AND) → dentro de inglés, American vs. Global English.
- Mientras más simple el canvas, más seguro el lanzamiento — no dupliques lógica ya embebida en la DE.

> [!warning] Gotcha frecuente
> `SubscriberKey is null` excluye por accidente al 90% de los registros válidos. El filtro correcto es `SubscriberKey is not null`.

Ver [[Journey Builder]].

## 7. QA

Cuatro tipos de prueba, ninguno reemplaza al otro — ver [[QA Process]]:

| Tipo | Valida |
|---|---|
| Internal Test | Contenido/diseño, a grupo pequeño corporativo |
| QA Test | Tracking (aliases, impression regions) — único envío real de prueba |
| Live Proofing | Calificación dinámica 1 a 1, desde el journey con data real |
| Seed List | Versión final aprobada, a liderazgo con data dummy |

- Metodología de Test Cases: el Figma es la fuente de verdad, una fila por combinación relevante de variables dinámicas.
- Herramienta real de rendering cross-cliente: **Email on Acid** (Litmus está visible en SFMC pero sin acceso).

## 8. Deployment y monitoreo

> [!warning] Secuencia obligatoria
> `Build → QA (email + journey) → Deployment Plan → walkthrough con Marketing Managers → activación`. Nunca documentar en paralelo al build.

- [[Deployment Plan]]: historial de revisiones, propósito + link al CRF (sin duplicar List Pull), detalles de DE, capturas de configuración. Se archiva en SharePoint.
- Post-activación obligatorio: **Golden Hour Check** (primera hora) y **End of Day Check**. Cualquier problema ahí es **P0**, se resuelve de inmediato.
- Monitoreo continuo: [[Monitoring|Tableau]] + reporte diario ESSR.

## Reglas de oro

Las que han causado incidentes reales cuando se rompen:

- Nunca editar una DE conectada a Contact Builder.
- Nunca pausar un journey/automation "solo para ver" — usar Ctrl+F para buscar dentro del canvas sin abrir/editar.
- List Pull y cambios de nombre: avisar con 2+ semanas de anticipación.
- Solo la carpeta "Final DE" es válida como entry source de producción.
- Nunca hacer clic en unsubscribe durante un proof con data real.
- No enviar a traducción hasta tener USEN aprobado.
- Todo elemento clickeable necesita alias.
- Personalización rota en varios emails no relacionados, de forma dispersa → sospechar de un cambio upstream en la fuente de datos, no de un bug local de AMPscript.

## Relacionado

[[LFC_20260507_Lifecycle Email Development & Data Integration]]
[[Resumen del Proceso Completo de Campañas LFC]]
[[End-to-End Flow]]
[[Translation Workflow]]
[[Link Matrix (LinkHelper)]]
[[CRF]]
[[QA Process]]
[[Deployment Plan]]
[[00 - Marketing Cloud Onboarding]]

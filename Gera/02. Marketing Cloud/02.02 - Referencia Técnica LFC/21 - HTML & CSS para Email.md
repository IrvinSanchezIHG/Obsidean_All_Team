---
aliases:
  - "HTML & CSS para Email"
  - "HTML y CSS para Email"
  - "HTML para Email"
  - "CSS para Email"
  - "Email Coding"
tags:
  - html
  - css
  - email-build
  - email-coding
  - sfmc
  - functions-reference
created: 2026-08-10
status: Active
---

# HTML & CSS para Email

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[21 - HTML & CSS para Email]]
> WHERE file.path != this.file.path
> ```

> [!info] Por qué el email coding es distinto al web coding
> Los clientes de correo (Outlook, Gmail, Apple Mail, Yahoo…) no comparten un motor de renderizado moderno y consistente como un navegador. **Outlook de escritorio (2016/2019/2021/365) renderiza el HTML usando el motor de Word**, que no soporta Flexbox, Grid, ni la mayoría de las propiedades CSS modernas. Gmail, por su parte, **recorta (`strips`) los bloques `<style>`** en varios contextos. Por eso el código de email sigue reglas de hace 15+ años (tablas, estilos inline) que serían malas prácticas en web moderno pero aquí son el estándar real.

## Estructura y layout

| Técnica | Para qué sirve |
|---|---|
| Layout basado en `<table>`, no en `<div>` | Las tablas renderizan de forma consistente incluso en motores viejos como el de Outlook/Word; un layout con `<div>` + CSS moderno se rompe en varios clientes |
| `role="presentation"` en las tablas de layout | Le dice a lectores de pantalla que la tabla es solo estructura visual, no datos tabulares — importante para accesibilidad |
| `cellpadding="0"`, `cellspacing="0"`, `border="0"` | Elimina espaciado y bordes por default que algunos clientes agregan automáticamente a las tablas |
| Tabla contenedora de ancho fijo (típicamente 600–700px) | Evita que el layout se deforme en distintos anchos de ventana/preview pane; es el estándar de facto para que el email se vea igual en la mayoría de los clientes |
| Estructura de "wrapper + container" | Una tabla externa (100% de ancho, controla el color de fondo y centra el contenido) envolviendo una tabla interna de ancho fijo (contiene el contenido real) — patrón usado en prácticamente toda plantilla de #LFC |
| Diseño de una sola columna | Minimiza el riesgo de que el layout se rompa en clientes con soporte CSS limitado; layouts multi-columna necesitan fallback robusto para no colapsar mal |

## CSS: qué usar y qué evitar

- **Estilos inline son obligatorios** en los elementos que importan visualmente — el `<style>` en el `<head>` puede ser ignorado o recortado por varios clientes (notablemente Gmail en ciertos contextos), así que el estilo crítico debe vivir directo en el atributo `style=""` del elemento.
- **Propiedades seguras** (buen soporte across clientes): `font-family`, `font-size`, `font-weight`, `line-height`, `color`, `padding`, `background-color`, `text-align`.
- **Preferir `padding` sobre `margin`** para espaciado — el soporte de `margin` es más inconsistente entre clientes que el de `padding` dentro de celdas de tabla.
- **Combinar alineación HTML + CSS**: usar `align="center"` como atributo HTML (para Outlook) **y** `margin: 0 auto` como regla CSS (para el resto de los clientes) — ninguno de los dos por sí solo cubre a todos los clientes.
- **Evitar**: hojas de estilo externas, `position: absolute`/layouts complejos, animaciones/transiciones/`:hover`, shorthand de CSS (los clientes a veces lo reescriben de forma inconsistente y rompen el valor esperado).
- **Colores**: evitar negro y blanco puros; usar variantes "off-black"/"off-white" mejora la legibilidad percibida y reduce el contraste agresivo en pantallas OLED.

## Responsive y compatibilidad con Outlook

- **Media queries como mejora progresiva, no como base**: el email debe verse aceptable incluso si el cliente ignora por completo las media queries — se construye primero la versión que funciona sin ellas, y las media queries afinan la experiencia en los clientes que sí las soportan.
- **Enfoque mobile-first**: dado que gran parte de los correos se abren en móvil, priorizar que el CTA principal quede visible arriba, sin depender de que el usuario haga scroll.
- **Comentarios condicionales de Outlook (MSO)**: bloques `<!--[if mso]> ... <![endif]-->` para inyectar HTML/VML específico solo para Outlook de escritorio (ej. fallback de un botón con `background-color` sólido cuando Outlook no soporta `background-image` en un `<a>`, o para forzar el ancho de una tabla). Es la herramienta estándar para resolver las diferencias de renderizado del motor Word sin afectar a los demás clientes.
- **Fallback de fuentes**: las web fonts (`@font-face`) no cargan en todos los clientes — siempre declarar una pila de fuentes de sistema como fallback (ej. `font-family: 'Montserrat', Arial, sans-serif`). Esto explica por qué una fuente como Montserrat puede verse distinto en Windows/Outlook: el cliente está cayendo al fallback, no es necesariamente un bug del build — confirmar contra el HTML fuente antes de "arreglar" algo que en realidad es comportamiento esperado (caso real documentado en [[LFC_20260511_Tier Translation Logic & Dynamic Content QA#6. QA de HTML/CSS — hallazgos de esta sesión|QA de esta sesión]]).

## Botones y CTAs

- **Patrón "bulletproof button"**: botón construido con una celda de tabla (`<td>`) con `background-color` y `padding` inline, conteniendo un `<a>` con texto real — no una imagen. Así el botón se ve y funciona aunque el cliente bloquee imágenes por default.
- Evitar botones que sean solo una imagen: si las imágenes están bloqueadas (comportamiento default en muchos clientes), el CTA desaparece por completo.

## Imágenes

- Definir `width` y `height` explícitos en cada `<img>` — evita que el layout "salte" mientras las imágenes cargan.
- `alt` text descriptivo siempre — tanto por accesibilidad como porque es lo único visible si el cliente bloquea imágenes.
- Probar el email con imágenes desactivadas: si el mensaje/oferta principal desaparece por completo, es señal de que el email depende demasiado de las imágenes y necesita más texto real (HTML) sosteniendo el mensaje.
- Comprimir el peso de las imágenes — impacta directamente el tiempo de carga en conexiones móviles.

## Accesibilidad

- `lang="en"` (o el idioma correspondiente) en el `<html>` tag.
- Usar headings reales (`<h1>`, `<h2>`…) para la jerarquía del contenido, no solo texto grande en negritas.
- Mantener contraste de al menos **4.5:1** entre texto y fondo.
- Texto real en HTML en vez de texto embebido en imágenes, siempre que sea posible — necesario tanto para accesibilidad como para que los filtros de spam no penalicen un email que es "solo una imagen".

## Límites técnicos a tener en cuenta

- **Gmail recorta (clipping)** cualquier email cuyo HTML supere ~102KB — el destinatario ve un aviso de "mensaje recortado" y pierde el contenido/CTA que quedó después del corte. Vale la pena revisar el peso del HTML final, no solo el de las imágenes.
- Minimizar la cantidad de links y evitar acortadores/redirects encadenados — afecta tanto la deliverability (percepción de spam) como el tracking limpio.

## QA antes de enviar

Checklist mínimo recomendado, alineado con lo que ya cubre [[QA Process]] en el proceso de LFC:

- [ ] Preview en Outlook, Gmail, Apple Mail y al menos un cliente móvil.
- [ ] Revisar el email con imágenes desactivadas.
- [ ] Validar todos los links y el contraste de color.
- [ ] Confirmar que el orden de headings tiene sentido.
- [ ] Revisar el HTML fuente (no solo el editor visual) en busca de espacios/`&nbsp;` ocultos que generan separaciones inesperadas — hallazgo real documentado en [[LFC_20260511_Tier Translation Logic & Dynamic Content QA#6. QA de HTML/CSS — hallazgos de esta sesión|esta sesión de QA]].

## Relacionado

[[Email Build Process]]
[[Email Properties]]
[[Figma Assets]]
[[QA Process]]
[[AMPscript]]
[[LFC_20260511_Tier Translation Logic & Dynamic Content QA]]

> [!note]- Fuentes
> - [Perfect Email HTML: Best Practices for 2026 — Mailgenius](https://www.mailgenius.com/email-html-best-practices/)
> - [Email Design Best Practices for 2026 — GetResponse](https://www.getresponse.com/blog/email-design-best-practices)
> - [HTML and CSS in Emails: What Works in 2026? — Designmodo](https://designmodo.com/html-css-emails/)

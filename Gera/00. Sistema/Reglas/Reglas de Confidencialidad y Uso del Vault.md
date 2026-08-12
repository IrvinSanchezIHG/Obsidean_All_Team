---
aliases:
  - Reglas de Confidencialidad
  - Reglas Corporativas
tags:
  - governance
  - confidencialidad
  - compliance
  - seguridad
  - ia
created: 2026-08-12
status: Active
---

# Reglas de Confidencialidad y Uso del Vault

> [!abstract]- Resumen
> Reglas de confidencialidad que aplican a todo el contenido de este vault y a cualquier asistente de IA que lo lea, edite o comparta. Define qué no se puede nombrar ni incluir, qué debe hacer la IA cuando sospecha que una regla no se cumple, y para qué uso está autorizada esta información.

## 1. Alcance y propósito de este vault

Este vault documenta **proceso interno del equipo de Salesforce Marketing Cloud (SFMC/LFC)** — onboarding, referencia técnica, glosario, personas y bugs. No es material de difusión externa, marketing, ni un producto para terceros. Cualquier exportación, publicación (ej. GitHub, artifacts, mensajes fuera del equipo) debe asumir como público general, no solo compañeros de equipo, salvo que se confirme explícitamente lo contrario caso por caso.

## 2. No mencionar nombres reales de empresa, agencias o aliados

- No se escribe el nombre real de la empresa dueña del negocio, ni el de agencias o empresas aliadas/proveedoras, en ningún archivo del vault.
- Convención ya vigente en todo el vault (ver [[La agencia]] y [[00 - Índice de Personas y Equipos|Personas y Equipos]] para el contexto de la migración de proceso): la empresa se refiere como **"El Grupo"** y la agencia saliente como **[[La agencia]]**. Cualquier nota nueva debe seguir esta misma convención, incluyendo tags (`el-grupo`, `la-agencia`) y nombres de archivo.
- Esta regla aplica a texto libre, tablas, frontmatter, nombres de Data Extension/journey si contienen el nombre real, capturas de pantalla y diagramas.
- **Excepción explícita**: URLs, dominios y direcciones de correo reales (ej. enlaces a `sharepoint.com`, dominios corporativos reales) se dejan sin tocar cuando son necesarios para que un link funcione — no se inventan ni se rompen enlaces reales solo por cumplir esta regla al pie de la letra. Ver criterio aplicado en el reemplazo masivo IHG→El Grupo / GALE→La agencia (commit `8caf863`).

## 3. No información de clientes ni información sensible

No se documentan en este vault:
- Datos personales o de contacto de clientes/huéspedes reales (nombres, correos, teléfonos, números de membresía, historiales de estancia).
- Credenciales, tokens, API keys, contraseñas — ni siquiera de cuentas de prueba, salvo que ya estén explícitamente marcadas como cuenta compartida de QA de bajo riesgo (ej. la cuenta Gmail de pruebas documentada en el [[Glosario de Términos y Herramientas LFC|glosario]]).
- Datos financieros, cifras de negocio no públicas, o cualquier métrica marcada como confidencial por el equipo.
- Capturas de pantalla, exports de Data Extension o resultados de query que contengan filas de datos reales de clientes — usar siempre data de prueba/dummy (ver [[QA Process]]) antes de pegar cualquier salida en una nota.

## 4. Rol de la IA: detectar y alertar, no asumir

Cualquier asistente de IA que trabaje sobre este vault (lectura, escritura, síntesis de notas, publicación) debe:

1. **Revisar antes de escribir o publicar** si el contenido involucrado podría incluir algo cubierto por las reglas 2 o 3.
2. **Cuando exista duda razonable** de que una consulta, archivo pegado, transcripción o resultado de búsqueda contiene un nombre real de empresa/agencia/aliado, datos de cliente o información sensible — no asumir que está bien, y no proceder en silencio.
3. **Insertar una alerta explícita** en la respuesta al usuario cuando se detecte o se sospeche una posible violación, antes de continuar con la tarea. Formato recomendado:

   > ⚠️ **Posible información sensible detectada**: [qué se detectó y dónde] — confirmar antes de guardar/publicar.

4. Esta alerta aplica tanto a contenido que se va a **escribir en el vault** como a contenido que se va a **compartir fuera de él** (ej. un Artifact, un mensaje, un push a GitHub) — el umbral de duda debe ser más estricto mientras más amplia sea la audiencia del destino.
5. Ante la duda, preguntar al usuario en vez de decidir unilateralmente si el contenido es publicable.

## 5. Qué hacer si se detecta una violación existente

Si se encuentra contenido ya guardado en el vault que rompe alguna de estas reglas (ej. un nombre real que se coló, datos de cliente pegados por error):
1. Señalarlo explícitamente al usuario con la ubicación exacta (archivo y línea).
2. No corregirlo ni eliminarlo unilateralmente sin confirmar — puede ser información que el usuario necesita revisar antes de decidir cómo tratarla.
3. No incluir ese contenido tal cual en ningún resumen, artifact o mensaje mientras no se resuelva.

## 6. Cómo se garantiza que la IA la vea siempre

Para que cualquier modelo o asistente de IA que trabaje con este repositorio (no solo uno en particular) esté al tanto de estas reglas sin depender de que alguien las mencione manualmente, existen dos puntos de entrada adicionales en la raíz del repositorio (fuera de `Gera/`):

- **`CLAUDE.md`** — instrucciones de proyecto que Claude Code carga automáticamente al iniciar sesión sobre este repositorio; incluye el resumen de estas reglas.
- **`README.md`** — lo primero que muestra GitHub al abrir el repositorio, con un aviso explícito dirigido a "cualquier persona o sistema de IA" que lo lea, enlazando de vuelta a esta nota.

Si se agrega otra integración de IA a este vault en el futuro (plugin de Obsidian, otro agente, etc.), su archivo de configuración/instrucciones correspondiente debería enlazar aquí también.

## Relacionado

[[La agencia]]
[[Guadalajara Email Marketing Team]]
[[00 - Índice de Personas y Equipos]]
[[QA Process]]
[[Glosario de Términos y Herramientas LFC]]

> [!info]- 🔗 Enlaces entrantes
> ```dataview
> LIST
> FROM [[Reglas de Confidencialidad y Uso del Vault]]
> WHERE file.path != this.file.path
> ```

---
name: docs-sync
description: Detectar documentación que ya no coincide con el código en Antigravity. Analiza cambios recientes en Git y verifica que los comandos documentados sigan funcionando.
---

# Sincronización de documentación

Alcance: ruta o periodo indicado (por defecto: cambios de los últimos 30 días).

## 1. Identificar archivos modificados recientemente

```bash
git log --since="30 days ago" --name-only --pretty=format: | sort -u | grep -v '^$'
```

## 2. Localizar documentación vinculada

- `README.md` y READMEs de subdirectorios asociados.
- Carpeta `docs/`.
- `AGENTS.md` (o `GEMINI.md`) — revisa sobre todo comandos de desarrollo, test y build: si un comando documentado ya no existe, el agente fallará en futuras sesiones.
- Comentarios de documentación en el código (docstrings, JSDoc, godoc).
- ADRs en `docs/decisions/` que hayan quedado superados por implementaciones posteriores.

## 3. Verificación práctica

- **Ejecuta los comandos documentados.** Un comando obsoleto que falla es el error más recurrente y el más fácil de confirmar.
- Comprueba firmas de funciones y argumentos frente a las implementaciones actuales.
- Comprueba variables de entorno documentadas frente a las que el código lee realmente.
- Verifica enlaces internos entre archivos Markdown.

## 4. Reporte de discrepancias

Documenta solo lo que sea **incorrecto**, no lo que falte (la documentación siempre está en evolución):

| Archivo | Línea | Dice actualmente | Debería decir | Gravedad |
|---|---|---|---|---|

Niveles de gravedad:
- **Rompe** (seguir la instrucción provoca un error fatal o bloqueo).
- **Desactualizado** (impreciso pero sin bloqueo total).
- **Menor** (ajuste tipográfico o de formato).

## 5. Corrección

Solicita confirmación al usuario antes de modificar archivos. Si el usuario aprueba los cambios, puedes delegar la reescritura técnica en el subagente `documentation-guide`.

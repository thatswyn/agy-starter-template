---
name: code-quality
description: Revisar la calidad del código en una ruta o en los cambios actuales en Antigravity. Ejecuta comprobaciones automáticas y aplica el checklist de code-reviewer por severidad.
---

# Revisión de calidad de código

Objetivo: la ruta indicada o, si se omite, los cambios de `git diff`.

## 1. Comprobaciones automáticas primero

Ejecuta las herramientas configuradas en el proyecto (según lo indicado en `AGENTS.md`; si no existen, omite este paso):

```bash
# linter, verificador de tipos, tests
```

Las herramientas automáticas detectan lo mecánico. Tu labor crítica comienza donde las herramientas terminan.

## 2. Revisión manual en profundidad

Aplica el checklist del subagente `code-reviewer` (puedes delegar en él con `invoke_subagent` si el volumen de cambios es extenso).

Presta atención prioritaria a:

- **Errores silenciados**: bloques `catch` vacíos, promesas sin capturar o errores que no ofrecen traza ni feedback.
- **Casos límite sin contemplar**: listas vacías, colecciones de un elemento, valores cero o negativos, `null`/`undefined`.
- **Estados en operaciones asíncronas**: contemplar siempre los tres estados (cargando, error y datos vacíos).
- **Seguridad**: validación de datos de entrada, ausencia de secretos en el código, consultas parametrizadas.
- **Liberación de recursos**: conexiones, temporizadores, listeners o descriptores de archivo abiertos.
- **Consistencia de código**: adecuación al estilo circundante en nombrado y arquitectura.

## 3. Informe estructurado

Clasifica los hallazgos por orden de severidad indicando `archivo:línea` y una propuesta de corrección:

- **Crítico** — bloquea el merge (seguridad, pérdida de datos, errores lógicos graves).
- **Aviso** — debe corregirse antes de desplegar (convenciones, rendimiento, casos límite).
- **Sugerencia** — mejora opcional (legibilidad, simplificación).

Si no existen hallazgos críticos, indícalo de manera directa y concisa.

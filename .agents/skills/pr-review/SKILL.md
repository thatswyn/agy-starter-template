---
name: pr-review
description: Revisar un pull request con los estándares del proyecto en Antigravity. Inspecciona el diff con gh, aplica el checklist de revisión y redacta el informe antes de comentar.
---

# Revisión de Pull Request

PR objetivo: número o URL del pull request.

## 1. Obtener contexto

```bash
gh pr view <PR>
gh pr diff <PR>
```

Lee detenidamente la descripción del PR antes de analizar el diff. Un cambio solo se puede juzgar contra lo que pretendía resolver.

## 2. Aplicar estándares

Consulta `AGENTS.md` (convenciones del proyecto) y el checklist de `.agents/agents/code-reviewer.md`. Para pull requests amplios, puedes delegar en el subagente `code-reviewer`.

## 3. Puntos clave a evaluar

- **¿El PR hace exactamente lo que declara?** Busca cambios colados no mencionados en la descripción.
- **¿Aborda un único tema?** Si combina una corrección con un refactor ajeno, señálalo.
- **¿Incluye tests para el comportamiento nuevo?** ¿Hay test de regresión si resuelve un bug?
- **¿Se modificó algún test existente?** Si es así, averigua por qué (puede enmascarar regresiones).
- **¿Es reversible?** ¿Qué impacto tendría un fallo en producción?

## 4. Estructura del informe

Organiza las observaciones por severidad con `archivo:línea`:

- **Crítico** — bloquea el merge.
- **Aviso** — debería corregirse antes de aprobar.
- **Sugerencia** — mejora opcional.

Si todo está correcto, dilo claramente.

## 5. Publicación

**Solicita siempre confirmación antes de publicar comentarios externos.** Muestra el borrador y pide aprobación explícita al usuario antes de ejecutar:

```bash
gh pr comment <PR> --body "..."
```

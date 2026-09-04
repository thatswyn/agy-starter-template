---
name: pr-summary
description: Generar el cuerpo de un Pull Request para la rama actual en Antigravity. Resume los cambios reales del diff en lenguaje claro y estructurado.
---

# Generar resumen de Pull Request

## 1. Inspeccionar cambios reales

```bash
git log --oneline "$(git merge-base HEAD main)"..HEAD
git diff "$(git merge-base HEAD main)"...HEAD --stat
```

(Ajusta el nombre de la rama base si no es `main`).

Examina el diff real, no solo los mensajes de commit: los commits narran el proceso de trabajo, pero el PR debe describir el resultado final.

## 2. Redacción recomendada

```markdown
## Qué cambia
- [1-3 viñetas en lenguaje claro orientadas al resultado funcional]

## Por qué
- [El problema que resuelve o la ventaja que aporta]

## Cómo probarlo
- [ ] [Pasos exactos y reproducibles para el revisor]

## Notas para quien revise
- [Decisiones de diseño, trade-offs o aspectos dejados fuera intencionalmente]
```

Si hay cambios que rompen compatibilidad (*breaking changes*), añade una sección explícita **Cambios incompatibles**.

## 3. Reglas

- Describe lo que el código hace realmente, no solo la intención original.
- Si el diff contiene cambios fuera del tema principal, menciónalos con transparencia.
- Sin relleno superfluo.

## 4. Salida

Presenta el texto en pantalla. **No ejecutes `gh pr create` a menos que el usuario lo solicite explícitamente.**

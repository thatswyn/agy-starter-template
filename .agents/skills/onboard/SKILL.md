---
name: onboard
description: Familiarizarse a fondo con una tarea o zona del código antes de empezar a trabajar en Antigravity. Explora dependencias, convenciones y tests, y guarda notas persistentes en .agents/tasks/.
---

# Onboarding de tarea o zona de código

> "Los modelos de IA son genios que empiezan de cero en cada tarea."
> — Noam Brown

Tu trabajo aquí **no** es resolver nada todavía. Es llegar a entender el terreno lo suficiente como para que la posterior implementación sea directa y sin sorpresas.

## Cómo proceder

1. **Piensa a fondo.** Esta es una fase de asimilación y comprensión, no de velocidad.
2. **Explora el código.** Si el repositorio es grande o no sabes por dónde empezar, delega en el subagente `code-explorer` con `invoke_subagent`.
3. **Lee el contexto del proyecto**: `AGENTS.md` (o `GEMINI.md`), `README.md`, los ADRs en `docs/decisions/` y el historial de git de los archivos implicados (`git log -p --follow <archivo>` para comprender por qué el código es como es).
4. **Pregunta lo que no puedas deducir.** Es mucho más económico preguntar con `ask_question` ahora que construir sobre un supuesto falso.

## Qué buscar

- Cómo funciona hoy la zona que vas a tocar y por qué fue diseñada así.
- Qué convenciones y estilos sigue el código de alrededor.
- Qué piezas dependen de esto y qué podría romperse.
- Qué tests cubren esta zona actualmente y qué casos quedan descubiertos.
- Qué intentos previos o commits anteriores existieron.

## Entrega

Escribe las notas de análisis en `.agents/tasks/{{ID_TAREA}}/onboarding.md`. Usa como `ID_TAREA` el identificador del ticket o issue, o un slug descriptivo corto.

Estructura recomendada para el archivo:

```markdown
# Onboarding: {{tarea}}

## Objetivo
Qué hay que conseguir, en una o dos frases claras.

## Estado actual
Cómo funciona el sistema hoy en día, con rutas y números de línea exactos.

## Archivos que importan
| Archivo | Rol en el sistema | Notas relevantes |

## Restricciones y trampas
Lo que no se debe romper. Dependencias sensibles o intentos fallidos previos.

## Preguntas abiertas
Aspectos que requieren confirmación antes de implementar.

## Enfoque propuesto
Esbozo preliminar de alto nivel (el plan detallado se aborda con `/plan`).
```

Ser exhaustivo en esta etapa ahorra horas de refactorización posterior.

# Contexto de producto y negocio

Aquí reside el contexto que no está presente en el código fuente: qué dolor de mercado resuelve este producto, para qué usuario o cliente objetivo, qué hipótesis se han validado y cuáles siguen siendo apuestas abiertas.

> Si tu proyecto es exclusivamente técnico y sin vertiente de negocio, puedes podar este directorio y eliminar la sección "Contexto de negocio" en `AGENTS.md`.

## Documentos habituales en este directorio

| Documento | Momento en el que se redacta |
|---|---|
| `one-pager.md` | Al inicio: definición concisa de la iniciativa y su propuesta de valor |
| `validacion-{{slug}}.md` | Cada vez que se evalúa y pone a prueba una hipótesis mediante `/idea` |
| `metricas.md` | Cuando el producto cuenta con tracción y métricas cuantificables |
| `clientes/{{nombre}}.md` | Entrevistas y notas directas de usuarios reales |

Para comenzar la definición inicial, utiliza la plantilla [`../templates/one-pager.md`](../templates/one-pager.md).

## Reglas de calidad documental

1. **Ningún número sin fuente y fecha:** las cifras de mercado son propensas a la invención especulativa. Toda cifra debe estar contrastada con enlace web, estimada con aritmética explícita o marcada como `{{PENDIENTE}}`.
2. **Separa hechos verificados de supuestos:** un supuesto escrito sin cautela tiende a considerarse un hecho en reuniones posteriores.
3. **Fecha todos los análisis:** los estudios competitivos o de precios sin fecha pierden su validez en pocos meses.
4. **Registra los experimentos fallidos:** documentar qué hipótesis se descartaron previene incurrir dos veces en el mismo error estratégico.

## Comandos y subagentes relacionados en Antigravity

- `/idea` — examen crítico de una propuesta de negocio antes de programar software.
- Subagente `market-researcher` — investigación empírica de competidores, alternativas y tendencias.
- Subagente `business-analyst` — traducción de necesidades a requerimientos funcionales y métricas.
- Subagente `product-strategist` — priorización de roadmap y delimitación del alcance del MVP.
- Skill `lean-validation` — marco metodológico completo.

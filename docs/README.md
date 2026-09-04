# Documentación del proyecto

Estructura de documentación viva del proyecto:

| Directorio | Qué contiene |
|---|---|
| [`decisions/`](./decisions/) | Architectural Decision Records (ADR): decisiones y su contexto |
| [`product/`](./product/) | Contexto de producto, validación de mercado y métricas |
| [`templates/`](./templates/) | Plantillas base para nuevos documentos |

## Criterio de documentación

Documenta exclusivamente lo que **no se puede deducir leyendo el código fuente**:
- Por qué se optó por una arquitectura o tecnología específica (→ `decisions/`).
- Qué problema de negocio o cliente resuelve este software (→ `product/`).
- Cómo levantar el proyecto de cero en local (→ `README.md` principal).
- Procedimientos ante incidentes en producción (→ runbooks).

Evita documentar estructuras o mappings que el propio código ya explicita; la documentación redundante queda obsoleta con rapidez y genera desinformación.

## Mantenimiento

La documentación desactualizada es perjudicial: induce a errores. Si un cambio de código invalida una sección documental, actualízala en el mismo commit. El comando `/docs-sync` asiste periódicamente en la detección de discrepancias.

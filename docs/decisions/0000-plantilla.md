# ADR 0000 — Plantilla de Decisión Arquitectónica

> Copia este archivo como `NNNN-titulo-en-kebab-case.md` con el siguiente número
> correlativo disponible. Los ADR son **inmutables**: si una decisión cambia con el
> tiempo, se redacta uno nuevo y se marca este como superado. Nunca se sobrescribe el original.

- **Estado**: propuesto | aceptado | superado por ADR-NNNN
- **Fecha**: AAAA-MM-DD
- **Decide**: {{quién}}

## Contexto

Qué circunstancias y necesidades técnicas o de negocio motivan esta decisión. Detalla las restricciones reales existentes: plazos de entrega, tamaño del equipo, presupuesto, deuda técnica y compromisos con terceros.

Sin esta sección, el registro pierde su valor histórico: en el futuro nadie recordará por qué las opciones eran esas y no otras.

## Alternativas consideradas

### A. {{Nombre de la alternativa}}

- **Cómo funcionaría**: {{...}}
- **A favor**: {{...}}
- **En contra**: {{...}}
- **Por qué se descartó**: {{...}}

### B. {{Nombre de la alternativa}}

- **Cómo funcionaría**: {{...}}
- **A favor**: {{...}}
- **En contra**: {{...}}
- **Por qué se descartó**: {{...}}

> Esta sección es la que más se consulta con el tiempo: cuando surja la duda de "¿por qué no usamos la tecnología X?", la respuesta fundamentada debe encontrarse aquí.

## Decisión adoptada

{{Qué se decide formalmente, en tiempo presente y voz activa: "Se adopta X para resolver Y".}}

## Consecuencias y trade-offs

**Impacto positivo**
- {{...}}

**Impacto negativo o costes asumidos**
- {{...}}

> Todo diseño técnico implica renuncias. Si un ADR no refleja consecuencias negativas, el análisis está incompleto.

**Compromisos de seguimiento**
- {{migraciones futuras, tareas de mantenimiento o límites que quedan impuestos}}

## Condiciones de reversión

{{Qué eventos, métricas o umbrales justificarían reconsiderar esta decisión en el futuro: p. ej., "si la latencia en el percentil 99 supera los 250ms con 50.000 usuarios concurrentes".}}

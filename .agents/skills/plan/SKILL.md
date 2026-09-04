---
name: plan
description: Diseñar el plan de implementación antes de escribir código en Antigravity. Analiza opciones técnicas reales, evalúa riesgos y produce pasos detallados antes de modificar archivos.
---

# Plan de implementación

Delega en el subagente `solution-architect` con `invoke_subagent` pasándole el contexto completo del requerimiento. Si el cambio es menor y evidente (un solo archivo, corrección local), puedes redactar el plan tú mismo con este formato.

## Lo que debe incluir el plan

1. **Problema**: qué hay que cambiar y por qué, en una o dos frases claras.
2. **Alcance**: archivos, módulos, dependencias y contratos externos afectados.
3. **Opciones**: al menos dos enfoques técnicos reales, detallando los contras auténticos de cada uno.
4. **Recomendación**: qué enfoque se elige y por qué, anclado en este código concreto.
5. **Pasos ordenados**: secuencia numerada con rutas de archivo, tipo de cambio (crear/modificar) y dependencias previas.
6. **Riesgos y preguntas abiertas**: lo que puede fallar o requiere validación.

## Reglas

- Basa todo en lo que hayas **observado directamente** en el repositorio. No supongas librerías ni arquitecturas no presentes.
- Prefiere cambios incrementales y fácilmente reversibles antes que reescrituras masivas.
- Evita abstracciones prematuras que no sean estrictamente necesarias hoy.
- Si una decisión condiciona radicalmente la implementación, consulta con `ask_question` antes de dar por cerrado el plan.

## Después de presentar el plan

**No comiences la implementación de inmediato.** Presenta el plan al usuario y espera su confirmación. Si la decisión adoptada tiene consecuencias arquitectónicas a medio/largo plazo, sugiere documentarla con `/adr`.

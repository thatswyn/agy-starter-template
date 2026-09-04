---
name: coding-standards
description: Disciplina de implementación para que los cambios de código sean predecibles, revisables y de bajo riesgo en Antigravity. Úsala al crear o editar código, especialmente cuando el cambio afecta a varios archivos, cuando hay que preservar comportamiento existente o cuando otra persona revisará el cambio. Cubre alcance, manejo de errores, casos límite y reporte de cambios.
---

# Estándares de implementación

## Cuándo aplica

Cualquier cambio de código en el proyecto que vaya a ser leído, revisado o mantenido. No aplica a experimentos desechables en scratchpads.

## Antes de editar

1. **Claridad en el requerimiento.** Si existen dos interpretaciones razonables que conducen a implementaciones diferentes, consulta con `ask_question`. Si solo hay una lectura natural, procede.
2. **Conjunto mínimo de cambios.** Identifica el número más reducido de archivos necesarios para solucionar el problema. No toques ocho archivos si basta con modificar dos.
3. **Estilo del vecindario.** El estilo existente en el código circundante prevalece sobre preferencias estéticas personales (nombres, estructura, densidad de comentarios e idioms).

## Durante la edición

- **Preserva el comportamiento existente** a menos que el objetivo explícito sea alterarlo. Si es indispensable romper compatibilidad, avísalo antes de aplicar el cambio.
- **Cambios pequeños y enfocados** en lugar de refactorizaciones amplias. Un refactor dentro de un fix impide una revisión limpia.
- **Caminos de fallo explícitos.** Todo lo susceptible de fallar (red, I/O, serialización, inputs externos) debe tener su rama de control y producir feedback o logging útil.
- **Sin abstracciones prematuras.** No añadas parámetros ni niveles de indirección "por si acaso". Se abstrae a partir de la segunda o tercera repetición confirmada.
- **Sin código muerto.** Si algo no se utiliza, se elimina; el control de versiones preserva el historial.
- **Comentarios solo para el 'por qué'.** No expliques lo que el código ya expresa claramente.
- **Tests sincronizados con el cambio.** Nueva funcionalidad exige nuevo test; corrección de bug exige test de regresión.

## Casos límite esenciales

- Colección vacía o colección con un único elemento.
- Cero, valores negativos y límites numéricos de tipo (MAX_INT).
- `null`, `undefined` o ausencia de clave.
- Strings vacíos, solo espacios, caracteres multilingües/unicode y cadenas de longitud extrema.
- Concurrencia e idempotencia: qué ocurre si se invoca la misma operación dos veces o simultáneamente.

## Antes de dar la tarea por finalizada

- [ ] Los tests existentes pasan sin haber sido modificados.
- [ ] La nueva funcionalidad cuenta con tests automatizados.
- [ ] Linter y verificador de tipos terminan sin errores.
- [ ] El diff contiene únicamente lo necesario para el alcance pedido.
- [ ] No existen secretos, credenciales ni rutas absolutas locales en el código.

## Cómo reportar los cambios realizados

Cuatro puntos concisos:
1. **Qué cambió** — archivos modificados e intención técnica.
2. **Por qué** — problema resuelto o riesgo mitigado.
3. **Cómo se verificó** — comandos ejecutados y su resultado literal.
4. **Qué queda pendiente** — posibles riesgos residuales o tareas de seguimiento.

## Antipatrones comunes

| Antipatrón | Por qué resulta perjudicial |
|---|---|
| Refactor colado dentro de un bugfix | Impide al revisor aislar la corrección del ruido sintáctico |
| Bloque `catch` vacío | El error persiste pero ahora es invisible para depuración |
| Modificar tests para que pasen | Enmascara regresiones reales en lugar de detectarlas |
| Abstracciones para un único uso | Aumenta la carga cognitiva sin beneficio arquitectónico |
| Declarar "listo" sin ejecutar pruebas | Leer el código no equivale a verificar su funcionamiento |

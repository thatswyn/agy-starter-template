---
name: systematic-debugging
description: Método de cuatro fases para llegar a la causa raíz de un bug en vez de parchear síntomas en Antigravity. Úsala cuando algo falla, produce un error, se comporta de forma inesperada o falla intermitentemente. Cubre reproducción, aislamiento, diagnóstico y verificación.
---

# Depuración sistemática

## La regla de oro

**No modifiques nada hasta que puedas explicar con precisión por qué falla.** Una modificación a ciegas produce dos resultados indeseables: o no funciona, o parece funcionar sin entender por qué (lo cual es peor).

## Fase 1 — Reproducir el problema

Sin reproducción no hay depuración objetiva, solo conjeturas:

- Identifica los **pasos mínimos exactos** que provocan el error.
- Determina si el fallo es **determinista o intermitente**. Si es intermitente, ejecútalo en bucle hasta aislar la condición detonante (concurrencia, estado previo, orden de ejecución).
- Registra la evidencia completa: traza de pila (*stack trace*), mensajes de error, logs relevantes e inputs exactos.
- Comprueba la expectativa: ¿qué debería ocurrir exactamente? En ocasiones el bug es una expectativa inicial equivocada.

## Fase 2 — Aislar la variable causante

Divide y vencerás: reduce el espacio de búsqueda a la mitad en cada paso:

- **Bisecar en el tiempo**: si antes funcionaba, `git bisect` localiza el commit causante en minutos sin margen para la especulación.
- **Bisecar en el espacio**: prueba con la mitad de la entrada, sin módulos accesorios o en un caso mínimo reproducible.
- **Verificar fronteras**: comprueba qué datos entran y salen en cada capa del sistema. El fallo se encuentra en la primera capa donde el estado deja de ser válido.
- **Cuestionar supuestos uno a uno**: "la configuración se carga correctamente", "el tipo es el esperado". Comprueba los hechos con logs o inspección.

## Fase 3 — Diagnosticar con certeza

Antes de modificar el código fuente, formula con claridad:

> **"El sistema falla porque [causa raíz], lo que provoca [efecto observable]."**

Si no puedes completar esta frase con certeza técnica, sigues en la Fase 2 de aislamiento.
Pregúntate además por qué ocurrió: ¿falta una validación en la capa superior?, ¿se asumió un contrato no garantizado?

## Fase 4 — Arreglar y verificar

1. **Escribe primero un test que reproduzca el fallo** y confirme que falla exactamente por la causa diagnosticada.
2. **Corrige la causa raíz**, no el síntoma superficial (evita parches de `if` que solo esquivan el caso particular).
3. **Ejecuta el test y la suite completa** para confirmar que el test pasa y no se introdujeron regresiones.
4. **Verifica si el mismo patrón erróneo existe en otras partes del repositorio.**
5. **Elimina cualquier código auxiliar de depuración** (logs temporales, prints).

## Antipatrones a evitar

| Antipatrón | Conducta correcta |
|---|---|
| Modificar código al azar "para ver si se arregla" | Detenerse y aislar la causa raíz con método |
| Dar por resuelto un bug sin entender la causa | Repetir el análisis hasta comprender la mecánica del fallo |
| Envolver el fallo en un `try/catch` vacío | Investigar por qué se lanza la excepción |
| Corregir solo el caso reportado | Analizar el patrón completo de datos |
| Culpar a librerías externas por defecto | Demostrarlo con un caso mínimo aislado antes de concluir |

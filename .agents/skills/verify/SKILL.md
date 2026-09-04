---
name: verify
description: Comprobar ejecutando que el cambio funciona de verdad en Antigravity. Ejecuta builds, suites de tests completas, linters y sondas adversarias con evidencia de terminal.
---

# Verificación de cambios

Verifica el cambio solicitado o, si no se especifica un argumento, analiza los cambios del diff actual (`git diff` y commits de la rama respecto a la principal).

Delega en el subagente `verification-specialist` mediante `invoke_subagent`. Proporciónale: la tarea original, los archivos modificados y las consideraciones clave.

## Lo que es inaceptable

Un informe donde una comprobación marcada como PASS no incluya la salida real del comando ejecutado. Leer el código fuente y concluir que "parece correcto" no constituye una verificación válida.

## Requisitos mínimos de aprobación

1. El comando de build se ejecuta con éxito sin advertencias críticas.
2. La suite de tests completa se ejecuta y pasa al 100%.
3. El linter y el verificador de tipos (si existen) terminan sin errores.
4. Se ejecuta al menos **una sonda adversaria**: valores límite, concurrencia, idempotencia o peticiones a recursos inexistentes.
5. Si el cambio corrige un bug: se comprueba primero que el bug se reproducía y que la solución lo elimina.

## Formato del informe

Para cada comprobación:
- Objetivo de la comprobación.
- Comando exacto ejecutado.
- Salida literal obtenida del terminal.
- Resultado: PASS o FAIL.

El informe debe finalizar con **una única línea de veredicto**:

```
VEREDICTO: PASS
VEREDICTO: FAIL
VEREDICTO: PARCIAL
```

(`PARCIAL` solo se admite si limitaciones del entorno impidieron ejecutar alguna prueba; las dudas sobre el resultado se consideran `FAIL`).

## Si el veredicto es FAIL

Reporta el fallo con su diagnóstico y evidencia. **No intentes corregirlo dentro de esta verificación**: verificar e implementar son funciones separadas a propósito. Devuelve el control al usuario con el diagnóstico claro.

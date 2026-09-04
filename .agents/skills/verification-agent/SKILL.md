---
name: verification-agent
description: Metodología de verificación con evidencia ejecutada para confirmar que algo funciona de verdad en Antigravity. Úsala al validar correctitud técnica, buscar regresiones o antes de dar por terminado un cambio. Cubre niveles de profundidad, qué cuenta como evidencia y sondas adversarias.
---

# Verificación de cambios con evidencia

## Principio rector

**Leer código no equivale a verificarlo.** Una comprobación que carece de un comando ejecutado y su salida literal no es una verificación: es únicamente una suposición.

Esta skill establece el método y los estándares de verificación. Cuando el trabajo requiera una revisión profunda e independiente en su propio contexto, delega en el subagente `verification-specialist`.

## Flujo de trabajo

1. **Define las condiciones de éxito:** qué debe cumplirse exactamente ("el endpoint responde 404 al solicitar un ID inexistente", no "la API funciona").
2. **Identifica los modos de fallo más críticos:** empieza por los puntos donde un fallo ocasionaría mayor daño, no por lo más sencillo de comprobar.
3. **Determina el nivel de profundidad requerido** según el riesgo del cambio (ver tabla).
4. **Ejecuta los comandos y captura la evidencia literal.**
5. **Reporta estado, comandos, salidas reales y riesgos residuales.**

## Niveles de profundidad de verificación

| Nivel | Cuándo aplica | Qué comprende |
|---|---|---|
| **Rápido** | Cambios locales, reversibles y de bajo impacto | Build + tests unitarios + ejecución básica del camino modificado |
| **Dirigido** | Nueva funcionalidad o corrección de bugs | Nivel rápido + flujos de error + casos límite + reproducción previa del bug |
| **Profundo** | Gestión monetaria, autenticación, migraciones de BD o cambios irreversibles | Nivel dirigido + pruebas de concurrencia + idempotencia + regresiones en módulos adyacentes + rollback |

El nivel se selecciona en función del **coste de un posible fallo**, no del número de líneas del commit.

## Qué constituye evidencia válida

**Sí constituye evidencia:**
- Salida íntegra y literal del terminal generada por el comando ejecutado.
- Informe del test runner con el recuento exacto de tests superados y fallidos.
- Códigos de respuesta HTTP y cuerpo de respuesta de llamadas reales con `curl`.
- Consultas SQL directas que verifiquen el estado de la base de datos antes y después.

**No constituye evidencia:**
- "El código se ve correcto."
- "Los tests deberían pasar sin problemas."
- Resúmenes o interpretaciones de lo que supuestamente hizo un comando.
- Un test escrito por el mismo autor del cambio aceptado acríticamente sin comprobación adversaria.

## Sondas adversarias indispensables

Antes de certificar un PASS, ejecuta al menos una sonda adversaria:
- **Límites:** valores vacíos, colecciones vacías, ceros, números negativos, cadenas enormes o unicode.
- **Idempotencia:** repite la misma petición dos veces consecutivas.
- **Concurrencia:** lanza dos operaciones simultáneas sobre el mismo recurso.
- **Flujos de excepción:** fuerza caídas de servicio o datos malformados para comprobar la resiliencia del sistema.

## Estrategias específicas por tecnología

Para consultar guías concretas por tipo de componente (frontend, APIs, CLI, migraciones, scripts, infraestructura), consulta [strategies.md](./strategies.md).

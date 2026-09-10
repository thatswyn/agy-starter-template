---
description: Convenciones y directrices para diseño y ejecución de pruebas en Antigravity
globs: ["tests/**", "test/**", "__tests__/**", "spec/**", "**/*.test.*", "**/*.spec.*", "**/test_*.py", "**/*_test.go"]
---

# Reglas de Testing y Calidad

Aplica estas directrices al crear, actualizar o depurar tests unitarios y de integración:

## 1. Filosofía de Pruebas
- **Comportamiento observable sobre detalles internos:** Prueba qué devuelve la función o qué efecto observable produce ante una entrada dada, no qué variables privadas modifica internamente.
- **Evita tests frágiles (*fragile tests*):** Si refactorizar el código sin cambiar su comportamiento rompe los tests, el test estaba mal diseñado (acoplado a la implementación).

## 2. Determinismo y Aislamiento
- **Cero tests intermitentes (*flaky tests*):** Prohibido el uso de esperas de tiempo arbitrarias (`sleep`, `setTimeout(500)`). Usa primitivas de sincronización deterministas (`waitFor`, `poll`, promesas resueltas).
- **Aislamiento total:** Cada test debe ser capaz de ejecutarse de forma independiente y en cualquier orden, sin depender del estado dejado por tests anteriores. Limpia el estado en `afterEach` o transacciones revertidas.

## 3. Estrategia de Mocks
- **Mocks mínimos:** Mockea exclusivamente fronteras externas fuera del control del proceso (APIs de terceros como Stripe, servidores de correo, colas externas).
- **No mockees la base de datos si puedes usar una en memoria/contenedor:** Prefiere bases de datos SQLite en memoria o contenedores efímeros para pruebas de integración de datos reales.
- **Mantén los tipos sincronizados:** Tipa estrictamente los valores devueltos por los mocks para evitar que se desfasen respecto a los contratos reales.

## 4. Cobertura de Casos Límite
- Para cada funcionalidad crítica, incluye al menos:
  1. El camino feliz (*happy path*).
  2. Entradas vacías, nulas o con tipos erróneos.
  3. Desbordamientos numéricos o límites de cadenas.
  4. Fallos de red o respuestas de error del upstream.

---
name: testing-patterns
description: Estrategia de tests agnóstica de framework para Antigravity. Úsala al escribir, arreglar o revisar tests, al decidir qué merece cobertura o cuando la suite es lenta, frágil o poco fiable. Cubre TDD, testing de comportamiento, factorías de datos, mocks y tests deterministas.
---

# Patrones de testing

## El criterio fundamental

Un test resulta valioso únicamente si **falla cuando el comportamiento del sistema se corrompe** y **no falla en ningún otro caso**. Un test que jamás ha fallado podría no estar comprobando absolutamente nada.

## Testea comportamiento, no implementación interna

```text
✗ Malo: "invoca a parseUserPayload() con el objeto json"
✓ Bueno: "rechaza el registro si el email ya existe en la base de datos"
```

El primer test se rompe ante un simple renombrado interno; el segundo solo se rompe si el comportamiento observable cambia. Si tus tests fallan con cada refactor inocuo, están acoplados a detalles privados y actúan como un obstáculo en lugar de una red de seguridad.

## El ciclo de desarrollo guiado por tests (TDD)

1. **Rojo (Red)**: escribe el test y comprueba que falla por el motivo esperado. Si pasa antes de implementar código, no está validando nada.
2. **Verde (Green)**: escribe la implementación mínima indispensable para que el test pase.
3. **Refactor**: optimiza y limpia el código sabiendo que la prueba salvaguarda la funcionalidad.

## Qué merece cobertura de tests

| Merece test riguroso | No suele merecer test unitario |
|---|---|
| Lógica de negocio y reglas de dominio | Getters, setters o mappings triviales |
| Casos límite y flujos de error | Funcionalidad interna garantizada por el framework |
| Correcciones de bugs (tests de regresión) | Detalles privados no expuestos |
| Contratos entre componentes clave | Constantes y configuraciones estáticas |
| Cálculos monetarios, fechas y permisos | Código autogenerado |

Prioriza siempre por el **coste de un fallo en producción**, no por la facilidad técnica de escribir la aserción.

## Estructura estándar: Preparar, Actuar, Comprobar (AAA)

```javascript
test("rechaza el registro si el email ya existe", async () => {
  // Preparar (Arrange)
  const usuarioExistente = crearUsuario({ email: "ana@ejemplo.com" });

  // Actuar (Act)
  const resultado = await registrar({ email: "ana@ejemplo.com" });

  // Comprobar (Assert)
  expect(resultado.error).toBe("EMAIL_DUPLICADO");
});
```

- **Un concepto por test:** si la descripción necesita una "y", son probablemente dos tests separados.
- **Sin lógica condicional en los tests:** evita bucles e instrucciones `if`; un test con lógica interna necesitaría a su vez ser testeado.

## Datos de prueba: factorías en lugar de literales

Utiliza funciones de factoría con valores por defecto válidos:

```javascript
function crearUsuario(overrides = {}) {
  return { id: "u-1", email: "test@ejemplo.com", activo: true, ...overrides };
}

// En el test solo se explicita lo relevante para ese caso concreto:
const inactivo = crearUsuario({ activo: false });
```

## Mocks: uso responsable

Mockea exclusivamente lo que está **fuera de tu control**:
- Conexiones de red y APIs de terceros.
- Reloj del sistema y temporizadores.
- Generadores de aleatoriedad.
- Pasarelas de pago y servicios externos.

No mockees tu propia lógica de dominio interno: un test donde todo está falseado solo comprueba que los mocks devuelven lo que se les ordenó devolver.

## Tests deterministas (cero "flaky tests")

1. **Aísla el estado:** cada test debe generar sus datos y limpiar al finalizar; ningún test debe depender del orden de ejecución de la suite.
2. **Controla el tiempo:** congela fechas con librerías de simulación en lugar de usar `Date.now()` o retardos con `sleep`.
3. **Espera condiciones, no tiempos fijos:** usa esperas por predicado ("esperar hasta que aparezca el elemento") en vez de esperas fijas de milisegundos.

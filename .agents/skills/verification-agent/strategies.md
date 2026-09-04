# Estrategias de verificación por tipo de cambio

Documento de apoyo para la skill `verification-agent` y el subagente `verification-specialist`.

## 1. Verificación universal (siempre obligatoria)

1. Consulta `AGENTS.md` (o `GEMINI.md`) o `README.md` para identificar los comandos del proyecto.
2. Ejecuta la compilación/build del proyecto (`run_command`).
3. Ejecuta la suite completa de tests automatizados.
4. Pasa el linter y analizador estático de tipos.
5. Comprueba los componentes contiguos al cambio introducido.

## 2. Frontend / Interfaces de usuario

- Inicia el servidor de desarrollo local y espera a que esté listo.
- Solicita los subrecursos críticos mediante `curl` (bundles JS, estilos CSS, imágenes).
- Prueba los flujos de interacción clave y recarga la página a mitad del proceso para comprobar la persistencia de estado.
- Fuerza el camino de error: desconexión de red, respuestas simuladas 500, inputs malformados.
- Revisa que no aparezcan excepciones en la consola.

## 3. Backend / APIs y Servicios

```bash
curl -i http://localhost:PUERTO/api/recurso                 # Camino feliz
curl -i -X POST -H "Content-Type: application/json" -d '{"invalido":true}' http://localhost:PUERTO/api/recurso
curl -i http://localhost:PUERTO/api/recurso/id_inexistente  # Debe devolver 404
curl -i http://localhost:PUERTO/api/recurso                 # Sin headers de auth (401/403)
```

- Analiza el código de estado, cabeceras y esquema de la respuesta.
- Prueba llamadas simultáneas o repetidas para validar idempotencia y transaccionalidad.
- Monitorea los logs del servidor durante la prueba para detectar excepciones silenciadas.

## 4. Línea de comandos (CLI) y scripts

- Ejecuta con argumentos estándar y verifica stdout, stderr y el código de retorno (`echo $?`).
- Ejecuta con `--help` y sin argumentos para comprobar el mensaje de uso.
- Proporciona argumentos inválidos: verifica que ofrezca un mensaje instructivo en lugar de un stack trace sin control.
- Envía datos por stdin: vacíos, grandes y con caracteres especiales.

## 5. Corrección de bugs

1. **Reproduce el error primero:** confirma con una prueba que el fallo se manifiesta en el estado previo.
2. Aplica la solución y comprueba que la misma prueba ahora pasa limpiamente.
3. Ejecuta la suite de regresión completa.
4. Verifica si el mismo patrón de error existe en otros módulos del proyecto.

## 6. Migraciones de bases de datos

- Aplica la migración hacia arriba (`up`) sobre un esquema con datos representativos.
- Inspecciona las tablas resultantes: índices, claves foráneas, restricciones de no-nulo.
- Ejecuta la migración inversa (`down`): confirma que revierte sin pérdida colateral de datos.
- Mide los tiempos de ejecución para prever bloqueos de tabla en despliegues reales.

## 7. Infraestructura y configuración

- Valida la sintaxis de archivos YAML/Terraform/Docker: `terraform validate`, `docker compose config`, etc.
- Ejecuta dry-runs cuando existan (`terraform plan`, `kubectl diff`).
- Confirma que no se hayan introducido credenciales o secretos en texto claro.

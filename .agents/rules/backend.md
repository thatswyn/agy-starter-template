---
description: Convenciones y directrices para API, controladores y lógica de servidor en Antigravity
globs: ["src/api/**", "src/server/**", "src/controllers/**", "src/services/**", "src/routes/**", "**/*.py", "**/*.go", "src/models/**"]
---

# Reglas de Backend y Servicios

Aplica estas directrices al crear o modificar endpoints, servicios de dominio y modelos de datos:

## 1. Validación en Frontera (Boundary Validation)
- **Valida todo input externo:** Todo cuerpo de petición (request body), query param o cabecera debe validarse con esquemas estrictos (Zod, Pydantic, etc.) antes de ser procesado por la capa de negocio.
- **Rechazo temprano:** Devuelve errores `400 Bad Request` o `422 Unprocessable Entity` con mensajes precisos en el primer fallo de validación.

## 2. Control de Flujo y Errores
- **Retornos tempranos (Early returns):** Valida precondiciones al inicio de las funciones y haz return anticipado. Mantén la anidación en un máximo de 2 niveles.
- **Manejo explícito de excepciones:** Prohibidos los bloques `try/catch` vacíos o genéricos. Captura errores específicos y transpórtalos con contexto relevante.
- **Códigos HTTP semánticos:** `200` (OK), `201` (Created), `204` (No Content), `401` (Unauthorized), `403` (Forbidden), `404` (Not Found), `409` (Conflict), `500` (Internal Error).

## 3. Seguridad y Privacidad en Logs
- **Nunca registres datos sensibles en logs:** Prohibido loguear contraseñas, tokens JWT, números de tarjeta o datos personales identificables (PII).
- **Consultas parametrizadas:** Prohibida la concatenación directa de cadenas en consultas SQL. Utiliza siempre parámetros vinculados (prepared statements / ORM).

## 4. Idempotencia y Transacciones
- Las mutaciones complejas que afecten a múltiples entidades deben ejecutarse dentro de una transacción atómica de base de datos.
- Diseña operaciones críticas (pagos, envíos, webhooks) de manera idempotente con claves de unicidad.

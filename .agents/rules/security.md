---
description: Directrices estrictas de seguridad de código y prevención de fugas de datos en Antigravity
globs: ["**/*auth*", "**/*security*", "**/*secret*", "**/*permission*", "src/middleware/**", ".env*"]
---

# Reglas de Seguridad y Autenticación

Aplica estas directrices al manipular credenciales, lógica de autorización, sesiones y criptografía:

## 1. Gestión Cero-Secretos en Código
- **Prohibición absoluta:** Nunca incluyas claves de API, tokens privados, certificados o credenciales en el código fuente ni en comentarios.
- **Entorno aislado:** Todo secreto reside en `.env` (excluido en `.gitignore`) y se inyecta mediante variables de entorno en tiempo de ejecución.
- Si detectas una credencial accidentalmente commiteada, notifícalo de inmediato y trátala como comprometida (rotación obligatoria).

## 2. Autenticación y Autorización
- **Principio de mínimo privilegio:** Cada endpoint o consulta debe exigir explícitamente el rol o permiso mínimo requerido para acceder al recurso.
- **Valida siempre en el servidor:** Nunca confíes en autorizaciones o validaciones ejecutadas en el cliente (frontend).
- **Protección contra ataques comunes:**
  - Emplea protección CSRF en endpoints con mutaciones basadas en cookies.
  - Configura cabeceras seguras (`Content-Security-Policy`, `X-Frame-Options: DENY`, `Strict-Transport-Security`).
  - Utiliza algoritmos de hash robustos con sal para contraseñas (`Argon2id` o `bcrypt`).

## 3. Sanitización e Inyección
- Aplica escape automático en plantillas para evitar XSS (Cross-Site Scripting).
- Deshabilita la ejecución arbitraria de comandos (`eval`, `exec`) con entradas derivadas de usuarios.

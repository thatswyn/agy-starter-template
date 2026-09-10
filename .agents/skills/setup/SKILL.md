---
name: setup
description: Adapta este template a un proyecto concreto en Antigravity (ejecútalo una sola vez, justo después de clonar el repo). Configura AGENTS.md, aplica presets por stack, poda roles innecesarios y verifica los hooks.
---

# Configurar el proyecto en Antigravity (v2)

Este repositorio es una plantilla inicial (`agy-starter-template`). Tu objetivo es convertirlo en el arnés a medida de **este** proyecto concreto en menos de 5 minutos. Es una operación de una sola vez.

> 💡 **Vía rápida:** Puedes ejecutar directamente en terminal `./scripts/init-project.sh` para una configuración guiada instantánea con presets.

---

## Paso 1 — Entender el proyecto y elegir Preset

Si el usuario proporcionó contexto en el comando, úsalo. Si falta información fundamental, usa `ask_question` para consultar lo imprescindible:

- **Nombre del proyecto** y descripción breve (qué dolor resuelve).
- **Tipo de proyecto**:
  - `both`: Software + Validación de Negocio (camino dual completo).
  - `software`: Puramente técnico (eliminará roles de negocio).
  - `business`: Solo validación lean de modelo de negocio (sin código inicial).
- **Preset tecnológico (si hay código)**:
  - `nextjs`: TypeScript + Next.js + Tailwind + Vitest + Biome (`pnpm`)
  - `fastapi`: Python + FastAPI + Pydantic + Pytest + Ruff (`uv`)
  - `go`: Go + Gin + SQLX + Golangci-lint (`go`)
  - `rust`: Rust + Axum + SQLx + Clippy (`cargo`)
  - `custom`: Otro stack a definir manualmente

---

## Paso 2 — Rellenar AGENTS.md y GEMINI.md

`AGENTS.md` es el archivo central de contexto leído al inicio de cada sesión (mantenido sincronizado con `GEMINI.md`):

1. Sustituye **todos** los `{{PLACEHOLDERS}}` por los valores reales del proyecto o aplica los comandos del preset seleccionado.
2. Si el proyecto es exclusivamente de negocio, elimina la sección de stack. Si es puramente técnico, elimina el contexto de negocio.
3. Verifica los comandos que escribas: si indicas `pnpm test` o `pytest`, comprueba que el tooling o script correspondiente exista.
4. Mantén las directrices de `AGENTS.md` compactas (<80 líneas). Recuerda que las directrices detalladas por ámbito residen en `.agents/rules/` (`frontend.md`, `backend.md`, `testing.md`, `security.md`).

---

## Paso 3 — Ajustar la configuración

- **`.agents/settings.json`**: confirma `AGY_PROTECTED_BRANCHES` (por defecto `main master`) y ajusta la lista de permisos en `allow` a los binarios reales del stack.
- **`.agents/mcp_config.json` y `.mcp.json`**: elimina servidores MCP que no vayas a conectar para no sobrecargar el contexto.
- **`.env.example`**: ajusta variables de entorno requeridas por la aplicación.
- **`.gitignore`**: asegura que contenga las exclusiones propias del stack elegido.

---

## Paso 4 — Podar lo que sobra

Pregunta al usuario antes de eliminar, resumiendo la lista de archivos:

- **Si NO es un proyecto de negocio**:
  - Elimina `.agents/agents/{business-analyst,market-researcher,product-strategist}.md`
  - Elimina `.agents/skills/lean-validation/`, `.agents/skills/idea/`, y la carpeta `docs/product/`
  - Elimina la entrada `lean-validation` de `.agents/hooks/skill-rules.json`
- **Si NO hay código todavía**:
  - Elimina `.agents/skills/{testing-patterns,systematic-debugging,code-quality,pr-review,pr-summary}/`
  - Elimina los workflows de `.github/workflows/`
- **Si no usas GitHub**:
  - Elimina la carpeta `.github/`
- **Si no usas Linear o Jira**:
  - Elimina `.agents/skills/ticket/`

---

## Paso 5 — README del proyecto

El `README.md` actual describe la plantilla. Sustitúyelo utilizando `docs/templates/README.template.md` como base adaptada a este proyecto.

---

## Paso 6 — Comprobar que todo funciona

Ejecuta la suite de validación automatizada con `run_command` y reporta el resultado:

```bash
bash tests/test-hooks.sh
grep -n "{{" AGENTS.md
```

- La suite `tests/test-hooks.sh` debe finalizar con **0 fallos**.
- El comando `grep` debe salir **completamente vacío** (cero placeholders pendientes).

---

## Paso 7 — Resumen final

Presenta al usuario:
1. Resumen de configuración aplicada (preset, tipo y herramientas activas).
2. Lista de archivos modificados y podados.
3. Pasos manuales pendientes (crear `.env`, dar de alta secretos en GitHub).
4. Siguiente paso recomendado: `/idea` para validar negocio o `/onboard` para empezar a codificar.

**No hagas commit ni push.** Deja los cambios listos en el árbol de trabajo para revisión humana.

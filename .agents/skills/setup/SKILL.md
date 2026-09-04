---
name: setup
description: Adapta este template a un proyecto concreto en Antigravity (ejecútalo una sola vez, justo después de clonar el repo). Configura AGENTS.md, poda roles y skills innecesarias, y verifica los hooks.
---

# Configurar el proyecto en Antigravity

Este repositorio es una plantilla inicial (`agy-starter-template`). Tu objetivo es convertirlo en el esqueleto a medida de **este** proyecto concreto. Es una operación de una sola vez.

## Paso 1 — Entender el proyecto

Si el usuario proporcionó contexto en el comando, úsalo. Si falta información fundamental, usa `ask_question` para consultar lo imprescindible:

- ¿Nombre del proyecto?
- ¿Es un proyecto de software, una idea de negocio que todavía no tiene código, o ambos?
- Si hay código: ¿qué stack (lenguaje, framework) y qué gestor de paquetes se utiliza?
- ¿Cuál es el problema principal que resuelve, en una frase?

No preguntes lo que puedas deducir inspeccionando el repositorio (`package.json`, `pyproject.toml`, `go.mod`, `Cargo.toml`, etc.).

## Paso 2 — Rellenar AGENTS.md y GEMINI.md

`AGENTS.md` es el archivo central de contexto que Antigravity lee al inicio de cada sesión:

1. Sustituye **todos** los `{{PLACEHOLDERS}}` por valores reales del proyecto.
2. Borra las secciones que no apliquen (si no hay código todavía, elimina la sección de stack; si es puramente técnico, elimina el contexto de negocio).
3. Verifica los comandos que escribas: si pones `npm test`, comprueba con `view_file` que dicho script existe en `package.json`. Un comando falso en `AGENTS.md` provocará fallos en futuras sesiones.
4. Mantén `GEMINI.md` sincronizado o enlazado con `AGENTS.md`.

## Paso 3 — Ajustar la configuración

- **`.agents/settings.json`**: revisa `AGY_PROTECTED_BRANCHES` (si la rama principal es `main`) y ajusta la lista de permisos en `allow` a los comandos reales del stack.
- **`.agents/mcp_config.json` y `.mcp.json`**: elimina los servidores MCP que no se vayan a utilizar para ahorrar contexto en las sesiones. Si no se usará ninguno, bórralos.
- **`.env.example`**: quita variables innecesarias y añade las del proyecto. No crees el archivo `.env` tú mismo: lo creará el usuario con sus secretos.
- **`.gitignore`**: añade las carpetas o artefactos propios del stack elegido.

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

Si eliminas alguna skill, quita su entrada en `.agents/hooks/skill-rules.json`.

## Paso 5 — README del proyecto

El `README.md` actual describe la plantilla. Sustitúyelo utilizando `docs/templates/README.template.md` como base adaptada a este proyecto.

## Paso 6 — Comprobar que todo funciona

Ejecuta con `run_command` estas comprobaciones y reporta el resultado:

```bash
node --check .agents/hooks/skill-eval.cjs
node -e "JSON.parse(require('fs').readFileSync('.agents/settings.json','utf8'))"
bash .agents/hooks/protect-branch.sh; echo "exit=$?"
grep -n "{{" AGENTS.md
```

El último comando `grep` debe salir **completamente vacío**. `AGENTS.md` no puede quedar con ningún placeholder pendiente.

## Paso 7 — Resumen final

Presenta al usuario:
1. Lista de archivos modificados y eliminados.
2. Pasos que debe realizar manualmente (crear `.env`, dar de alta secretos en GitHub).
3. Siguiente paso sugerido: `/idea` si es validación de negocio, `/onboard` si es desarrollo sobre código existente.

**No hagas commit ni push.** Deja los cambios en el árbol de trabajo para que el usuario los revise antes de commitear.

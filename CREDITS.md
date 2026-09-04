# Créditos y atribución

Este template (`agy-starter-template`) nace de la adaptación y evolución de proyectos pioneros en la comunidad de desarrollo asistido por IA, adaptado integralmente para la plataforma **Google Antigravity (AGY)**.

## Fuentes y proyectos originales

### [thatswyn/claude-code-starter-template](https://github.com/thatswyn/claude-code-starter-template)
Repositorio original desarrollado para Claude Code, que consolidó la estructura de 9 roles especializados, 11 comandos slash, 6 skills transversales y lifecycle hooks agnósticos de stack.

**Adaptaciones realizadas para `agy-starter-template`:**
- Migración completa a la arquitectura de **Google Antigravity**:
  - Unificación de directrices en `AGENTS.md` y `GEMINI.md`.
  - Integración nativa en el directorio de personalizaciones `.agents/`.
  - Adaptación de subagentes al formato de Antigravity con frontmatter YAML (`subagent: true`) y catálogo de herramientas nativas (`run_command`, `view_file`, `replace_file_content`, `find_by_name`, `grep_search`, `ask_question`).
  - Transformación de los comandos a **Skills de Antigravity (`.agents/skills/<name>/SKILL.md`)**, permitiendo su uso directo como slash commands (`/<name>`) y su revelación progresiva (*progressive disclosure*).
  - Reescritura del protocolo de **Lifecycle Hooks (`.agents/hooks.json`)** adaptado al contrato JSON de Antigravity (`PreToolUse`, `PostToolUse`, `PreInvocation`).
  - Adaptación de la configuración MCP a `.agents/mcp_config.json` y `.mcp.json`.
  - Plantillas de orquestación y prompts adaptados para el **SDK de Python de Antigravity** (`google-antigravity`) y APIs de Gemini.

### [ChrisWiles/claude-code-showcase](https://github.com/ChrisWiles/claude-code-showcase)
Origen de los conceptos de modularización en roles, comandos y automatización mediante hooks en el ciclo de vida del agente.

### [repowise-dev/claude-code-prompts](https://github.com/repowise-dev/claude-code-prompts)
Inspiración original para los prompts de roles de ingeniería de software (explorador, arquitecto, revisor, verificador) y las metodologías de depuración sistemática y testing. Licencia MIT — Copyright (c) 2026 Swati Ahuja.

### Google Antigravity
Desarrollado por el equipo de Google DeepMind para desarrollo agentic AI-first. Documentación y plataforma oficial: <https://antigravity.google>.

## Licencia

Este proyecto está distribuido bajo la licencia MIT. Consulta el archivo [LICENSE](./LICENSE) para más detalles.

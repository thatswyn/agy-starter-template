# Antigravity Starter Template (`agy-starter-template`)

Un punto de partida integral para arrancar cualquier proyecto con **Google Antigravity (AGY)**: desarrollo de software, validación de una idea de negocio, o las dos cosas a la vez.

Clonas el repositorio, ejecutas `/setup` en el chat de Antigravity, y en quince minutos dispones de un entorno donde el agente conoce tus convenciones, delega en el rol especializado adecuado y verifica su propio trabajo mediante ejecución real en lugar de limitarse a decir que funciona.

> **Empieza aquí:** [GUIDE.md](./GUIDE.md) — la configuración paso a paso.
>
> **¿Prefieres verlo en acción?** [EXAMPLE.md](./EXAMPLE.md) — un recorrido completo, desde una idea de SaaS hasta el primer Pull Request, mostrando el orden exacto de cada comando y su justificación.

---

## Arranque rápido (v2)

### Opción A — Asistente CLI de un paso (recomendado)

```bash
git clone https://github.com/thatswyn/agy-starter-template mi-proyecto
cd mi-proyecto
./scripts/init-project.sh
agy
```

`./scripts/init-project.sh` ofrece un menú interactivo con **Presets tecnológicos listos para producción** (Next.js, FastAPI, Go, Rust, o Solo Negocio), sustituye los comandos de `AGENTS.md`, poda automáticamente los roles innecesarios y verifica el arnés en menos de 10 segundos.

### Opción B — Desde el chat de Antigravity

```bash
git clone https://github.com/thatswyn/agy-starter-template mi-proyecto
cd mi-proyecto
rm -rf .git && git init
agy
```

Y dentro de la consola o chat de Antigravity:

```text
/setup mi-proyecto es {{una frase sobre qué problema resuelve}}
```

`/setup` te guiará para elegir el preset de tu stack, rellenará `AGENTS.md` (<80 líneas para mínimo consumo de tokens), podará módulos sobrantes y validará la suite de tests. Guía detallada en [GUIDE.md](./GUIDE.md).

---

## Qué incluye este template

### 1. 9 subagentes especializados a los que Antigravity delega (`.agents/agents/`)

| Subagente | Entra cuando |
|---|---|
| `code-explorer` | Hay que localizar dónde vive algo en el repositorio (estrictamente solo lectura) |
| `solution-architect` | Hay que diseñar arquitectura y evaluar opciones antes de escribir código |
| `code-reviewer` | Hay código implementado que revisar antes de abrir un PR |
| `verification-specialist` | Hay que comprobar que un cambio funciona **ejecutando tests, build y sondas** |
| `documentation-guide` | Hay que redactar o sincronizar documentación técnica |
| `git-workflow` | Gestión de ramas, commits limpios y redacción de PRs |
| `business-analyst` | Una iniciativa de negocio debe traducirse a requerimientos funcionales y métricas |
| `market-researcher` | Hace falta investigar competidores, alternativas reales y tamaño de mercado |
| `product-strategist` | Hay más ideas que capacidad y hay que priorizar el roadmap y delimitar el MVP |

### 2. 11 slash commands listos para usar (`.agents/skills/`)

Escribe `/<comando>` en el chat de Antigravity:

`/setup` · `/onboard` · `/plan` · `/verify` · `/code-quality` · `/pr-review` ·
`/pr-summary` · `/docs-sync` · `/ticket` · `/idea` · `/adr`

### 3. 6 skills procedimentales con revelación progresiva

Conocimiento que Antigravity carga bajo demanda cuando el tema aparece:

`coding-standards` · `systematic-debugging` · `testing-patterns` ·
`verification-agent` · `prompt-architect` · `lean-validation`

### 4. 3 lifecycle hooks deterministas (`.agents/hooks.json`)

| Hook | Evento | Qué garantiza |
|---|---|---|
| **Protección de rama** (`protect-branch.sh`) | `PreToolUse` | Que el agente no edite archivos directamente en la rama principal (`main`) |
| **Formateo automático** (`auto-format.sh`) | `PostToolUse` | Que todo archivo modificado quede formateado según las herramientas del proyecto |
| **Evaluación de skills** (`skill-eval.sh`) | `PreInvocation` | Sugerencias contextuales de metodologías relevantes antes de responder |

Los tres hooks son **seguros y no bloqueantes si falta alguna herramienta**: sin Git no bloquean, sin formateador no formatean y sin Node no fallan. Detectan automáticamente npm, pnpm, Python, Go, Rust, Ruby y PHP, y nunca descargan paquetes por su cuenta.

### 5. Y además

- **`AGENTS.md` (y `GEMINI.md`)** — plantilla ultraligera (<80 líneas) leída al inicio de sesión sin saturar la ventana de tokens.
- **Reglas por ámbito en `.agents/rules/`** — directrices que solo se activan al modificar archivos de frontend, backend, testing o seguridad.
- **Suite de pruebas de arnés (`tests/test-hooks.sh`)** — validación automatizada de los hooks bash/node.
- **Inicializador de proyectos (`scripts/init-project.sh`)** — configuración en 10 segundos con presets de stack.
- **4 workflows de GitHub Actions** — validación de hooks en CI (`test-template.yml`), revisión de PRs, sincronización de docs y auditoría de seguridad.
- **`.mcp.json` / `mcp_config.json`** — servidores MCP listos para conectar con herramientas externas (GitHub, Linear, bases de datos).
- **Plantillas de documentos** — registros de arquitectura (ADR), one-pager de negocio y validación lean.
- **Prompts para el SDK de Python** — plantillas en `.agents/prompts/` para agentes autónomos y orquestadores con `google-antigravity`.

---

## Dos caminos de desarrollo

**Proyecto de software:**
`/onboard` para asimilar el terreno → `/plan` para diseñar el enfoque → implementar código → `/verify` para comprobar ejecutando → `/pr-summary` para entregar.

**Iniciativa o idea de negocio:**
`/idea` somete la iniciativa a un examen riguroso: hipótesis ordenadas por daño letal, evidencia contrastada de mercado y el experimento más económico que resuelve la incertidumbre más peligrosa. No está diseñado para adular la idea, sino para encontrar temprano el fallo que la invalidaría.

Si tu proyecto corresponde a uno solo de los caminos, `/setup` o `init-project.sh` poda automáticamente el resto.

---

## Estructura del repositorio

```text
AGENTS.md                 Contexto principal que Antigravity lee en cada sesión (<80 líneas)
GEMINI.md                 Symlink de compatibilidad con motores Gemini / Antigravity
GUIDE.md                  Guía de configuración paso a paso
EXAMPLE.md                Ejemplo completo de recorrido real
scripts/
  init-project.sh         Inicializador CLI con presets por tecnología
tests/
  test-hooks.sh           Suite de pruebas automatizada para los hooks
.agents/
  settings.json           Permisos y variables de entorno del proyecto
  hooks.json              Configuración de lifecycle hooks nativos
  agents/                 Los 9 subagentes especializados
  skills/                 Los 11 slash commands + 6 skills procedimentales
  rules/                  Reglas por ámbito (frontend, backend, testing, security)
  hooks/                  Scripts ejecutables de protección y formateo
  prompts/                Contratos de referencia para el SDK de Antigravity
.mcp.json                 Configuración de servidores Model Context Protocol
.github/workflows/        4 flujos de CI con GitHub Actions (incluyendo test-template.yml)
docs/
  decisions/              ADRs (Architectural Decision Records)
  product/                Contexto y validación de negocio (/idea)
  templates/              Plantillas de documentos base
```

---

## La filosofía de diseño: dónde colocar cada instrucción

En Antigravity, elegir el lugar correcto para cada instrucción evita el desperdicio de contexto:

| Quiero que Antigravity... | Debe ubicarse en |
|---|---|
| ...lo sepa siempre, en cada sesión | `AGENTS.md` / `GEMINI.md` |
| ...lo sepa cuando el tema aparezca | Una skill en `.agents/skills/<name>/SKILL.md` |
| ...cambie de rol y contexto para una tarea específica | Un subagente en `.agents/agents/<name>.md` |
| ...lo ejecute cuando yo se lo pida explícitamente | Un slash command en `.agents/skills/<name>/SKILL.md` |
| ...lo aplique en directorios determinados | Reglas en `.agents/rules/` |
| ...lo garantice de forma **determinista y obligatoria** | Un hook en `.agents/hooks.json` |

Un prompt *sugiere*; un hook *garantiza*. Todo lo que va en `AGENTS.md` compite por atención en cada turno: lo que aplica a una fracción de las tareas pertenece a una skill, no a una línea más en el contexto global.

---

## Créditos

Adaptado y evolucionado a partir de [thatswyn/claude-code-starter-template](https://github.com/thatswyn/claude-code-starter-template), [ChrisWiles/claude-code-showcase](https://github.com/ChrisWiles/claude-code-showcase) y [repowise-dev/claude-code-prompts](https://github.com/repowise-dev/claude-code-prompts), adaptado específicamente para el ecosistema de **Google Antigravity**. Consulta [CREDITS.md](./CREDITS.md) para más detalles.

Licencia MIT — ver [LICENSE](./LICENSE).

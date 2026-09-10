# Guía de configuración de Antigravity Starter Template

Todo lo necesario para convertir este template en un proyecto productivo con **Google Antigravity**.

El proceso inicial toma unos **15 a 20 minutos**. Los pasos 1 a 5 son indispensables; a partir del paso 6 se configuran integraciones opcionales según las necesidades de tu sistema.

- [Antes de empezar](#antes-de-empezar)
- [Paso 1 — Clonar y preparar](#paso-1--clonar-y-preparar)
- [Paso 2 — Seleccionar el tipo de proyecto](#paso-2--seleccionar-el-tipo-de-proyecto)
- [Paso 3 — Rellenar AGENTS.md](#paso-3--rellenar-agentsmd)
- [Paso 4 — Permisos y lifecycle hooks](#paso-4--permisos-y-lifecycle-hooks)
- [Paso 5 — Verificar el funcionamiento](#paso-5--verificar-el-funcionamiento)
- [Paso 6 — Variables de entorno (opcional)](#paso-6--variables-de-entorno-opcional)
- [Paso 7 — Servidores MCP (opcional)](#paso-7--servidores-mcp-opcional)
- [Paso 8 — GitHub Actions (opcional)](#paso-8--github-actions-opcional)
- [Primer uso](#primer-uso)
- [Mantenimiento continuo](#mantenimiento-continuo)
- [Resolución de problemas frecuentes](#resolución-de-problemas-frecuentes)
- [Referencia rápida](#referencia-rápida)

---

## Antes de empezar

### Antigravity instalado y autenticado

Puedes utilizar cualquiera de las superficies de Antigravity:
- **Antigravity CLI (`agy`)**: la interfaz de terminal ligera.
- **Antigravity IDE**: el entorno AI-first de desarrollo.
- **Antigravity 2.0**: la aplicación de escritorio para orquestación.

Comprueba que el CLI de Antigravity esté disponible en tu terminal:

```bash
agy --help
```

### Herramientas complementarias (opcionales)

| Herramienta | Utilidad en el template | Comportamiento en su ausencia |
|---|---|---|
| `git` | Hook de protección de rama y comandos de PR | El hook no bloquea; funciona en modo abierto |
| `node` | Hook de sugerencia de skills (`skill-eval`) | No-op silencioso (las skills se descubren igualmente por Antigravity) |
| `jq` / `python3` | Lectura de payloads en los hooks bash | Se utiliza la alternativa disponible de forma transparente |
| `gh` | Interacción con GitHub (PRs, issues, comentarios) | Las revisiones se realizan localmente sin publicar a GitHub |

Los scripts de `.agents/hooks/` están programados con diseño defensivo: **nunca interrumpen ni rompen tu sesión de trabajo** si una herramienta accesoria no está instalada.

---

## Paso 1 — Clonar y preparar

Clona el template para tu nuevo proyecto:

```bash
git clone https://github.com/thatswyn/agy-starter-template mi-proyecto
cd mi-proyecto
rm -rf .git && git init
```

> Reinicializar Git con `rm -rf .git && git init` elimina el historial del template para que tu proyecto arranque con un historial limpio.

---

## Paso 2 — Seleccionar el tipo de proyecto

El template abarca proyectos de **software**, **validación de ideas de negocio**, o **ambos**. Elimina los componentes que no vayas a utilizar para optimizar el consumo de contexto del modelo.

### Opción A — Script de inicialización con Presets (más rápido, ~10 segundos)

Ejecuta el asistente interactivo con presets tecnológicos listos para producción:

```bash
./scripts/init-project.sh
```

Te permitirá elegir tu tecnología (Next.js/TS, Python/FastAPI, Go, Rust o Solo Negocio), adaptará `AGENTS.md`, podará automáticamente los subagentes innecesarios y validará el arnés.

### Opción B — Asistente interactivo en Antigravity

Inicia Antigravity en el directorio del proyecto y lanza el comando de configuración inicial:

```bash
agy
```

```text
/setup mi-proyecto es {{una frase sobre qué problema resuelve}}
```

`/setup` te guiará para seleccionar tu preset, rellenará `AGENTS.md`, adaptará las configuraciones, eliminará los roles innecesarios y comprobará que no queden `{{PLACEHOLDERS}}` sin resolver. Luego continúa directamente en el [Paso 5](#paso-5--verificar-el-funcionamiento).

### Opción C — A mano

**Proyecto puramente técnico (software sin análisis de negocio):**
```bash
rm .agents/agents/{business-analyst,market-researcher,product-strategist}.md
rm -rf .agents/skills/lean-validation .agents/skills/idea docs/product
```
*(Quita también la entrada `lean-validation` de `.agents/hooks/skill-rules.json`).*

**Iniciativa o idea de negocio sin código inicial:**
```bash
rm -rf .agents/skills/{testing-patterns,systematic-debugging,code-quality,pr-review,pr-summary}
rm -rf .github
```

**Si no utilizas Linear ni Jira:**
```bash
rm -rf .agents/skills/ticket
```

---

## Paso 3 — Rellenar AGENTS.md

**Este es el archivo más importante del proyecto.** Antigravity lo lee al comenzar cada conversación.

```bash
$EDITOR AGENTS.md
```

1. **Reemplaza todos los `{{PLACEHOLDERS}}`:** cada placeholder no resuelto es una instrucción confusa para el agente.
2. **Poda secciones no aplicables:** si aún no hay código, omite comandos de compilación.
3. **Verifica los comandos declarados:** si indicas `npm test`, asegúrate de que el script exista en tu `package.json`.
4. **Alimenta las trampas conocidas:** la sección final de notas es donde el proyecto gana valor a lo largo del tiempo. Cada vez que el agente tropiece con una peculiaridad del entorno dos veces, documéntala allí.

---

## Paso 4 — Permisos y lifecycle hooks

Configura las opciones en `.agents/settings.json` y `.agents/hooks.json`.

### Ramas protegidas
En `.agents/settings.json` o mediante variable de entorno:
```json
"env": {
  "AGY_PROTECTED_BRANCHES": "main master"
}
```
El hook `protect-branch.sh` impedirá que el agente edite archivos en la rama principal, forzando la creación de ramas de trabajo (`git checkout -b iniciales/descripcion`).

### Política de permisos
- **`allow`**: comandos seguros de solo lectura (`git status`, `ls`, `grep`, `cat`).
- **`ask`**: comandos que publican o modifican estado compartido (`git push`, `gh pr create`).
- **`deny`**: archivos sensibles bloqueados contra lectura (`.env`, certificados `*.pem`, `*.key`).

---

## Paso 5 — Verificar el funcionamiento

Ejecuta estas comprobaciones automáticas:

```bash
# 1. Ejecutar la suite completa de pruebas automatizada
bash tests/test-hooks.sh

# 2. Comprobar que no quedan placeholders pendientes en AGENTS.md
grep -n "{{" AGENTS.md
```

**Resultado esperado:**
1. Todos los tests superados con `✅`.
2. **Salida completamente vacía** en el grep de `AGENTS.md`.

Inicia Antigravity y haz una prueba de fuego:
```text
¿Qué comandos y convenciones tiene configurados este proyecto?
```
Si responde citando fielmente tu `AGENTS.md`, la integración está activa y funcionando.

---

## Paso 6 — Variables de entorno (opcional)

Si vas a utilizar el SDK de Python de Antigravity, GitHub Actions o herramientas MCP:

```bash
cp .env.example .env
$EDITOR .env
```

Define tu `GEMINI_API_KEY` y `GITHUB_TOKEN`. Recuerda que `.env` está en `.gitignore` y protegido contra lectura accidental del agente.

---

## Paso 7 — Servidores MCP (opcional)

Los servidores del Model Context Protocol (MCP) conectan Antigravity con fuentes de datos externas:

```bash
$EDITOR .mcp.json
```

Vienen preconfigurados `github` y `filesystem`, y ejemplos comentados para `linear`, `sentry`, `notion` y `postgres`.

---

## Paso 8 — GitHub Actions (opcional)

El template incluye 4 flujos de CI en `.github/workflows/`:
- `test-template.yml`: validación automatizada del arnés y hooks del template.
- `pr-agy-review.yml`: revisión automática de diffs de pull requests.
- `scheduled-docs-sync.yml`: revisión semanal de discrepancias entre código y documentación.
- `scheduled-dependency-audit.yml`: auditoría semanal de vulnerabilidades en dependencias.

Para habilitarlos, añade el secreto `GEMINI_API_KEY` en la configuración de GitHub de tu repositorio (*Settings → Secrets and variables → Actions*).

---

## Primer uso

### Si desarrollas software:
```text
/onboard {{la primera tarea a realizar}}
/plan {{lo que hay que construir}}
# ... implementación ...
/verify
/code-quality
/pr-summary
```

### Si evalúas una idea de negocio:
```text
/idea {{tu propuesta de valor en una o dos frases}}
```
Examina la iniciativa, busca las hipótesis más peligrosas, investiga el mercado con `market-researcher` y define el experimento de validación más económico en `docs/product/`.

### Registro de decisiones:
```text
/adr {{título de la decisión técnica tomada}}
```

---

## Mantenimiento continuo

- **Cuando el agente cometa el mismo error dos veces:** documenta la regla en las trampas conocidas de `AGENTS.md`.
- **Cuando evoluciones una convención técnica:** actualiza la skill respectiva (`coding-standards`, `testing-patterns`) en el mismo commit.
- **Cuando cambies comandos del proyecto:** mantenlos al día en `AGENTS.md`.
- **Periódicamente:** ejecuta `/docs-sync` para mantener alineados los manuales con la realidad del código.

---

## Resolución de problemas frecuentes

### Antigravity parece ignorar AGENTS.md
- Asegúrate de haber iniciado la sesión desde el directorio raíz del repositorio.
- Comprueba que el archivo `AGENTS.md` (o `GEMINI.md`) existe en la raíz: `ls AGENTS.md`.

### El bloqueo de rama impide editar
- Es el comportamiento esperado: estás en `main`. Crea una rama con `git checkout -b tu-rama` para trabajar.

### No se aplica el formateo automático
- `auto-format.sh` utiliza las herramientas que ya tengas instaladas en tu proyecto (`prettier`, `biome`, `ruff`, `black`, `gofmt`, etc.). Instala tu formateador preferido si aún no está presente en el entorno.

---

## Referencia rápida

```text
AGENTS.md / GEMINI.md     Contexto del proyecto leído al inicio de sesión
GUIDE.md                  Esta guía de configuración paso a paso
EXAMPLE.md                Recorrido práctico completo desde idea hasta PR
.agents/
  settings.json           Configuración de entorno y permisos
  hooks.json              Definición de lifecycle hooks
  agents/                 9 subagentes especializados
  skills/                 11 comandos slash + 6 skills procedimentales
  hooks/                  Scripts de protección, formateo y evaluación
  prompts/                Plantillas para el SDK de Python de Antigravity
.mcp.json                 Configuración de servidores MCP
.github/workflows/        4 workflows para GitHub Actions (incluyendo test-template.yml)
docs/
  decisions/              Registros arquitectónicos (ADRs)
  product/                Contexto y validación de negocio
  templates/              Plantillas de documentos
```

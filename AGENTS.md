# {{NOMBRE_DEL_PROYECTO}}

> Este archivo contiene el contexto y las directrices fundamentales que **Google Antigravity**
> lee al inicio de cada sesión (a través de `AGENTS.md` y `GEMINI.md`).
> Rellena los `{{PLACEHOLDERS}}` y elimina lo que no aplique a tu proyecto.
> Menos es más: un documento breve, veraz y verificado funciona infinitamente mejor que uno extenso y desactualizado.
> Guía completa de configuración: [GUIDE.md](./GUIDE.md)

## Qué es esto

{{Una o dos frases concisas: qué problema resuelve el proyecto y para quién. Si se trata de una iniciativa o idea de negocio sin código todavía, define con claridad la hipótesis que estás validando.}}

- **Tipo de proyecto**: {{software | idea de negocio | ambos}}
- **Etapa**: {{exploración | prototipo | validación | producción}}
- **Responsable**: {{TU_NOMBRE}}

---

## Stack y comandos habituales

<!-- Elimina o comenta esta sección si el proyecto todavía no contiene código. -->

- **Lenguaje / framework**: {{p. ej. TypeScript + React / Next.js / Python + FastAPI / Go}}
- **Gestor de paquetes**: {{npm | pnpm | yarn | uv | poetry | cargo | go}}
- **Base de datos / ORM**: {{p. ej. PostgreSQL + Prisma / SQLite / Supabase}}
- **Despliegue e infraestructura**: {{p. ej. Cloud Run / Vercel / Kubernetes}}

```bash
{{npm run dev}}        # arrancar el entorno en local
{{npm test}}           # ejecutar la suite de pruebas
{{npm run lint}}       # análisis estático y linter
{{npm run typecheck}}  # comprobación estricta de tipos
{{npm run build}}      # compilación / build para producción
```

> Estos comandos los utilizan directamente los hooks y el subagente `verification-specialist`.
> Si se modifican aquí, asegúrate de mantenerlos alineados en `.agents/hooks/`.

## Mapa del repositorio

| Ruta | Contenido |
|---|---|
| `{{src/}}` | {{Código fuente de la aplicación}} |
| `{{tests/}}` | {{Batería de pruebas unitarias y de integración}} |
| `docs/decisions/` | ADRs: registros inmutables de decisiones arquitectónicas y su porqué |
| `docs/product/` | Contexto de negocio, análisis de mercado y validación de hipótesis |
| `.agents/` | Configuración de Antigravity (subagentes, slash commands, skills y hooks) |

---

## Cómo trabajar en este proyecto

### Antes de escribir o modificar código

1. Inspecciona el contexto relevante antes de proponer modificaciones; nunca asumas convenciones que no hayas observado en el repositorio.
2. Para cualquier funcionalidad o corrección que involucre más de dos o tres archivos, diseña primero el enfoque mediante `/plan` y confirma la estrategia antes de editar.
3. Aplica siempre el cambio mínimo indispensable que resuelva la tarea. Evita refactorizaciones oportunistas fuera del alcance solicitado.

### Estilo de código

- {{Convención 1: p. ej. TypeScript en modo estricto, sin uso de tipo `any`}}
- {{Convención 2: p. ej. retornos tempranos (early returns), máximo 2 niveles de anidamiento}}
- {{Convención 3: p. ej. nombrado de booleanos con prefijo `is` / `has`}}
- Respeta rigurosamente el estilo del código circundante: arquitectura, convenciones de nombrado, tratamiento de excepciones y densidad de comentarios.

### Reglas que no se rompen

- **Nunca silenciar errores.** Todo error debe ser registrado adecuadamente y el usuario o llamador debe recibir feedback significativo. Prohibidos los bloques `catch` vacíos.
- **Nunca commitear secretos ni credenciales.** Claves, tokens de API y certificados residen en `.env` (ignorado por Git).
- **Nunca editar directamente en la rama principal (`{{main}}`).** Siempre una rama por cambio.
- {{Regla específica propia de tu sistema}}

### Batería de pruebas

- {{Estrategia: p. ej. desarrollo guiado por tests (TDD) donde aplique}}
- {{Enfoque: comprobar comportamiento observable, no detalles de implementación interna}}
- Los tests existentes deben seguir pasando sin modificarse, salvo que el cambio de especificación sea intencional y esté declarado.

### Flujo de Git

- **Ramas**: `{{iniciales}}/{{descripcion-corta}}` — p. ej. `ra/fix-login-redirect`
- **Commits**: [Conventional Commits](https://www.conventionalcommits.org/es/) (`feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `chore:`)
- **Pull Requests**: un PR = una única responsabilidad.

---

## Contexto de negocio

<!-- Elimina esta sección si el repositorio es puramente técnico o utilitario. -->

- **Problema real**: {{dolor concreto que experimenta el usuario objetivo}}
- **Cliente / Usuario**: {{quién toma la decisión de compra vs quién usa la herramienta diariamente}}
- **Propuesta de valor diferencial**: {{por qué este producto y no las alternativas actuales}}
- **Modelo de ingresos**: {{cómo se monetiza el valor generado}}
- **Métrica Norte**: {{el indicador cuantitativo prioritario que determina el éxito}}
- **Hipótesis más arriesgada hoy**: {{el supuesto que, de ser falso, invalidaría el proyecto}}

Documentación detallada en `docs/product/`.

---

## Ecosistema de Antigravity: Subagentes, Comandos y Skills

Antigravity selecciona de forma autónoma cuándo delegar o activar cada capacidad, pero es esencial conocer el catálogo disponible:

### 1. Subagentes dedicados (`.agents/agents/`)

Delegación especializada en contextos aislados:

| Subagente | Función principal |
|---|---|
| `code-explorer` | Navegación e indexación de código en repositorios grandes (estrictamente solo lectura) |
| `solution-architect` | Diseño de arquitectura y elaboración de planes antes de tocar código |
| `code-reviewer` | Revisión sistemática de código modificado previa a pull requests |
| `verification-specialist` | Comprobación empírica y adversaria ejecutando builds, tests y sondas |
| `documentation-guide` | Creación y actualización de documentación técnica |
| `git-workflow` | Gestión de ramas, commits limpios y redacción de PRs |
| `business-analyst` | Traducción de objetivos de negocio a requerimientos y criterios de aceptación |
| `market-researcher` | Investigación contrastada de competidores, alternativas y mercado |
| `product-strategist` | Priorización de roadmap, delimitación de MVP y balance de trade-offs |

### 2. Slash Commands (`.agents/skills/`)

Comandos ejecutables desde la barra de chat de Antigravity escribiendo `/<nombre>`:

`/setup` · `/onboard` · `/plan` · `/verify` · `/code-quality` · `/pr-review` ·
`/pr-summary` · `/docs-sync` · `/ticket` · `/idea` · `/adr`

### 3. Skills procedimentales (`.agents/skills/`)

Conocimiento y metodología activada bajo demanda:
`coding-standards` · `systematic-debugging` · `testing-patterns` ·
`verification-agent` · `prompt-architect` · `lean-validation`

---

## Notas y trampas conocidas del proyecto

<!-- Este apartado acumula el mayor valor con el tiempo.
     Cada vez que el agente tropiece con una peculiaridad del entorno dos veces,
     documenta la regla aquí para evitar recurrencias. -->

- {{p. ej. "La migración inicial de la base de datos requiere 2 minutos; no interrumpir el proceso."}}
- {{p. ej. "El archivo `legacy_auth.go` no debe modificarse; las nuevas funcionalidades extienden el nuevo módulo `auth_v2`."}}

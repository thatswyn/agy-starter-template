# {{NOMBRE_DEL_PROYECTO}}

> Directrices fundamentales leídas por **Google Antigravity** al inicio de cada sesión (vía `AGENTS.md` / `GEMINI.md`).
> Rellena los `{{PLACEHOLDERS}}` o usa `/setup` para aplicar presets automáticos. Guía completa: [GUIDE.md](./GUIDE.md).

## Qué es esto

{{Una o dos frases concisas: qué problema resuelve el proyecto y para quién. Si es una idea de negocio sin código, define la hipótesis que estás validando.}}

- **Tipo**: {{software | idea de negocio | ambos}}
- **Etapa**: {{exploración | prototipo | validación | producción}}
- **Responsable**: {{TU_NOMBRE}}

---

## Stack y comandos habituales

<!-- Comenta o elimina si el proyecto aún no contiene código. -->

- **Lenguaje / framework**: {{TypeScript + Next.js / Python + FastAPI / Go / Rust}}
- **Gestor de paquetes**: {{npm | pnpm | uv | poetry | cargo | go}}
- **Base de datos / ORM**: {{PostgreSQL + Prisma / SQLite / Supabase}}

```bash
{{npm run dev}}        # arrancar el entorno en local
{{npm test}}           # ejecutar la suite de pruebas
{{npm run lint}}       # análisis estático y linter
{{npm run typecheck}}  # comprobación estricta de tipos
{{npm run build}}      # compilación / build para producción
```

> Comandos usados directamente por los hooks y el subagente `verification-specialist`.

## Mapa del repositorio

| Ruta | Contenido |
|---|---|
| `{{src/}}` | {{Código fuente de la aplicación}} |
| `tests/` | Batería de pruebas unitarias y de integración |
| `docs/decisions/` | ADRs: registros inmutables de decisiones arquitectónicas |
| `docs/product/` | Contexto de negocio y validación lean de hipótesis (`/idea`) |
| `.agents/` | Configuración de Antigravity (subagentes, skills, rules y hooks) |

---

## Cómo trabajar en este proyecto

1. **Inspecciona antes de editar:** Verifica contexto antes de proponer cambios; nunca asumas librerías ni arquitecturas ausentes.
2. **Planifica cambios complejos:** Para tareas de más de dos archivos, diseña el enfoque con `/plan` antes de escribir código.
3. **Cambio mínimo indispensable:** Resuelve la tarea con precisión; evita refactorizaciones oportunistas fuera del alcance.

### Reglas no negociables

- **Nunca silenciar errores:** Todo error debe registrarse adecuadamente. Prohibidos bloques `catch` vacíos.
- **Cero secretos en código:** Claves, tokens y credenciales residen estrictamente en `.env` (ignorado en git).
- **Nunca editar en rama principal (`main`):** Siempre una rama por cambio (`{{iniciales}}/{{descripcion}}`). El hook `protect-branch` lo bloquea de forma determinista.
- **Verificación empírica:** Comprueba con tests y build reales (`/verify`); no basta con asegurar que funciona.

### Convenciones de Git
- **Ramas**: `{{iniciales}}/{{descripcion-corta}}` (ej. `ra/fix-auth-redirect`)
- **Commits**: [Conventional Commits](https://www.conventionalcommits.org/es/) (`feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `chore:`)
- **Pull Requests**: Un PR = una única responsabilidad.

---

## Ecosistema de Antigravity (`.agents/`)

Antigravity descubre de forma nativa los recursos del proyecto:
- **Subagentes** en `.agents/agents/`: delegación especializada (`solution-architect`, `code-reviewer`, `verification-specialist`, etc.).
- **Slash Commands y Skills** en `.agents/skills/`: flujos (`/setup`, `/plan`, `/verify`, `/idea`, `/adr`, `/pr-review`).
- **Reglas modulares por ámbito** en `.agents/rules/`: directrices aplicadas según las rutas tocadas (`frontend`, `backend`, `testing`, `security`).
- **Hooks deterministas** en `.agents/hooks/`: protección de ramas y formateo automático no bloqueante.

---

## Notas y trampas conocidas del proyecto

- {{p. ej. "La migración inicial requiere 2 minutos; no interrumpir el proceso."}}

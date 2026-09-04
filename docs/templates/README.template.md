<!-- Plantilla de README para tu proyecto final.
     Copia este archivo a la RAÍZ del repositorio (sustituyendo el README.md
     de la plantilla inicial) y completa los {{PLACEHOLDERS}}. -->

# {{Nombre del proyecto}}

{{Una frase descriptiva: qué problema resuelve el proyecto y para quién.}}

## Requisitos previos

- {{p. ej. Node.js 20+}}
- {{p. ej. PostgreSQL 16+ o Docker}}
- Antigravity CLI (`agy`) o Antigravity IDE

## Puesta en marcha rápida

```bash
git clone {{url_del_repositorio}}
cd {{directorio_del_proyecto}}
cp .env.example .env      # configura las variables reales
{{npm install}}
{{npm run dev}}
```

La aplicación quedará disponible en `{{http://localhost:3000}}`.

## Comandos habituales

| Comando | Acción |
|---|---|
| `{{npm run dev}}` | Servidor de desarrollo local |
| `{{npm test}}` | Ejecución de pruebas automatizadas |
| `{{npm run lint}}` | Análisis estático de código (linter) |
| `{{npm run build}}` | Compilación para producción |

## Estructura del repositorio

```text
{{src/          código fuente de la aplicación
tests/        batería de pruebas
docs/         decisiones arquitectónicas y contexto de negocio
.agents/      configuraciones, skills y subagentes de Antigravity}}
```

## Desarrollo con Antigravity

Este repositorio está optimizado para trabajar con **Google Antigravity**.
- `AGENTS.md` (y `GEMINI.md`) albergan el contexto general del proyecto.
- `.agents/skills/` contiene las skills y comandos disponibles (`/plan`, `/verify`, `/setup`, etc.).
- `.agents/agents/` contiene los subagentes especializados a los que Antigravity delega tareas.
- Consulta [GUIDE.md](./GUIDE.md) para más detalles.

## Flujo de contribución

- Ramas: `{{iniciales}}/{{descripcion-corta}}` (p. ej. `ra/fix-auth-token`)
- Commits: [Conventional Commits](https://www.conventionalcommits.org/es/)
- Antes de abrir Pull Request: comprobar que los tests y el linter pasen localmente (`/verify`).

## Licencia

{{MIT}} — ver [LICENSE](./LICENSE).

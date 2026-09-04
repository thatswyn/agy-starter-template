# Catálogo de Skills en Antigravity

En Antigravity, una **skill** es un paquete modular de conocimiento, procedimientos o comandos que el agente carga bajo demanda mediante **revelación progresiva (progressive disclosure)** o que el usuario invoca directamente como **slash command (`/<name>`)**.

A diferencia de `AGENTS.md`, que se lee al inicio de cada sesión, las skills no consumen contexto hasta que son activadas.

---

## Catálogo de Skills

### 1. Comandos y Workflows (invocables con `/<nombre>`)

| Comando / Skill | Qué cubre | Cuándo se activa o invoca |
|---|---|---|
| [`setup`](./setup/SKILL.md) | Configuración inicial del repositorio a partir de este template | Al arrancar un nuevo proyecto con `/setup` |
| [`onboard`](./onboard/SKILL.md) | Inmersión y análisis profundo antes de tocar código | Al empezar una tarea nueva con `/onboard` |
| [`plan`](./plan/SKILL.md) | Diseño del plan de implementación y arquitectura previa | Antes de escribir código con `/plan` |
| [`verify`](./verify/SKILL.md) | Verificación mediante ejecución real de tests, build y sondas | Al terminar un cambio con `/verify` |
| [`code-quality`](./code-quality/SKILL.md) | Revisión de calidad y checklist técnico | Antes de abrir un PR con `/code-quality` |
| [`pr-review`](./pr-review/SKILL.md) | Revisión de pull requests con `gh` | Al revisar un PR externo con `/pr-review` |
| [`pr-summary`](./pr-summary/SKILL.md) | Generación del resumen estructurado para un PR | Al preparar la entrega con `/pr-summary` |
| [`docs-sync`](./docs-sync/SKILL.md) | Detección de documentación desincronizada | Periódicamente con `/docs-sync` |
| [`ticket`](./ticket/SKILL.md) | Flujo de desarrollo completo para un ticket | Al trabajar una issue con `/ticket` |
| [`idea`](./idea/SKILL.md) | Examen honesto y validación de una idea de negocio | Al evaluar una iniciativa con `/idea` |
| [`adr`](./adr/SKILL.md) | Registro de decisiones arquitectónicas inmutables | Al tomar una decisión técnica con `/adr` |

### 2. Metodologías y Buenas Prácticas

| Skill | Qué cubre | Cuándo se activa |
|---|---|---|
| [`coding-standards`](./coding-standards/SKILL.md) | Disciplina de cambios pequeños, reversibles y manejo de errores | Al editar o implementar código |
| [`systematic-debugging`](./systematic-debugging/SKILL.md) | Método de 4 fases para resolver bugs hasta la causa raíz | Cuando algo falla, da error o se comporta de forma inesperada |
| [`testing-patterns`](./testing-patterns/SKILL.md) | Estrategia de tests, TDD, factorías de datos y determinismo | Al escribir, corregir o revisar tests |
| [`verification-agent`](./verification-agent/SKILL.md) | Metodología de verificación con evidencia de terminal | Al validar que una solución funciona empíricamente |
| [`prompt-architect`](./prompt-architect/SKILL.md) | Diseño de subagentes, skills, hooks y reglas para Antigravity | Al crear o modificar archivos en `.agents/` |
| [`lean-validation`](./lean-validation/SKILL.md) | Hipótesis críticas, experimentos de bajo coste y métricas | Al evaluar viabilidad de negocio o priorizar producto |

---

## Cómo invocar o utilizar una Skill

1. **Como Slash Command:** escribe `/<nombre>` en la caja de chat de Antigravity (por ejemplo: `/plan`, `/verify`, `/setup`).
2. **Activación autónoma:** cuando una tarea encaja con la `description` en el frontmatter de una skill, Antigravity la descubre e incorpora progresivamente a la sesión.

---

## Cómo añadir una nueva Skill

1. Crea la carpeta `.agents/skills/<nombre-kebab-case>/`.
2. Crea el archivo `.agents/skills/<nombre-kebab-case>/SKILL.md` con frontmatter YAML:

```markdown
---
name: tu-skill
description: >-
  Explica con detalle qué hace y CUÁNDO debe usarse, incluyendo sinónimos y
  términos habituales de búsqueda.
---

# Tu Skill
[Instrucciones paso a paso]
```

3. Si incluye documentación extensa o scripts auxiliares, colócalos en subdirectorios relativos:
   - `references/` (manuales y guías detalladas)
   - `scripts/` (scripts ejecutables)
   - `templates/` o `examples/`
4. Añade su regla a `.agents/hooks/skill-rules.json` si deseas que el hook de evaluación la recomiende proactivamente.

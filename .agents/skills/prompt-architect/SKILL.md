---
name: prompt-architect
description: Diseño de prompts, subagentes, slash commands y skills fiables en Antigravity. Úsala al crear o mejorar archivos dentro de .agents/, al redactar las instrucciones de un agente o cuando un prompt dé resultados inconsistentes. Cubre estructuración, selección de artefactos y mejores prácticas.
---

# Diseño de prompts y customizaciones en Antigravity

## Elegir el tipo de personalización adecuado

Antes de escribir una sola línea de instrucciones, decide **dónde** debe residir la directiva. Es la decisión con mayor impacto en el rendimiento y consumo de contexto.

| Tipo de personalización | Dónde vive | Cuándo se carga | Para qué sirve |
|---|---|---|---|
| **Contexto principal / Reglas** | `AGENTS.md` / `GEMINI.md` | En cada sesión, al arrancar | Lo que el agente debe saber **siempre**: stack, comandos básicos, convenciones y reglas duras |
| **Skill (y Slash Command)** | `.agents/skills/<name>/SKILL.md` | Bajo demanda o con `/<name>` | Conocimiento procedimental especializado o flujos que solo aplican a veces |
| **Subagente dedicado** | `.agents/agents/<name>.md` | Al delegar con `invoke_subagent` | Tareas que requieren un rol especializado, herramientas acotadas y contexto aislado |
| **Reglas jerárquicas** | `.agents/rules/*.md` | Al entrar en directorios concretos | Restricciones aplicables a áreas específicas del repositorio |
| **Lifecycle Hook** | `.agents/hooks.json` | Ante eventos del ciclo de vida | Reglas **deterministas** que no pueden depender del criterio probabilístico del modelo |

### Errores comunes de diseño

- **Concentrarlo todo en `AGENTS.md`:** satura la ventana de contexto. Si una norma solo aplica al 10% de las tareas, debe ser una skill.
- **Escribir una skill para lo que requiere un hook:** pedirle a un prompt "formatea siempre después de editar" es una sugerencia; un hook en `PostToolUse` es una garantía obligatoria.
- **Crear un subagente para una tarea de dos pasos:** la delegación tiene un coste de tiempo y contexto. Si el trabajo cabe en el turno actual, ejecútalo directamente.

## Factores de fiabilidad en un prompt

- **Concreción operativa:** "Devuelve las rutas con formato archivo:línea" es comprobable; "sé exhaustivo" es ambiguo.
- **Formulación positiva:** indica qué hacer antes de qué no hacer. Cuando indiques una prohibición, ofrece la alternativa permitida.
- **Ejemplos de entrada y salida:** un ejemplo del resultado deseado (y opcionalmente de lo que se debe evitar) clarifica las ambigüedades mejor que varios párrafos.
- **Tratamiento de la ambigüedad:** especifica qué debe hacer el agente ante datos incompletos (preguntar con `ask_question`, asumir con advertencia o detenerse).

## El campo `description` en Skills y Subagentes

En Antigravity, el frontmatter `description` es el factor determinante para la **revelación progresiva (progressive disclosure)**:

```markdown
---
name: nombre-skill
description: >-
  Describe con precisión qué hace y CUÁNDO debe activarse, incluyendo sinónimos
  y los términos habituales que utilizaría el usuario.
---
```

Si la descripción es vaga ("Herramientas de testing"), el modelo no sabrá cuándo activarla. Si explicita el detonante ("Estrategia de tests... úsala al escribir o revisar pruebas..."), el agente la invocará en el momento oportuno.

## Detalle y plantillas

Para ver plantillas detalladas de cada tipo de archivo, antipatrones y lista de verificación, consulta [reference.md](./reference.md).

# Referencia de diseño de customizaciones en Antigravity

Guía de apoyo para la skill `prompt-architect`.

## Plantilla — Subagente (`.agents/agents/<name>.md`)

```markdown
---
name: nombre-en-kebab-case
description: Qué hace y CUÁNDO debe seleccionarse. Este campo decide la activación.
subagent: true
---

Eres [rol] en Antigravity. [Una o dos frases sobre el objetivo primordial.]

## Modo de operación
[Principios operativos y herramientas autorizadas (p. ej., solo lectura).]

## Cómo trabajar
[Procedimiento paso a paso.]

## Formato de entrega
[Estructura exacta del resultado a devolver.]

## Límites
[Lo que tiene estrictamente prohibido hacer.]
```

## Plantilla — Skill y Slash Command (`.agents/skills/<name>/SKILL.md`)

```markdown
---
name: nombre-en-kebab-case
description: Qué cubre y cuándo aplica. Incluye vocabulario habitual del usuario.
---

# Título de la Skill

## Cuándo aplica
[Condiciones de activación explicadas en lenguaje natural.]

## Metodología o procedimiento
[Pasos, reglas y buenas prácticas.]

## Antipatrones
| Antipatrón | Por qué resulta perjudicial |

## Recursos adicionales
[Enlaces a ./scripts/, ./examples/, ./references/ si procede.]
```

## Plantilla — Reglas del Espacio de Trabajo (`AGENTS.md`)

```markdown
# {{NOMBRE_DEL_PROYECTO}}

> Contexto principal que Antigravity lee al inicio de cada sesión.

## Qué es esto
{{Descripción breve}}

## Stack y comandos
{{Comandos verificados de build, test, dev}}

## Reglas que no se rompen
- Regla 1
- Regla 2
```

## Checklist de validación de un prompt

- [ ] ¿El campo `description` explica **cuándo** y en qué situaciones usarlo?
- [ ] ¿Emplea los términos naturales en los que el usuario o el agente se comunican?
- [ ] ¿Cada directiva es accionable y comprobable en el comportamiento observable?
- [ ] ¿Se especifica el formato de salida esperado mediante ejemplos?
- [ ] ¿Se definen los límites de seguridad (permisos, no publicación sin aprobación)?
- [ ] ¿Está en la ubicación adecuada (`AGENTS.md`, skill, subagente, regla o hook)?

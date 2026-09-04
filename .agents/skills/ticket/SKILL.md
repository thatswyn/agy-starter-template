---
name: ticket
description: Trabajar un ticket o issue de principio a fin en Antigravity. Conecta con MCP (Linear/Jira/GitHub), realiza onboarding, planifica, implementa, verifica y prepara la entrega.
---

# Flujo completo de ticket

Ticket objetivo: ID del ticket o issue (p. ej. PROJ-123 o #45).

> Requiere un servidor MCP activo de Linear, Jira o GitHub en `.agents/mcp_config.json` o `.mcp.json`. Si no está configurado, solicita al usuario la descripción del ticket y continúa desde el paso 2.

## 1. Leer el ticket

Mediante las herramientas MCP disponibles, extrae título, descripción, criterios de aceptación, comentarios y tickets vinculados.

Resume en pantalla:
- Objetivo principal.
- Criterios de aceptación detallados.
- Dependencias o bloqueos existentes.

**Si los criterios son ambiguos, detén la ejecución y pregunta al usuario con `ask_question`.** Construir sobre un ticket impreciso es la vía más costosa de desarrollo.

## 2. Familiarizarse con la zona afectada

Ejecuta el flujo de `/onboard` para esta tarea. Si se desconoce la ubicación del código relevante, apóyate en el subagente `code-explorer`.

## 3. Crear rama de trabajo

```bash
git checkout -b {{iniciales}}/{{ID_TICKET}}-{{descripcion-corta}}
```

## 4. Planificar

Si el cambio afecta a más de dos o tres archivos, formula el plan mediante `/plan` y valida el enfoque con el usuario antes de programar.

## 5. Implementar

- Aplica las normas y convenciones definidas en `AGENTS.md`.
- Sigue la disciplina de test primero (TDD) cuando sea aplicable.
- Realiza commits incrementales con Conventional Commits referenciando el ticket (`feat(PROJ-123): ...`).

## 6. Verificar

Ejecuta `/verify`. No des por finalizada la tarea mientras exista un resultado de FAIL.

## 7. Preparar entrega

- Ejecuta `/pr-summary` para estructurar la descripción del pull request.
- **Solicita siempre confirmación antes de hacer push, abrir el PR o modificar el estado del ticket en el gestor de tareas.** Publicar hacia el exterior requiere decisión humana.

## Hallazgos de bugs ajenos no relacionados

Si detectas un fallo ajeno durante la implementación, no lo corrijas dentro de este ticket. Anótalo, sugiere crear una issue separada y continúa con el alcance previsto.

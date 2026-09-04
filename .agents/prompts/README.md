# Prompts de referencia para el SDK de Antigravity y APIs

Estos archivos **no** son cargados automáticamente por Antigravity en las sesiones interactivas habituales. Son plantillas y contratos de referencia para cuando construyes tus propios agentes programáticos fuera del CLI o del IDE: con el **SDK de Python de Antigravity** (`google-antigravity`), con la API de Gemini directamente, o en pipelines de automatización.

| Archivo | Para qué sirve |
|---|---|
| [`system-prompt.md`](./system-prompt.md) | Contrato de comportamiento para un agente de desarrollo autónomo con Antigravity |
| [`coordinator.md`](./coordinator.md) | Patrón de orquestación para un agente coordinador que despacha trabajadores en paralelo |

## Cómo usarlos con el SDK de Antigravity

```python
from google.antigravity import Agent, LocalAgentConfig, CapabilitiesConfig

# Cargar el prompt de referencia
with open(".agents/prompts/system-prompt.md", "r") as f:
    system_instructions = f.read()

config = LocalAgentConfig(
    system_instructions=system_instructions,
    capabilities=CapabilitiesConfig(),
)

async with Agent(config) as agent:
    response = await agent.chat("Explora el proyecto y ejecuta los tests.")
    # Procesar respuesta...
```

Los roles y subagentes que Antigravity utiliza de forma nativa en tu espacio de trabajo residen en [`../agents/`](../agents/) y sus skills en [`../skills/`](../skills/).

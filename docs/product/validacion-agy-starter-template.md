# Examen Crítico de Idea de Negocio y Producto: `agy-starter-template`

**Fecha:** 10 de septiembre de 2026  
**Iniciativa:** Antigravity Starter Template (`agy-starter-template`)  
**Metodología:** `/idea` (Lean Validation & Market Research)  
**Investigación de soporte:** [`analisis-mercado-scaffolds-agenticos.md`](./analisis-mercado-scaffolds-agenticos.md)  
**Estado:** Evaluación completada  

---

## 1. Concreción de la Propuesta de Valor

- **Problema real:** Los desarrolladores que utilizan asistentes agénticos como Google Antigravity sufren de "deriva del agente" (*agent drift*), sobrecoste de tokens por instrucciones mal estructuradas (*Context Tax*), configuraciones manuales repetitivas en cada nuevo proyecto y falta de verificación empírica (el agente dice que algo funciona sin haber corrido pruebas).
- **Usuario objetivo:** Desarrolladores de software, *indie hackers* y equipos técnicos que buscan estandarizar el arnés de desarrollo con Google Antigravity en sus repositorios.
- **Cómo lo resuelven hoy:**
  1. Un archivo `AGENTS.md` o `CLAUDE.md` improvisado de 30–50 líneas escrito a mano.
  2. Copiar y pegar reglas desde repositorios estáticos como `awesome-cursorrules` o `cursor.directory`.
  3. Instrucciones verbales repetidas en cada sesión de chat.
- **Coste actual del problema:** Horas de depuración por alucinaciones de sintaxis, regresiones introducidas por el agente y pérdida recurrente de tiempo configurando linters, permisos y roles en cada nuevo repositorio.
- **Ventaja diferencial propuesta:** Arquitectura agéntica completa y modular específica para Antigravity: arnés con 9 subagentes, 11 slash commands, revelación progresiva de skills, hooks deterministas no bloqueantes y un camino dual (código de software + validación lean de negocio).

---

## 2. Jerarquía de Hipótesis de Riesgo

Ordenadas de mayor a menor gravedad por el daño letal que causarían si fuesen falsas:

| Nivel | Hipótesis | Daño si es falsa | Evidencia actual |
|---|---|---|---|
| **1 (Crítico)** | **Sobrecarga de Contexto (*Context Tax*):** Un scaffold con 9 subagentes y 11 comandos en el repositorio no degrada la atención del modelo ni encarece desproporcionadamente la factura de API. | **LETAL.** Si el arnés consume demasiado contexto o confunde a Antigravity, el desarrollador borrará `.agents/` y volverá a un archivo simple. | La comunidad reporta activamente "instruction fatigue" y deriva cuando se inyectan reglas masivas. Se exige modularidad extrema (`globs` y carga bajo demanda). |
| **2 (Crítico)** | **Disposición a Pagar / Modelo de Captura:** Los desarrolladores están dispuestos a pagar por una plantilla o scaffold agéntico. | **LETAL (para negocio directo).** Si nadie paga, cualquier intento de vender el template como producto de pago fracasa. | **Refutada.** La cultura de software rechaza pagar por prompts o plantillas markdown. La monetización solo funciona como Lead Magnet (CAC ~$0), en boilerplates funcionales de $199–$349 o consultoría B2B. |
| **3 (Alto)** | **Fricción en Onboarding:** Los desarrolladores están dispuestos a clonar un repo, podar 10 archivos a mano y responder preguntas en `/setup` antes de empezar a programar. | **ALTO.** Si el proceso toma más de 5 minutos, el abandono en el paso de instalación supera el 70%. | Los templates populares triunfan cuando ofrecen inicializadores CLI de un comando (ej. `create-t3-app`, `npx create-*`). |
| **4 (Medio)** | **Riesgo de Plataforma (*Platform Risk*):** Google Antigravity no volverá superfluo este template en sus próximas versiones. | **MEDIO/ALTO.** Si Antigravity incorpora descubrimiento nativo perfecto de herramientas y subagentes sin configuración, el template pierde relevancia si solo aporta prompts. | Antigravity evoluciona rápido. La diferenciación debe radicar en **verificación determinista (tests/hooks)** y **metodologías de producto**, no en wrappers de prompts. |

---

## 3. Evidencia Empírica de Mercado

*(Extraída del informe de investigación de mercado de fecha 10-09-2026 en `docs/product/analisis-mercado-scaffolds-agenticos.md`)*

- **Población y Adopción:**
  - 28,7M desarrolladores profesionales en el mundo (Evans Data 2025).
  - 63,2% utiliza herramientas de IA para programar (Stack Overflow 2024).
  - Segmento estimado de codificación agéntica activa: ~3,6M de desarrolladores (20% de los usuarios de IA).
  - Nicho alcanzable para scaffolds avanzados (SOM): ~181.000 desarrolladores.
- **Caso de Estudio de Referencia (`cursor.directory`):**
  - Creado por Pontus Abrahamsson en 3 horas. Tracción masiva con más de 200.000 usuarios mensuales y ~4k estrellas en GitHub.
  - Modelo: 100% gratuito y Open Source. No monetiza directamente; sirve de imán de tráfico a coste cero para la plataforma financiera Midday.ai.
- **Tendencias Clave:**
  - Transición definitiva de archivos únicos monolíticos a reglas modulares con ámbito delimitado por rutas (*scoped frontmatter* / `.mdc` / skills bajo demanda).
  - Consolidación del estándar `AGENTS.md` bajo la Agentic AI Foundation / Linux Foundation.
  - La "brecha de confianza": solo el 43% de los desarrolladores confía en la precisión de la IA (Stack Overflow 2024), lo que posiciona favorablemente a templates que imponen verificación ejecutada (`/verify`).

---

## 4. El Examen Honesto

- **¿Qué condiciones tendrían que cumplirse simultáneamente para que triunfe?**
  1. Que el tiempo de instalación sea inferior a 3 minutos.
  2. Que el arnés reduzca a cero las alucinaciones de comandos y los commits accidentales en `main`.
  3. Que el consumo de tokens sea despreciable en tareas habituales.
  4. Que la comunidad de Google Antigravity crezca y busque activamente estandarización.
- **¿Por qué nadie ha creado un estándar dominante aún?**  
  Porque el espacio agéntico es muy reciente (2025–2026), los arneses de CLI están convergiendo ahora hacia `AGENTS.md` y cada equipo acostumbra a redactar sus propias reglas en silos aislados.
- **¿Qué ocurre si un competidor o Google lo replica en semanas?**  
  Si Google Antigravity integra un comando `agy init` oficial con subagentes nativos, cualquier plantilla que sea solo un "repositorio clonable" queda desfasada. El valor defensivo debe ser el **ecosistema de skills de negocio, los presets por tecnología y los hooks de calidad verificada**.
- **¿Quién es el "no" más caro?**  
  El desarrollador senior o *lead architect* que abre el repositorio, ve carpetas con múltiples subagentes y documentación extensa, y concluye: *"Esto es sobre-ingeniería de prompts que va a comerse mi ventana de contexto y a ralentizar a mi agente; prefiero un AGENTS.md limpio de 30 líneas"*.
- **¿Cuál es la alternativa actual y por qué no es suficiente?**  
  Un archivo `AGENTS.md` minimalista de 30 líneas. Es suficiente para proyectos pequeños de una sola persona, pero se queda corto cuando se requiere:
  - Evitar ediciones en `main` de forma forzosa (requiere hooks bash deterministas).
  - Validar ideas de negocio o requisitos antes de tocar código.
  - Garantizar que el agente corra la suite de pruebas antes de declarar terminada una tarea.

---

## 5. Vías Concretas de Mejora para `agy-starter-template`

A partir de las debilidades y hallazgos identificados, se desglosan las mejoras de mayor impacto divididas en cuatro ejes:

### Eje A — Reducción Radical del "Context Tax" y Modularidad
1. **Reglas acotadas por ámbito (Scoped Rules):**  
   Migrar reglas de codificación específicas a módulos que solo se activen según la ruta de los archivos modificados (ej. reglas de base de datos solo al tocar `prisma/` o `migrations/`), en lugar de cargar directrices globales.
2. **Compactar `AGENTS.md` base:**  
   Reducir `AGENTS.md` a menos de 80 líneas esenciales (stack, comandos de verificación y 4 reglas no negociables). Trasladar el catálogo de subagentes y explicaciones largas a skills bajo demanda para que no compitan por atención en cada mensaje.

### Eje B — Experiencia de Inicialización (DX y Onboarding)
3. **Scaffolding interactivo vía CLI (evitar el clone manual):**  
   Crear un instalador `npx create-agy-app` o script interactivo que pregunte stack y tipo de proyecto *antes* de clonar, entregando un repositorio ya podado y configurado sin placeholders.
4. **Presets tecnológicos curados:**  
   Incorporar plantillas listas para usar en `/setup`:
   - `Preset TypeScript / Next.js / Tailwind / Biome / Vitest`
   - `Preset Python / FastAPI / Pydantic / Ruff / Pytest`
   - `Preset Go / Gin / SQLX / Golangci-lint`
   Esto elimina la necesidad de rellenar manualmente los comandos en `AGENTS.md`.

### Eje C — Higiene Técnica y Testing del Propio Scaffold
5. **Suite de pruebas de integración para los hooks:**  
   Crear `test/test-hooks.sh` para verificar automáticamente en CI que `protect-branch.sh`, `auto-format.sh` y `skill-eval.cjs` no fallan en entornos sin git, sin node o con payloads inesperados.
6. **Limpieza de dependencias residuales:**  
   Eliminar referencias huérfanas de Claude Code en `protect-branch.sh` (`CLAUDE_PROTECTED_BRANCHES`) y en `auto-format.sh` (`tool_input.file_path`), unificando en las especificaciones nativas de Antigravity.
7. **Robustecer workflows de CI:**  
   Reemplazar la URL ficticia de descarga en `.github/workflows/pr-agy-review.yml` (`curl -fsSL https://antigravity.google/install.sh`) por el método de invocación oficial o un script de fallback que verifique la presencia del CLI.

### Eje D — Diferenciación Estratégica
8. **Doble filo: Mantener el camino de negocio (`/idea` + `/plan`):**  
   Ningún otro template en el mercado (`cursor.directory`, `awesome-cursorrules`, `claude-code-starter`) ofrece integración de validación lean de negocio y análisis de mercado junto a la codificación. Esta es la propuesta de valor más original y defendible del proyecto.

---

## 6. El Experimento Más Barato

Para validar la hipótesis más peligrosa (**Fricción en onboarding vs. Utilidad real**):

- **Experimento:** Test de Usabilidad con 5 Desarrolladores Externos (*Think-Aloud Test*).
- **En qué consiste:** Observar a 5 programadores (2 juniors, 2 seniors, 1 fundador técnico) clonar el template y configurar un proyecto nuevo desde cero usando `/setup`. Medir el tiempo hasta el primer commit válido y registrar qué archivos borran o ignoran.
- **Tiempo requerido:** 3 a 5 días de calendario.
- **Coste:** $0 (utilizando contactos de la red profesional o comunidad técnica).
- **Umbrales de decisión definidos por escrito:**
  - **CONTINUAR (Seguir la visión actual):** Si al menos 4 de los 5 desarrolladores completan el setup en menos de 8 minutos, valoran positivamente los subagentes y ejecutan `/verify` o `/plan` en su flujo.
  - **GIRAR (Pivotar hacia arnés ultra-minimalista):** Si 3 o más desarrolladores consideran que los 9 subagentes y la documentación son excesivos y solicitan una versión reducida a un solo archivo con hooks básicos.
  - **PARAR (Detener inversión):** Si 4 de los 5 desarrolladores afirman que prefieren un prompt en blanco y que el template introduce más fricción y coste de tokens de lo que ahorra.

---

## 7. Veredicto y Recomendación

### Recomendación: **GIRAR (PIVOTAR / EVOLUCIONAR)**

1. **No intentar monetizar el template como producto de pago directo:** La venta de plantillas de prompts puras tiene un techo económico insignificante (~$260k USD en el escenario más optimista para todo el mercado) y fuerte fricción cultural. El template debe mantenerse **100% libre y Open Source** para maximizar estrellas, adopción y autoridad técnica.
2. **Evolucionar hacia un arnés de "Token Zero-Waste":** Adaptar la arquitectura para que `AGENTS.md` sea ultraligero y el agente solo despierte subagentes y skills mediante disparadores por ruta y evento, combatiendo el "Context Tax".
3. **Priorizar automatización de setup y presets:** Eliminar la fricción de podar carpetas a mano mediante presets automáticos por stack en `/setup`.
4. **Preservar el diferencial dual (Software + Lean Business):** Mantener la capacidad de `/idea` y roles de producto (`market-researcher`, `business-analyst`), ya que es el único rasgo que la competencia técnica ignora por completo.

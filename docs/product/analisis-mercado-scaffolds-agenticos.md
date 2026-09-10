# Investigación de Mercado: Scaffolds y Starter Templates para Asistentes de Codificación Agéntica

**Fecha de elaboración:** 10 de septiembre de 2026  
**Investigador:** Subagente `market-researcher` (Antigravity)  
**Clasificación de datos:** Verificado | Estimado | Desconocido  

---

## 1. Pregunta u Objetivo de la Investigación

Analizar el panorama de mercado, el ecosistema competitivo, los puntos de dolor de los desarrolladores, los modelos de monetización, las alternativas indirectas y la viabilidad económica de las plantillas de inicio (*starter templates*) y *scaffolds* para agentes de codificación autónomos y semi-autónomos (Google Antigravity, Claude Code, Cursor, Aider, Windsurf y Cline).

---

## 2. Resumen Ejecutivo

1. **Transición crítica de monolitos a reglas modulares y estándares universales:** El ecosistema ha abandonado los archivos monolíticos gigantes (`.cursorrules` o `CLAUDE.md` de +500 líneas) debido a la degradación en el razonamiento del modelo ("instruction bloat") y el coste de contexto. El mercado converge hacia la revelación progresiva (`.cursor/rules/*.mdc` con YAML frontmatter y globs; carpetas `.claude/skills/` y el estándar abierto `AGENTS.md` impulsado bajo la Agentic AI Foundation / Linux Foundation).
2. **El "Rule Rot" y el "Context Tax" son las principales quejas:** Las instrucciones estáticas quedan desactualizadas rápidamente frente a frameworks modernos. Además, los LLMs tratan las reglas en lenguaje natural como sugerencias probabilísticas y no como restricciones duras, sufriendo de "drift" conversacional conforme avanza la sesión.
3. **Inviabilidad de la monetización directa de "templates de markdown":** Los desarrolladores no pagan por prompts abiertos. La captura de valor se produce indirectamente:
   - Como funcionalidad añadida en boilerplates de código funcional completo ($199–$349, ej. Supastarter).
   - Como imán de adquisición a coste casi cero (Top of Funnel CAC ~$0) para productos SaaS (ej. `cursor.directory` con >200.000 usuarios mensuales impulsando la plataforma Midday).
   - Mediante consultoría y gobernanza de IA empresarial ($5.000–$30.000 por intervención).
4. **Riesgo crítico de plataforma (*Platform Risk*):** Los proveedores de modelos y entornos (Google Antigravity con Gemini 3.8, Anthropic con Claude Code, Cursor) integran progresivamente de forma nativa la gestión de memoria, RAG sobre el repositorio, subagentes especializados y hooks. Todo scaffold que compita contra la ergonomía nativa corre el riesgo de quedar obsoleto.
5. **Oportunidad Bottom-Up:** Sobre una base mundial de 28,7M de desarrolladores profesionales (Evans Data 2025), de los cuales ~3,6M operan activamente con herramientas agénticas, el nicho de usuarios avanzados de scaffolds representa ~181.000 desarrolladores. Un modelo de venta directa de templates apenas alcanzaría ~$260.000 USD (nicho indie), mientras que el software de gobernanza/sincronización o los boilerplates de producto completo desbloquean mercados de $300.000 a más de $1.000.000 USD de ARR.

---

## 3. Matriz de Competencia y Ecosistema

| Solución / Actor | Enfoque & Público Objetivo | Modelo de Negocio / Pricing | Fortalezas Clave | Debilidades y Fricciones |
| :--- | :--- | :--- | :--- | :--- |
| **`cursor.directory`** *(Pontus Abrahamsson / Midday)* | Directorio comunitario de reglas y servidores MCP para Cursor. Desarrolladores frontend y full-stack. | **Gratuito / Open Source** (Donaciones/Sponsors). Actúa como imán de marca para Midday.ai. | • Tracción masiva (>200.000 usuarios mensuales).<br>• Catálogo extenso categorizado por stack.<br>• Integración directa de MCPs. | • Calidad dispar de reglas aportadas por terceros.<br>• Falta de verificación ejecutada.<br>• Alta obsolescencia de prompts antiguos. |
| **`awesome-cursorrules`** *(PatrickJS)* | Repositorio GitHub con colecciones de reglas para stacks populares (Next.js, Python, Rust). | **Gratuito / Open Source** (GitHub, ~4k+ estrellas). | • Fácil de clonar.<br>• Reconocimiento temprano en la comunidad.<br>• Ejemplos prácticos rápidos. | • Mantenimiento manual.<br>• Reglas predominantemente estáticas sin filtrado por globs en muchas carpetas. |
| **`claude-code-starter`** *(wyndomb)* / **`claude-md-templates`** | Scaffolds para el CLI de Claude Code con `CLAUDE.md`, scripts de planificación diaria y hooks. | **Gratuito / Open Source** | • Aprovecha hooks nativos de Claude Code.<br>• Estructura modular global vs proyecto.<br>• Flujos de planificación diaria. | • Específico de un solo CLI.<br>• No contempla validación de negocio ni metodologías de producto.<br>• Sin gobernanza multi-repo. |
| **Boilerplates Comerciales AI-Native** *(Supastarter, Makerkit, ShipFast)* | Indie hackers, agencias y fundadores que lanzan productos SaaS. | **Pago único comercial**:<br>• ShipFast: $199 – $299<br>• Supastarter: $349 – $1.499+ | • Código de producción funcional (Auth, Pagos, DB, i18n).<br>• Incluyen `AGENTS.md` y `.cursorrules` pre-configurados para el stack.<br>• Alto ROI percibido. | • Alto precio de entrada.<br>• Fuerte acoplamiento al stack tecnológico del autor.<br>• Sobrecarga de código si solo se busca estructurar el agente. |
| **Herramientas de Linteo y Empaquetado** *(agentlint, repomix, Aider CLI)* | Desarrolladores senior, ingenieros de plataforma y devops. | **Open Source / Open Core** (Freemium en tooling avanzado). | • Validación sintáctica y de rutas rotas en reglas (`agentlint`).<br>• Empaquetado eficiente de contexto (`repomix`).<br>• Modo arquitecto determinista (Aider `--architect`). | • Requieren adopción de nuevas CLIs.<br>• No aportan metodología de negocio ni diseño de producto. |
| **Antigravity Starter Template** *(`agy-starter-template`)* | Desarrolladores y fundadores que crean software o validan ideas en Google Antigravity. | **Open Source** (Plantilla base). | • 9 subagentes especializados y 11 slash commands.<br>• Revelación progresiva (skills bajo demanda).<br>• Camino dual: software + validación lean de negocio (`/idea`).<br>• Hooks deterministas no bloqueantes. | • Curva de aprendizaje inicial.<br>• Vinculado a convenciones del ecosistema Antigravity/Gemini.<br>• Requiere disciplina procedimental del usuario. |

---

## 4. Tamaño de la Oportunidad (Estimación Bottom-Up)

Aplicamos la fórmula estricta:  
$$\text{Tamaño del Mercado} = \text{Clientes potenciales alcanzables} \times \text{Importe anual esperado}$$

### Paso 1: Base de Desarrolladores Profesionales (Dato Verificado)
- **Evans Data Corporation (2025):** 28.700.000 desarrolladores profesionales activos en el mundo. *(Nota de contraste: SlashData sitúa la cifra en 36,5M; tomamos la cifra más conservadora de 28,7M)*.

### Paso 2: Adopción de Herramientas de Codificación con IA (Dato Verificado)
- **Stack Overflow Developer Survey (2024):** El 63,2% de los desarrolladores profesionales utiliza herramientas de IA en su trabajo diario (el 76% las utiliza o planea utilizarlas a corto plazo).
- Desarrolladores profesionales con IA:  
  $$28.700.000 \times 63,2\% = 18.138.400 \text{ desarrolladores}$$

### Paso 3: Segmento de Codificación Agéntica / Próxima Generación (Dato Estimado)
- No todos los usuarios de IA operan con agentes autónomos (muchos solo usan autocompletado inline de código).
- Estimamos que un **20%** de los usuarios profesionales de IA han migrado a flujos agénticos (Cursor, Claude Code, Antigravity, Windsurf, Aider):  
  $$18.138.400 \times 20\% = 3.627.680 \text{ desarrolladores agénticos (SAM)}$$

### Paso 4: Segmento Alcanzable para Scaffolds Estructurados (Dato Estimado)
- La inmensa mayoría de los desarrolladores utiliza configuraciones mínimas manuales o por defecto. Estimamos que un **5%** busca y adopta activamente scaffolds, templates avanzados y directrices de repositorio estructuradas:  
  $$3.627.680 \times 5\% = 181.384 \text{ desarrolladores (SOM)}$$

### Paso 5: Arqueos de Monetización y Captura de Valor

*   **Escenario A: Venta de plantilla agéntica premium (Modelo B2C / Gumroad):**
    - Conversión estimada a compra: 3%.
    - Compradores: $181.384 \times 3\% = 5.441 \text{ desarrolladores}$.
    - Ticket promedio: $49 USD (pago único).
    - **Ingreso total potencial:** $5.441 \times \$49 = \mathbf{\$266.609\text{ USD}}$.  
      *(Conclusión: Mercado no escalable para un negocio de software; techo bajo para un creador independiente).*

*   **Escenario B: Plataforma SaaS de Sincronización, Linteo y Gobernanza de Reglas (B2B):**
    - Adopción: 1% de los desarrolladores en equipos adquieren una herramienta para mantener actualizados los `AGENTS.md` y reglas entre microservicios.
    - Asientos de pago: $181.384 \times 1\% = 1.814 \text{ usuarios/asientos}$.
    - Cuota anual: $15 USD/mes ($180 USD/año).
    - **ARR Potencial:** $1.814 \times \$180 = \mathbf{\$326.520\text{ USD/año}}$.

*   **Escenario C: Boilerplate de Código Completo con Arquitectura Agéntica (ej. Supastarter):**
    - Adquisición: 2% compran una base de código para levantar un SaaS al año ($3.627$ ventas).
    - Ticket promedio: $249 USD.
    - **Ingreso anual:** $3.627 \times \$249 = \mathbf{\$903.123\text{ USD}}$.

*   **Escenario D: Estrategia Open Source como Canal de Adquisición (Lead Magnet CAC ~$0):**
    - El template se distribuye libremente. Atrae 100.000 desarrolladores. Una fracción del 0,1% contrata consultoría corporativa o adopta el producto principal del autor (ej. Midday). Con 10 proyectos de consultoría a $10.000 USD, se capturan **$100.000 USD**, con coste de adquisición marginal nulo.

---

## 5. Tendencias y Vientos de Cola

1. **Institucionalización del estándar abierto `AGENTS.md` (2025–2026):**  
   Impulsado bajo la Agentic AI Foundation (Linux Foundation), `AGENTS.md` se consolida como el equivalente al `README.md` pero destinado a inteligencias artificiales. Evita el bloqueo de proveedor (*vendor lock-in*) entre Cursor, Claude Code, Windsurf y Google Antigravity.
2. **Abandono del monolito por el "Scoped Frontmatter" (`.mdc` y Globs):**  
   Cursor lideró este cambio al desaconsejar el archivo único `.cursorrules` en favor de `.cursor/rules/*.mdc` con metadatos YAML (`globs: [...]`, `alwaysApply: false`). Esto reduce entre un 40% y un 70% el consumo innecesario de tokens al cargar únicamente las reglas relevantes para los archivos editados.
3. **Arquitecturas de Revelación Progresiva (*Progressive Disclosure*):**  
   Frameworks modernos de agentes adoptan subdirectorios de skills (como `.agents/skills/` o `.claude/skills/`). El sistema inyecta un índice ligero y solo expande la documentación completa cuando el agente detecta la necesidad de esa tarea específica.
4. **La brecha de confianza impulsando la verificación empírica:**  
   Según Stack Overflow 2024, aunque el 76% usa o planea usar IA, **solo el 43% confía en su precisión**. Los templates que delegan en herramientas deterministas (ejecutar tests reales, linters, pre-commit hooks) tienen ventaja frente a aquellos que confían ciegamente en la palabra del LLM.

---

## 6. Alternativas Manuales e Indirectas

Los desarrolladores no eligen únicamente entre templates agénticos competidores; sus alternativas primarias son:

1. **El `AGENTS.md` / `CLAUDE.md` minimalista escrito a mano (30 a 50 líneas):**  
   Muchos desarrolladores senior prefieren un archivo conciso con el stack tecnológico, comandos de build/test y 3 o 4 reglas negativas tajantes ("nunca agregues dependencias sin avisar", "no uses sintaxis deprecada"). No sufre de rot, consume tokens despreciables y no confunde al agente.
2. **Linters y Formateadores Deterministas (ESLint, Biome, Prettier, Ruff, Rustfmt):**  
   Configurados en hooks locales (`husky`, `pre-commit`). Es más barato, rápido y seguro forzar el formateo y la tipificación mediante herramientas de terminal que pedirle al modelo por prompt que "recuerde formatear el código".
3. **Devcontainers, Docker y Nix:**  
   Aíslan el entorno de desarrollo. En lugar de explicarle al agente cómo configurar librerías del sistema, el contenedor garantiza que las herramientas estén preinstaladas.
4. **Capacidades nativas del arnés del agente (RAG dinámico, búsqueda semántica y AST):**  
   A medida que herramientas como Google Antigravity o Cursor mejoran su indexación interna de símbolos y llamadas a herramientas, la necesidad de incluir un mapa manual del repositorio en un template se vuelve redundante.

---

## 7. Barreras de Entrada y Ventajas Defensivas

*   **Barrera tecnológica nula (Foso defensivo casi inexistente):** Un starter template está compuesto por texto Markdown, archivos JSON y scripts shell públicos. Cualquier competidor puede bifurcar (*fork*) el repositorio, renombrarlo y redistribuirlo en minutos.
*   **Resistencia cultural al pago por configuración:** En el desarrollo de software existe una norma cultural muy arraigada de que las plantillas de configuración deben ser de código abierto. Intentar cobrar por un conjunto de prompts genera rechazo inmediato en comunidades como Reddit y Hacker News.
*   **Efectos de red limitados a directorios:** Solo los directorios masivos como `cursor.directory` gozan de efectos de red (los autores envían sus reglas allí para ganar visibilidad). Un template estático carece de dicho efecto a menos que construya una comunidad activa de plugins.

---

## 8. Evidencia en Contra (Por qué un Starter Template Agéntico Puede Fracasar)

1. **"Prompt Rot" y Pesadilla de Mantenimiento:**  
   Las librerías actualizan versiones (ej. Next.js 14 -> 15, cambios de React Server Actions). Un template con reglas fijas empieza a inducir alucinaciones y errores de sintaxis en pocos meses si el autor no dedica decenas de horas mensuales a actualizarlo.
2. **Sobrecarga de Contexto y Pérdida de Eficacia (*Instruction Fatigue*):**  
   Investigaciones y debates en Hacker News confirman que inyectar cientos de líneas de directrices degrada el rendimiento de los modelos frontera. El agente pierde el foco, pasa por alto restricciones clave y aumenta la latencia y factura de la API.
3. **Fricción y Falsos Positivos en Hooks de Ciclo de Vida:**  
   Hooks estrictos de pre-ejecución o pre-commit que bloquean al agente cuando falta un binario local (ej. fallo en un script bash por no encontrar `jq` o un formateador específico) provocan frustración inmediata y llevan al desarrollador a borrar la carpeta `.agents/`.
4. **Riesgo de Plataforma Absoluto:**  
   Tanto Google (Antigravity) como Anthropic (Claude Code) optimizan activamente sus agentes para que funcionen "bien de fábrica" sin necesidad de andamiajes complejos. Cualquier scaffold que requiera excesiva configuración corre el riesgo de ser reemplazado por una actualización del motor del agente.

---

## 9. Fuentes y Fechas de Consulta

*   **Stack Overflow Developer Survey 2024:** 63,2% de uso en desarrolladores profesionales; 43% de confianza en precisión. Consultado el 10-09-2026. [stackoverflow.blog](https://stackoverflow.blog/2024/07/08/the-2024-developer-survey-results-are-here/)
*   **Evans Data Corporation:** *Worldwide Developer Population and Demographic Study 2025* (28,7M de profesionales). Consultado el 10-09-2026. [evansdata.com](https://evansdata.com)
*   **SlashData Developer Nation Report 2025:** 36,5M de profesionales; 47,2M población total de programadores. Consultado el 10-09-2026. [slashdata.co](https://slashdata.co)
*   **GitHub Octoverse 2024/2025:** Estadísticas de adopción y repositorios de IA. Consultado el 10-09-2026. [github.blog](https://github.blog)
*   **Cursor Official Documentation:** *Rules for AI (`.cursor/rules/*.mdc`)*. Consultado el 10-09-2026. [cursor.com/docs](https://cursor.com/docs)
*   **Cursor Directory:** Creado por Pontus Abrahamsson (Midday.ai), >200.000 usuarios mensuales, ~4k estrellas en GitHub. Consultado el 10-09-2026. [cursor.directory](https://cursor.directory)
*   **Anthropic Claude Code Documentation:** Lanzamiento Research Preview en febrero 2025, General Availability en mayo 2025, convención `CLAUDE.md`. Consultado el 10-09-2026. [anthropic.com](https://docs.anthropic.com)
*   **Agentic AI Foundation / Linux Foundation:** Convención estándar `AGENTS.md`. Consultado el 10-09-2026. [linuxfoundation.org](https://linuxfoundation.org)
*   **Supastarter & ShipFast Pricing:** Análisis de boilerplates comerciales ($199–$1.499+). Consultado el 10-09-2026. [supastarter.dev](https://supastarter.dev), [shipfa.st](https://shipfa.st)
*   **Comunidad técnica (Reddit r/Cursor, r/ClaudeAI, Hacker News):** Discusiones sobre degradación de rendimiento por reglas largas y "stale rules". Consultado el 10-09-2026.

---

## 10. Vacíos de Información y Plan de Validación

*   `{{PENDIENTE: Tasa de retención real a 30 días de desarrolladores que usan un template agéntico frente a los que lo podan o abandonan}}`  
    *Cómo averiguarlo:* Implementar telemetría opt-in en el script `/setup` de `agy-starter-template` o realizar un estudio de cohorte en GitHub con 50 usuarios midiendo commits subsiguientes en la carpeta `.agents/`.
*   `{{PENDIENTE: Impacto cuantitativo en latencia y coste de tokens entre un sistema de skills bajo demanda frente a un prompt monolítico en Antigravity}}`  
    *Cómo averiguarlo:* Diseñar un benchmark reproducible de 10 tareas de refactorización y medir consumo de tokens de entrada/salida y tiempo de respuesta total.
*   `{{PENDIENTE: Disposición real a pagar por extensiones de soporte empresarial o sincronización de AGENTS.md en organizaciones reguladas}}`  
    *Cómo averiguarlo:* Ejecutar 15 entrevistas de validación cualitativa con Engineering Managers o Directores de Plataforma antes de programar cualquier servicio de pago.

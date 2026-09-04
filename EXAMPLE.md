# Ejemplo práctico de principio a fin con Antigravity

Un recorrido completo con un caso práctico realista, mostrando **en qué orden** se utiliza cada comando de Antigravity y la justificación metodológica de dicho orden.

> **El caso de estudio — AdPiloto**
>
> Una plataforma SaaS por suscripción mensual que permite a pequeñas y medianas empresas
> diseñar, configurar y optimizar campañas publicitarias en Meta Ads y Google Ads desde una interfaz unificada,
> sin requerir los servicios de una agencia de marketing tradicional.

---

## El mapa de ruta completo

| # | Fase | Acción / Comando | Propósito |
|---|---|---|---|
| 1 | Día 1 | `git clone` + `agy` | Disponer del entorno de trabajo |
| 2 | Día 1 | `/setup` | Adaptar el template al proyecto AdPiloto |
| 3 | Día 1 | `/idea` | Identificar las hipótesis que podrían invalidar la idea |
| 4 | Día 2 | Subagente `market-researcher` | Investigar alternativas y competidores reales |
| 5 | Día 3 | `/adr` | Registrar la decisión de viabilidad ("seguir / girar / parar") |
| 6 | Semana 1 | Subagente `business-analyst` | Traducir la propuesta a requerimientos y métricas |
| 7 | Semana 1 | Subagente `product-strategist` | Definir el alcance estricto del MVP |
| 8 | Semana 1 | `/adr` | Documentar el alcance del MVP |
| 9 | Semana 2 | Completar `AGENTS.md` | Fijar stack, convenciones y reglas verificadas |
| 10 | Semana 2 | `/plan` + `/adr` | Seleccionar arquitectura técnica inicial |
| 11 | Por cada iteración | `/onboard` | Comprender a fondo el componente a construir |
| 12 | Por cada iteración | `/plan` | Definir el plan de implementación paso a paso |
| 13 | Por cada iteración | Implementar | Escribir código respetando convenciones y hooks |
| 14 | Por cada iteración | `/verify` | Validar empíricamente con builds, tests y sondas |
| 15 | Por cada iteración | `/code-quality` | Revisión de calidad previa a pull request |
| 16 | Por cada iteración | `/pr-summary` | Generar descripción estructurada de la entrega |
| 17 | Periódicamente | `/docs-sync` | Asegurar que la documentación técnica no mienta |

---

## Fase 0 — Preparar el terreno

**Tiempo estimado: 20 minutos (una sola vez).**

### 1. Clonar el repositorio

```bash
git clone https://github.com/thatswyn/agy-starter-template adpiloto
cd adpiloto
rm -rf .git && git init
agy
```

### 2. Ejecutar `/setup`

```text
/setup AdPiloto: SaaS por suscripción para que pymes gestionen campañas de Meta Ads y Google Ads sin agencia. Actualmente es una idea de negocio en fase de validación inicial sin código.
```

Antigravity te formulará las preguntas clave:
- Ajustará `AGENTS.md` con el estado inicial.
- Mantendrá tanto los módulos de negocio como los técnicos para cubrir todo el ciclo.
- Verificará que los hooks (`protect-branch`, `auto-format`, `skill-eval`) estén activos.

---

## Fase 1 — Examinar la idea antes de programar

**Tiempo estimado: dos a tres días. Es la fase que mayor ahorro económico produce.**

### 3. Ejecutar `/idea`

```text
/idea Plataforma SaaS por suscripción donde pequeños comercios configuran y gestionan sus campañas de Meta Ads y Google Ads sin necesidad de contratar agencias.
```

Antigravity somete la propuesta a un escrutinio crítico:
- **Hipótesis 1 (Problema):** El comerciante quiere gestionar las campañas él mismo en lugar de delegarlas íntegramente.
- **Hipótesis 2 (Precio):** El dolor es suficiente como para justificar una cuota mensual recurrente.
- **Hipótesis 3 (Riesgo técnico/regulatorio - El "no" más caro):** Obtención de acceso de producción a las APIs de Marketing de Meta y Google Ads para operar sobre cuentas de terceros.
- **Hipótesis 4 (Canal/CAC):** Coste de captación inferior al valor de vida del cliente (LTV).

El análisis identifica que la **Hipótesis 3** es el riesgo crítico: si las políticas de API de Meta o Google deniegan la gestión sobre cuentas ajenas, el producto no puede existir independientemente del software desarrollado.

**El experimento económico prioritario:**
Solicitar cuentas de desarrollador y revisar las directrices de acceso a la API de Marketing de terceros. Cero euros de inversión; dos días de análisis documental.

### 4. Consultar al subagente `market-researcher`

```text
Delega en el subagente market-researcher para analizar las herramientas actuales de gestión publicitaria para pymes: precios, competidores y alternativas manuales.
```

El subagente aporta datos contrastados con fuentes y fechas:
- Los propios administradores nativos gratuitos (Meta Ads Manager y Google Ads).
- Agencias locales de marketing.
- Alternativas manuales o inacción (no hacer publicidad).

### 5. Registrar la decisión con `/adr`

```text
/adr AdPiloto se enfocará inicialmente como vertical exclusivo para tiendas de comercio electrónico (e-commerce), aplazando negocios de servicios locales
```

La justificación queda inmutable en `docs/decisions/0001-vertical-ecommerce.md`.

---

## Fase 2 — De la idea al alcance del MVP

### 6. Subagente `business-analyst`

```text
Delega en business-analyst para convertir la iniciativa en requerimientos funcionales y criterios de aceptación medibles.
```

El analista define:
- **Perfil de usuario:** responsable de e-commerce.
- **Métrica Norte:** comercios con al menos 1 campaña activa y rentable a los 30 días del alta.
- **Requisitos ordenados (MoSCoW):** conexión OAuth segura, selección de plantillas de campaña preconfiguradas, panel de métricas consolidado.

### 7. Subagente `product-strategist`

```text
Delega en product-strategist para acotar el alcance estricto del MVP para un plazo de desarrollo de 8 semanas.
```

Se definen las renuncias explícitas:
- **Entra en el MVP:** Integración inicial exclusiva con Meta Ads (una sola API para validar tracción).
- **Queda fuera:** Integración con Google Ads (se aplaza para reducir el riesgo de integración simultánea).

### 8. Documentar el alcance con `/adr`

```text
/adr El MVP de AdPiloto integrará únicamente Meta Ads; Google Ads se aplaza a la fase 2
```

---

## Fase 3 — Fijar el contexto técnico

### 9. Rellenar `AGENTS.md` de forma definitiva

Una vez tomada la decisión tecnológica (p. ej. TypeScript, Next.js, PostgreSQL y Prisma):

```bash
$EDITOR AGENTS.md
```

Completa comandos de build, test, lint, variables de entorno y reglas duras (p. ej. "prohibido almacenar tokens de Meta en texto plano; deben cifrarse con clave simétrica en reposo").

### 10. Diseñar arquitectura inicial con `/plan`

```text
/plan Arquitectura técnica de AdPiloto: autenticación de usuarios, flujo OAuth con Meta Graph API, cifrado de tokens en base de datos y jobs de sincronización periódica de métricas.
```

El subagente `solution-architect` evalúa alternativas, pondera pros y contras y entrega el desglose de implementación. Tras validarlo, se documenta con `/adr`.

---

## Fase 4 — Ciclo de desarrollo iterativo

Por cada funcionalidad o bloque de trabajo, se repite el bucle de seis pasos:

```text
1. /onboard {{funcionalidad}}    # Conocer archivos, dependencias y restricciones
2. /plan                         # Diseñar el plan técnico exacto
3. [Implementación]              # Escribir código en rama protegida por hooks
4. /verify                       # Comprobar ejecutando build, tests y sondas adversarias
5. /code-quality                 # Revisión estricta de calidad y seguridad
6. /pr-summary                   # Redactar resumen del Pull Request para revisión
```

---

## Fase 5 — Mantenimiento y prevención de degradación

Cada pocas semanas:

```text
/docs-sync
```

Detecta discrepancias entre el código real y los manuales de `docs/` o `AGENTS.md`.

Y la regla fundamental de aprendizaje:
> **Cada vez que Antigravity cometa el mismo error dos veces por una peculiaridad de tu sistema, documenta la regla en la sección de trampas conocidas de `AGENTS.md`.**

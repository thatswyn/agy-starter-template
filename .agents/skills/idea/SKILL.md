---
name: idea
description: Someter una idea de negocio a un examen honesto antes de invertir esfuerzo en Antigravity. Despeja hipótesis letales, investiga el mercado real y diseña el experimento más barato.
---

# Examen de idea de negocio

Idea: descripción de la idea o hipótesis de negocio.

Tu labor aquí **no** es hacer que la idea suene prometedora o atractiva. Tu misión es descubrir lo antes posible si existe un fallo estructural que la invalide, evitando invertir meses de desarrollo en vano. Si la idea supera este examen crítico, merecerá la pena construirla.

Si la carpeta `docs/product/` contiene documentos previos, léelos primero para no duplicar trabajo.

## 1. Concretar la propuesta de valor

Si es necesario, utiliza `ask_question` para delimitar:

- **Quién** experimenta el problema (un perfil concreto, no "las empresas").
- **Cómo lo resuelve hoy** esa persona (siempre existe una solución actual, aunque sea precaria o manual).
- **Cuánto le cuesta** el problema actualmente (en horas, dinero o riesgo).
- **Por qué tú**: qué ventaja o conocimiento diferencial posees que no sea trivial de replicar.

## 2. Ordenar hipótesis por nivel de riesgo

Enumera todo lo que la idea asume como cierto sin evidencia empírica, y ordénalo por **el daño que causaría si fuese falso**:

1. **Problema real**: ¿existe un dolor agudo o solo una incomodidad tolerable?
2. **Disposición al pago**: ¿el dolor es suficiente para que paguen? Decir "me interesa" es gratis; pagar no.
3. **Canal y captación**: ¿el coste de adquisición de clientes (CAC) es sostenible respecto al valor de vida (LTV)?
4. **Viabilidad técnica y regulatoria**: ¿es posible operarlo por menos de lo que ingresa y sin bloqueos legales?

## 3. Buscar evidencia existente de mercado

Delega en el subagente `market-researcher` con `invoke_subagent`. Debe identificar competidores directos e indirectos, alternativas manuales y estimaciones de mercado de abajo hacia arriba.

**Regla estricta:** ningún dato sin fuente contrastada y fecha. Nada de cifras inventadas.
La ausencia de competidores no suele ser una buena señal; casi siempre indica ausencia de mercado.

## 4. El examen honesto

Responde a estas cuestiones sin suavizar el tono:

- ¿Qué condiciones tendrían que cumplirse simultáneamente para que esto funcione?
- ¿Por qué no lo ha hecho nadie antes? Si alguien lo intentó, ¿por qué fracasó?
- ¿Qué ocurre si un competidor establecido lo replica en unas semanas?
- **¿Quién es el "no" más caro?** El obstáculo que se descubriría tarde (licencias, normativas, APIs de terceros cerradas).
- ¿Cuál es la alternativa actual y por qué no es suficiente?

## 5. El experimento más barato

Para la hipótesis más peligrosa, diseña la prueba más económica posible:

- En qué consiste exactamente y cuántos días requiere.
- Coste en tiempo y recursos.
- **Umbral definido por escrito antes de empezar**: qué métrica o resultado exacto significará continuar, cuál pivotar y cuál parar.

Casi nunca requiere programar software completo: suele ser entrevistas cualitativas, una preventa o prestar el servicio manualmente a cinco clientes.

## 6. Documentar y entregar

Guarda el análisis detallado en `docs/product/validacion-{{slug}}.md` con: hipótesis ordenadas, evidencia encontrada, experimento propuesto, umbrales y veredicto.

Presenta en pantalla un resumen en cinco viñetas con recomendación explícita: **seguir**, **girar (pivotar)** o **parar**.

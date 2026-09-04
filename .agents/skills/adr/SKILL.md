---
name: adr
description: Registrar una decisión técnica o de producto y su porqué en Antigravity. Crea un Architectural Decision Record inmutable en docs/decisions/ basado en la plantilla estándar.
---

# Registro de decisión arquitectónica (ADR)

Decisión objetivo: título o descripción de la decisión a documentar.

Un ADR existe para que dentro de uno o dos años cualquier persona del equipo entienda con claridad por qué se tomó este camino y no otro, sin tener que reconstruir el contexto desde cero. El verdadero valor reside en el **contexto histórico y las alternativas descartadas**, no en la decisión en sí.

## 1. Asignar numeración

Inspecciona la carpeta `docs/decisions/` con `find_by_name` o `list_dir` y toma el siguiente número correlativo disponible. Formato:
`docs/decisions/NNNN-titulo-en-kebab-case.md` (por ejemplo: `0001-base-de-datos-postgresql.md`).

## 2. Redactar el documento

Utiliza `docs/decisions/0000-plantilla.md` como base estructural:

- **Contexto**: la situación y restricciones reales que motivaron la decisión (plazos, equipo, presupuesto, deuda técnica). Sin contexto el ADR pierde su utilidad con el paso del tiempo.
- **Alternativas consideradas**: las opciones reales evaluadas y los motivos concretos de su descarte.
- **Decisión**: qué se decidió formalmente, expresado en presente y voz activa.
- **Consecuencias**: tanto las positivas como las negativas. Todo trade-off tiene un coste; si no se detectan consecuencias negativas, el análisis está incompleto.
- **Qué la revertiría**: qué condiciones o métricas obligarían a reconsiderar este enfoque en el futuro.
- Fecha: fecha actual en formato `AAAA-MM-DD`.

## 3. Principios clave

- Los ADR son inmutables. Si una decisión cambia, se redacta un nuevo ADR que marca el anterior como **Superado por ADR-NNNN**. Nunca se sobrescribe el registro histórico.
- Documenta únicamente lo que se ha acordado firmemente; los puntos no resueltos se consignan en "preguntas abiertas".
- La concisión es virtud: una o dos páginas bien estructuradas son más efectivas que un documento extenso que nadie leerá.

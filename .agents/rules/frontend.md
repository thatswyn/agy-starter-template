---
description: Convenciones y directrices para desarrollo Frontend y UI en Antigravity
globs: ["src/components/**", "src/app/**", "src/pages/**", "src/views/**", "**/*.tsx", "**/*.jsx", "**/*.vue", "**/*.svelte", "**/*.css", "**/*.scss"]
---

# Reglas de Frontend y UI

Aplica estas directrices al crear o modificar componentes, vistas o estilos de frontend:

## 1. Tipado y Arquitectura de Componentes
- **TypeScript estricto:** Prohibido el uso de tipo `any`. Tipa explícitamente props, eventos y retornos de funciones de componente.
- **Componentes funcionales puros:** Separa la lógica de presentación de los efectos secundarios o llamadas a red (extrae la lógica compleja a custom hooks o stores).
- **Composición sobre herencia:** Favorece componentes pequeños y reutilizables con un único propósito claro.

## 2. Accesibilidad (a11y) y Semántica
- Utiliza etiquetas HTML nativas semánticas (`<button>`, `<nav>`, `<main>`, `<article>`) en lugar de `<div>` con manejadores `onClick`.
- Incluye atributos `aria-label` en botones basados únicamente en iconos y textos alternativos descriptivos en elementos multimedia.
- Diseña interfaces completamente navegables mediante teclado y respeta el contraste de color WCAG AA.

## 3. Estado y Rendimiento
- **Minimiza el estado global:** Mantén el estado en el componente más cercano que lo necesite; eleva el estado (*lift state up*) solo cuando sea indispensable.
- **Evita re-renderizados innecesarios:** Memoriza selectores computados o callbacks pesados solo cuando haya evidencia de coste de cálculo.
- **Carga diferida:** Emplea importaciones dinámicas o splitting en rutas secundarias y modales pesados.

## 4. Gestión de Estilos
- Respeta el sistema de diseño del proyecto (Tailwind, CSS Modules o Styled Components).
- Prohibidos estilos inline hardcodeados con valores arbitrarios de espaciado o color.

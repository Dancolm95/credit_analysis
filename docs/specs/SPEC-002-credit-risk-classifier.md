# SPEC-002 — Clasificación del ratio deuda/ingreso

## Objetivo

Clasificar el porcentaje de deuda/ingreso en una categoría simple y comprensible.

## Reglas

- `0% – 30%` → Bajo
- `>30% – 40%` → Moderado
- `>40% – 50%` → Alto
- `>50%` → Muy alto

## Criterios de aceptación

1. El sistema debe recibir un porcentaje de deuda/ingreso.
2. Debe devolver una única clasificación.
3. Los valores límite deben respetar exactamente los rangos definidos.
4. No debe aceptar porcentajes negativos.
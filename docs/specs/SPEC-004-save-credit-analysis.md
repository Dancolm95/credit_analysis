# SPEC-004 — Guardar análisis crediticio

## Objetivo

Persistir cada análisis realizado para poder consultarlo posteriormente.

## Datos a guardar

- ingreso mensual
- tarjetas de crédito
- préstamos personales
- crédito vehicular
- crédito hipotecario
- otras deudas
- deuda total
- porcentaje calculado
- categoría resultante
- fecha de creación

## Criterios de aceptación

1. El sistema debe guardar un análisis completo.
2. La deuda total guardada debe corresponder a la suma de todas las categorías.
3. El porcentaje guardado debe corresponder al cálculo realizado.
4. La categoría guardada debe corresponder al porcentaje calculado.
5. Cada registro debe incluir una fecha de creación.
# SPEC-004 — Guardar análisis crediticio

## Objetivo

  Persistir en Supabase cada análisis realizado por un usuario autenticado,
  para que pueda ser consultado posteriormente.
 Cada análisis debe tener un identificador único.
 Cada análisis debe pertenecer al usuario autenticado.
 La fecha de creación debe ser asignada por la base de datos.
 Un usuario no debe poder guardar análisis para otro usuario.
 Los datos deben permanecer disponibles después de cerrar y volver a abrir la aplicación.
 Un error de persistencia no debe considerarse un guardado exitoso.

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
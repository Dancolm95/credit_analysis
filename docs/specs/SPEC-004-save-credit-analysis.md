# SPEC-004 — Guardar análisis crediticio

## Objetivo

Persistir en Supabase cada análisis realizado por un usuario autenticado, para
que permanezca disponible después de cerrar o recargar la aplicación y pueda
ser consultado posteriormente.

## Alcance

- La persistencia se realizará en PostgreSQL mediante Supabase.
- Cada análisis pertenecerá a un único usuario autenticado.
- Esta especificación cubre la creación de registros.
- La consulta del historial se definirá en una especificación separada.
- No se incluyen edición, eliminación, sincronización sin conexión ni
  almacenamiento local alternativo.

## Datos a guardar

- identificador único
- identificador del usuario propietario
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

## Reglas

- El identificador del análisis debe ser generado por la base de datos.
- El identificador del usuario debe obtenerse de la sesión autenticada; no debe
  recibirse como un valor editable desde la interfaz.
- La fecha de creación debe ser generada por la base de datos y almacenada con
  zona horaria.
- El ingreso mensual debe ser mayor que cero.
- Las categorías de deuda y la deuda total no pueden ser negativas.
- La deuda total debe corresponder a la suma de todas las categorías de deuda.
- El porcentaje debe corresponder a la relación entre deuda total e ingreso
  mensual.
- La categoría debe corresponder a los rangos definidos en `SPEC-002`.
- Un fallo de red, autenticación o base de datos debe informarse como error; la
  aplicación no debe presentar el análisis como guardado.

## Seguridad

- La tabla debe tener Row Level Security habilitado.
- Solo el rol `authenticated` puede crear análisis.
- La política de inserción debe comprobar que `auth.uid()` coincida con el
  propietario del nuevo registro.
- No se concederán operaciones de actualización o eliminación en esta etapa.

## Criterios de aceptación

1. El sistema debe guardar un análisis completo.
2. La deuda total guardada debe corresponder a la suma de todas las categorías.
3. El porcentaje guardado debe corresponder al cálculo realizado.
4. La categoría guardada debe corresponder al porcentaje calculado.
5. Cada registro debe incluir una fecha de creación.
6. Cada registro debe tener un identificador único generado por la base de
   datos.
7. Cada registro debe pertenecer al usuario autenticado que lo creó.
8. Un usuario no autenticado no puede guardar análisis.
9. Un usuario no puede guardar un análisis a nombre de otro usuario.
10. La fecha de creación no depende del reloj ni de un valor proporcionado por
    el cliente.
11. Los datos guardados permanecen disponibles después de cerrar sesión,
    recargar o volver a abrir la aplicación.
12. Ante un fallo de persistencia, el caso de uso devuelve un error y no informa
    un guardado exitoso.

## Estrategia de pruebas

- Tests unitarios del caso de uso y del mapeo entre dominio y persistencia.
- Tests de integración del repositorio contra Supabase local.
- Tests pgTAP para la tabla, columnas, tipos, restricciones y valores por
  defecto.
- Tests pgTAP de RLS para inserciones autenticadas, no autenticadas y con un
  propietario diferente.

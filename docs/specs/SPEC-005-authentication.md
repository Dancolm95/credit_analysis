# SPEC-005 — Autenticación de usuarios

## Objetivo

Permitir que cada usuario se registre, inicie sesión y cierre sesión mediante
Supabase Auth, de modo que la aplicación pueda identificarlo y proteger sus
análisis crediticios.

## Funcionalidades incluidas

- Registro con correo electrónico y contraseña.
- Inicio de sesión con correo electrónico y contraseña.
- Restauración de una sesión válida al recargar la aplicación.
- Cierre de sesión.
- Protección del contenido destinado a usuarios autenticados.
- Presentación de estados de carga y errores de autenticación.

## Reglas

- El correo electrónico es obligatorio y debe tener un formato válido.
- La contraseña es obligatoria y debe contener al menos 8 caracteres.
- La aplicación debe usar la identidad proporcionada por Supabase Auth.
- Mientras se restaura la sesión, la aplicación no debe mostrar temporalmente
  contenido protegido.
- Un usuario no autenticado debe permanecer en la pantalla de autenticación.
- Después de cerrar sesión, el usuario no debe poder acceder al contenido
  protegido sin autenticarse nuevamente.
- Los mensajes de error deben ser comprensibles y no deben revelar información
  sensible ni credenciales.

## Criterios de aceptación

1. Un usuario puede registrarse con un correo válido y una contraseña de al
   menos 8 caracteres.
2. El sistema rechaza un correo con formato inválido antes de enviar la
   solicitud a Supabase.
3. El sistema rechaza una contraseña de menos de 8 caracteres antes de enviar
   la solicitud a Supabase.
4. Un usuario registrado puede iniciar sesión con credenciales válidas.
5. Las credenciales inválidas no crean una sesión y muestran un mensaje de
   error.
6. Una sesión válida se conserva después de recargar la aplicación.
7. Mientras se determina el estado de la sesión, se muestra un estado de carga
   y no se presenta contenido protegido.
8. Un usuario autenticado puede acceder al formulario y al historial de sus
   análisis.
9. Un usuario no autenticado no puede acceder al formulario ni al historial.
10. Al cerrar sesión se elimina la sesión local y se muestra nuevamente la
    pantalla de autenticación.
11. La aplicación obtiene el identificador del usuario desde la sesión; no lo
    solicita ni permite editarlo manualmente.

## Seguridad

- El cliente Flutter utilizará únicamente la URL del proyecto y la clave
  publicable de Supabase.
- La clave `service_role` no debe incluirse en la aplicación ni en el
  repositorio.
- Las contraseñas no deben almacenarse, registrarse ni enviarse fuera de
  Supabase Auth.
- La autorización sobre los análisis se aplicará en PostgreSQL mediante RLS y
  se especificará junto con la persistencia y consulta de análisis.

## Estrategia de pruebas

- Tests unitarios para validación de correo y contraseña.
- Widget tests para los estados de carga, autenticado, no autenticado y error.
- Tests de integración contra un proyecto local de Supabase para registro,
  inicio de sesión, restauración de sesión y cierre de sesión.
- Tests pgTAP separados para verificar las políticas RLS sobre los análisis.

## Fuera de alcance

- Recuperación o cambio de contraseña.
- Inicio de sesión con Google, Apple u otros proveedores OAuth.
- Roles administrativos.
- Autenticación multifactor.
- Verificación de correo electrónico.
- Eliminación de cuentas.

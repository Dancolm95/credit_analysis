# Constitution

## Propósito

Esta constitución funciona como guía para mantener consistencia durante el desarrollo. No busca imponer reglas rígidas, sino orientar las decisiones técnicas y de implementación.

## Principios

### 1. Spec-Driven Development

Toda funcionalidad relevante debería partir de una especificación clara antes de comenzar la implementación.

La especificación debe explicar principalmente:

- qué problema se quiere resolver;
- qué comportamiento se espera;
- qué condiciones deben cumplirse.

### 2. Test-Driven Development

La lógica de negocio debería desarrollarse siguiendo TDD siempre que resulte razonable.

El ciclo recomendado es:

1. Escribir un test que falle.
2. Implementar lo mínimo necesario para hacerlo pasar.
3. Refactorizar manteniendo los tests funcionando.

### 3. SOLID sin sobrearquitectura

Se aplicarán principios SOLID cuando mejoren:

- mantenibilidad;
- claridad;
- capacidad de prueba;
- separación de responsabilidades.

No se crearán abstracciones únicamente para cumplir formalmente con un patrón.

### 4. Simplicidad y mantenibilidad

Se priorizará la solución más simple que cumpla correctamente con los requisitos actuales.

Se evitarán:

- abstracciones prematuras;
- dependencias innecesarias;
- complejidad sin una necesidad concreta.

### 5. Cambios pequeños y revisables

Las funcionalidades deberían dividirse en cambios pequeños.

Cada cambio debe ser:

- fácil de entender;
- fácil de probar;
- fácil de revisar;
- fácil de revertir si fuera necesario.

## Uso de IA

Las herramientas de IA pueden ayudar en:

- análisis;
- diseño;
- generación de tests;
- implementación;
- refactorización;
- revisión de código.

Las decisiones importantes de arquitectura y comportamiento del sistema deben mantenerse bajo revisión humana.

# SPEC-001 — Ratio deuda/ingreso

## Objetivo

Permitir que el usuario calcule qué porcentaje de su ingreso mensual está comprometido por deudas.

## Datos de entrada

- Ingreso mensual
- Tarjetas de crédito
- Préstamos personales
- Crédito vehicular
- Crédito hipotecario
- Otras deudas

## Regla de cálculo

```text
deuda_total =
tarjetas
+ préstamos personales
+ crédito vehicular
+ crédito hipotecario
+ otras deudas
```

```text
ratio_deuda_ingreso = deuda_total / ingreso_mensual
```

El resultado debe mostrarse también como porcentaje.

## Casos límite

- Si el ingreso mensual es `0`, no se calcula el ratio.
- Las deudas no pueden tener valores negativos.
- Si una categoría no tiene deuda, su valor será `0`.

## Criterios de aceptación

1. El sistema debe permitir ingresar un monto de ingreso mensual.
2. El sistema debe permitir ingresar un monto para cada categoría de deuda.
3. El sistema debe sumar correctamente todas las categorías de deuda.
4. El sistema debe calcular el ratio deuda/ingreso usando la fórmula definida.
5. El sistema debe mostrar el resultado como porcentaje.
6. Si el ingreso mensual es `0`, el sistema debe impedir el cálculo y mostrar un mensaje de validación.
7. El sistema no debe aceptar montos negativos.
8. Una categoría sin deuda debe considerarse con valor `0`.
9. El resultado debe calcularse con precisión suficiente para mostrar al menos dos decimales cuando sea necesario.

## Ejemplo

```text
Ingreso mensual: 5000

Tarjetas: 500
Préstamos personales: 400
Crédito vehicular: 300
Crédito hipotecario: 200
Otras deudas: 100

Deuda total: 1500

Ratio: 0.30
Porcentaje: 30%
```
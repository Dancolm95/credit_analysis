# Guía de estudio de la Fase 2

Esta guía está pensada para quien conoce servicios de backend y empieza a leer Dart y Flutter. El flujo de esta fase es código Dart puro: se prueba con `flutter test`, pero no depende de widgets.

## 1. Mapa del flujo

```text
ingreso + cinco deudas
        ↓
AnalyzeCreditUseCase.execute (application)
        ↓
DebtToIncomeCalculator.calculate (domain): valida y calcula porcentaje
        ↓
CreditRiskClassifier.classify (domain): elige categoría
        ↓
CreditAnalysisResult (domain): guarda ambos valores
```

Piensa en el caso de uso como el coordinador de una cocina: entrega ingredientes al calculador, pasa el porcentaje al clasificador y coloca ambas respuestas en un recipiente. Las recetas matemáticas permanecen en los servicios de dominio.

## 2. Responsabilidad de cada clase

| Clase | Responsabilidad concreta |
| --- | --- |
| `DebtToIncomeCalculator` | Comprueba ingreso y deudas, suma las cinco categorías y calcula `(deudaTotal / ingresoMensual) * 100`. Lanza `ArgumentError` con los mensajes existentes ante montos inválidos. |
| `CreditRiskClassifier` | Traduce un porcentaje no negativo a `Bajo`, `Moderado`, `Alto` o `Muy alto` según SPEC-002. |
| `AnalyzeCreditUseCase` | Ejecuta los pasos en orden y devuelve el resultado. No redefine la fórmula ni los umbrales. |
| `CreditAnalysisResult` | Transporta `percentage` y `category` juntos como salida del caso de uso. |
| `CreditAnalysisResultFormatter` | Convierte porcentaje y categoría en texto para mostrar: `Porcentaje de deuda: 35.0%` y `Categoría: Moderado`. No participa en el cálculo. |

`CreditAnalysis` es otra entidad, usada por `SaveCreditAnalysis` para un posible guardado. No es la salida de esta fase. `main.dart` todavía muestra la pantalla de contador de Flutter y no llama al caso de uso.

## 3. Domain y application

**Domain** contiene conocimientos del negocio que seguirían siendo útiles sin Flutter: la fórmula, los límites de clasificación y la forma del resultado. **Application** describe una operación del sistema: «analizar estos datos». Es parecido a un endpoint de backend que coordina servicios, mientras que las reglas viven en módulos independientes.

La dirección de dependencia es `application → domain`. El dominio no importa el caso de uso ni widgets. Por eso se puede probar el cálculo directamente y, aparte, comprobar la coordinación completa.

## 4. Leer el código real

El constructor recibe los colaboradores desde fuera:

```dart
AnalyzeCreditUseCase({required this.calculator, required this.classifier});
```

`required` obliga a proporcionarlos. En una prueba se compone el objeto así:

```dart
final useCase = AnalyzeCreditUseCase(
  calculator: DebtToIncomeCalculator(),
  classifier: CreditRiskClassifier(),
);
```

Dentro de `execute`, el valor calculado se pasa al clasificador y ambos datos forman la salida:

```dart
final category = classifier.classify(percentage);
return CreditAnalysisResult(percentage: percentage, category: category);
```

Ejemplo concreto: ingreso `4000`, deudas `300 + 400 + 200 + 200 + 100 = 1200`. El porcentaje es `1200 / 4000 * 100 = 30.0`; la categoría es `Bajo`. Si las deudas suman cero, el resultado es `0.0` y `Bajo`.

La **inyección de dependencias** significa que quien crea el caso de uso le entrega el calculador y el clasificador. Se parece a pasar un cliente de base de datos a un servicio de backend en su constructor. Aquí permite construir el flujo explícitamente y sustituir colaboradores en pruebas futuras si hace falta. No requiere un contenedor ni un paquete adicional.

## 5. Reglas, especificaciones y pruebas

- **SPEC-001** define cinco deudas, la fórmula, ingreso cero, deudas negativas y decimales. El calculador tiene pruebas directas; la prueba del caso de uso comprueba que esos datos recorren el flujo completo.
- **SPEC-002** define `≤30`, `>30–≤40`, `>40–≤50` y `>50`. Las pruebas del clasificador incluyen los límites exactos y `30.000001`, `40.000001`, `50.000001`. Esos valores detectan errores como usar `<` donde corresponde `<=`.
- **SPEC-003** pide porcentaje y categoría. `CreditAnalysisResult` guarda ambos y el formateador añade `%` al texto. La prueba del caso de uso verifica tipo y campos; la del formateador verifica el texto.

No se redondea el porcentaje antes de clasificar: redondear `30.000001` a `30.00` cambiaría incorrectamente su categoría. El número y su representación para pantalla son responsabilidades distintas.

## 6. SOLID aplicado con precisión

- **Responsabilidad única (SRP):** calculador, clasificador, coordinador y formateador hacen trabajos distintos. Es el principio más visible aquí.
- **Inversión de dependencias (DIP):** la entrega de colaboradores por constructor reduce el acoplamiento a su creación. Aún se depende de clases concretas, por lo que no se aplica DIP en su forma fuerte de depender de abstracciones. No se introdujeron interfaces solo para afirmarlo.
- **Abierto/cerrado (OCP):** no hay una extensión diseñada para nuevas políticas; cambiar los umbrales requeriría modificar el clasificador y sus pruebas. No se considera demostrado.
- **Sustitución de Liskov (LSP):** no hay jerarquías relevantes que sustituir; no aplica de forma observable.
- **Segregación de interfaces (ISP):** no se definieron interfaces grandes ni pequeñas; tampoco aplica de forma observable.

La simplicidad también es una decisión de diseño: agregar interfaces, factories o un contenedor ahora aumentaría archivos sin resolver un problema presente.

## 7. Errores encontrados y corrección

El archivo `analyze_credi_use_case.dart` tenía el nombre truncado, `DebtIncomeCalculator` no coincidía con la clase real `DebtToIncomeCalculator`, y la prueba decía `DebToIncomeCalculator` y no importaba las clases usadas. El analizador señaló cinco errores. Se renombró el archivo, se usó el nombre real del servicio, se añadieron imports y se implementó `execute`. Las pruebas y el análisis estático pasaron después.

Para repetir la verificación desde la raíz:

```bash
flutter pub get
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
```

## 8. Ejercicios prácticos

Intenta resolverlos antes de abrir las soluciones. No es necesario cambiar reglas de negocio para completar los primeros cuatro.

1. **Trazar un cálculo.** Con ingreso `5000` y deudas `500, 400, 300, 200, 100`, calcula a mano deuda total, porcentaje y categoría. *Pista:* usa SPEC-001 y luego SPEC-002.
2. **Encontrar un límite.** Predice las categorías de `40.0` y `40.000001`. *Pista:* mira el orden de las condiciones `<=` en el clasificador.
3. **Seguir un error.** ¿Qué ocurre si `vehicleLoan` vale `-10`? Indica qué clase detecta el problema y qué recibe quien llama a `execute`. *Pista:* el caso de uso no tiene `try/catch`.
4. **Añadir una prueba.** Escribe una prueba del caso de uso con ingreso `2000` y solo `otherDebts: 900`. ¿Qué campos esperas? *Pista:* usa el estilo `analyze(...)` de la prueba existente.
5. **Diseñar un cambio.** Supón que una futura especificación pide que `50%` sea `Muy alto`. Indica qué especificación, código y pruebas modificarías, y qué pruebas existentes cambiarían. *Pista:* separa regla nueva de presentación; no implementes el cambio sin aprobación de la especificación.

## 9. Soluciones para consultar después

1. La deuda total es `1500`; `1500 / 5000 * 100 = 30.0`; la categoría es `Bajo` porque 30 está incluido en el primer rango.
2. `40.0` es `Moderado`; `40.000001` es `Alto`. La segunda condición acepta `<= 40` y la siguiente `<= 50`.
3. `DebtToIncomeCalculator.calculate` lanza `ArgumentError('Las deudas no pueden ser negativas.')`. `execute` deja que ese error llegue a quien lo llamó; el clasificador no se ejecuta.
4. Porcentaje `45.0` y categoría `Alto`. Una prueba posible es: `final result = analyze(monthlyIncome: 2000, otherDebts: 900); expect(result.percentage, 45.0); expect(result.category, 'Alto');`.
5. Primero se actualizaría SPEC-002. Luego `CreditRiskClassifier` cambiaría su comparación alrededor de 50 y se ajustarían las pruebas de `50.0` y de los valores cercanos; las pruebas del caso de uso seguirían verificando que utiliza el clasificador. `CreditAnalysisResult` y el formateador no necesitan cambiar.

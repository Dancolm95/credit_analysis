
import 'package:flutter_test/flutter_test.dart';

// Agregaremos los imports de nuestras clases.

void main() {
  test(
    'debe analizar ingresos y deudas correctamente',
    () {
      // ARRANGE: preparar los datos
      //Dependencias
      final calculator = DebToIncomeCalculator();
      final classifier = CreditRiskClassifier();

      //Caso de uso
      final useCase = AnalyzeCreditUseCase(
        calculator: calculator,
        classifier: classifier,
      );

      // ACT: ejecutar el análisis
      final result = useCase.execute(
        monthlyIncome: 4000.0,
        creditCards: 300.0,
        personalLoans: 400.0,
        vehicleLoan: 200.0,
        mortgage: 200.0,
        otherDebts: 100.0,
      );

      // ASSERT: verificar el resultado
      expect(result.percentage, 30.0);
      expect(result.category, 'Bajo');
    },
  );
}

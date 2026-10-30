import 'package:credit_analysis_app/application/use_cases/analyze_credit_use_case.dart';
import 'package:credit_analysis_app/domain/entities/credit_analysis_result.dart';
import 'package:credit_analysis_app/domain/services/credit_risk_classifier.dart';
import 'package:credit_analysis_app/domain/services/debt_to_income_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AnalyzeCreditUseCase useCase;

  setUp(() {
    useCase = AnalyzeCreditUseCase(
      calculator: DebtToIncomeCalculator(),
      classifier: CreditRiskClassifier(),
    );
  });

  CreditAnalysisResult analyze({
    double monthlyIncome = 4000,
    double creditCards = 0,
    double personalLoans = 0,
    double vehicleLoan = 0,
    double mortgage = 0,
    double otherDebts = 0,
  }) => useCase.execute(
    monthlyIncome: monthlyIncome,
    creditCards: creditCards,
    personalLoans: personalLoans,
    vehicleLoan: vehicleLoan,
    mortgage: mortgage,
    otherDebts: otherDebts,
  );

  test('suma las cinco deudas y construye el resultado clasificado', () {
    final result = analyze(
      creditCards: 300,
      personalLoans: 400,
      vehicleLoan: 200,
      mortgage: 200,
      otherDebts: 100,
    );

    expect(result, isA<CreditAnalysisResult>());
    expect(result.percentage, 30.0);
    expect(result.category, 'Bajo');
  });

  test('devuelve 0% y Bajo si no hay deudas', () {
    final result = analyze();

    expect(result.percentage, 0.0);
    expect(result.category, 'Bajo');
  });

  test('conserva decimales y clasifica el porcentaje calculado', () {
    final result = analyze(monthlyIncome: 3000, creditCards: 1000);

    expect(result.percentage, closeTo(33.333333, 0.000001));
    expect(result.category, 'Moderado');
  });

  for (final income in [0.0, -1.0]) {
    test('rechaza ingreso mensual $income', () {
      expect(
        () => analyze(monthlyIncome: income),
        throwsA(
          isA<ArgumentError>().having(
            (error) => error.message,
            'message',
            'El ingreso mensual debe ser mayor que cero.',
          ),
        ),
      );
    });
  }

  test('rechaza deudas negativas con el mensaje del calculador', () {
    expect(
      () => analyze(mortgage: -1),
      throwsA(
        isA<ArgumentError>().having(
          (error) => error.message,
          'message',
          'Las deudas no pueden ser negativas.',
        ),
      ),
    );
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:credit_analysis_app/domain/services/debt_to_income_calculator.dart';

void main() {
  test('calcula 30% cuando el ingreso es 5000 y la deuda total es 1500', () {
    final calculator = DebtToIncomeCalculator();

    final result = calculator.calculate(
      monthlyIncome: 5000,
      creditCards: 500,
      personalLoans: 400,
      vehicleLoan: 300,
      mortgage: 200,
      otherDebts: 100,
    );

    expect(result, 30.0);
  });

  test('devuelve 0% cuando no existen deudas', () {
    final calculator = DebtToIncomeCalculator();

    final result = calculator.calculate(
      monthlyIncome: 5000,
      creditCards: 0,
      personalLoans: 0,
      vehicleLoan: 0,
      mortgage: 0,
      otherDebts: 0,
    );

    expect(result, 0.0);
  });

  test('lanza error cuando el ingreso mensual es 0', () {
    final calculator = DebtToIncomeCalculator();

    expect(
      () => calculator.calculate(
        monthlyIncome: 0,
        creditCards: 500,
        personalLoans: 0,
        vehicleLoan: 0,
        mortgage: 0,
        otherDebts: 0,
      ),
      throwsArgumentError,
    );
  });
  test('lanza error cuando alguna deuda es negativa', () {
    final calculator = DebtToIncomeCalculator();

    expect(
      () => calculator.calculate(
        monthlyIncome: 5000,
        creditCards: -100,
        personalLoans: 0,
        vehicleLoan: 0,
        mortgage: 0,
        otherDebts: 0,
      ),
      throwsArgumentError,
    );
  });
  test('calcula correctamente porcentajes con decimales', () {
    final calculator = DebtToIncomeCalculator();

    final result = calculator.calculate(
      monthlyIncome: 3000,
      creditCards: 1000,
      personalLoans: 0,
      vehicleLoan: 0,
      mortgage: 0,
      otherDebts: 0,
    );

    expect(result, closeTo(33.33, 0.01));
  });
}

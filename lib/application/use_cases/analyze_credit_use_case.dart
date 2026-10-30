import '../../domain/entities/credit_analysis_result.dart';
import '../../domain/services/credit_risk_classifier.dart';
import '../../domain/services/debt_to_income_calculator.dart';

class AnalyzeCreditUseCase {
  final DebtToIncomeCalculator calculator;
  final CreditRiskClassifier classifier;

  AnalyzeCreditUseCase({required this.calculator, required this.classifier});

  CreditAnalysisResult execute({
    required double monthlyIncome,
    required double creditCards,
    required double personalLoans,
    required double vehicleLoan,
    required double mortgage,
    required double otherDebts,
  }) {
    final percentage = calculator.calculate(
      monthlyIncome: monthlyIncome,
      creditCards: creditCards,
      personalLoans: personalLoans,
      vehicleLoan: vehicleLoan,
      mortgage: mortgage,
      otherDebts: otherDebts,
    );
    final category = classifier.classify(percentage);

    return CreditAnalysisResult(percentage: percentage, category: category);
  }
}

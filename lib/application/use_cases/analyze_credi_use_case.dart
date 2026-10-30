class AnalyzeCreditUseCase {
  final DebtIncomeCalculator calculator;
  final CreditRiskClassifier classifier;

  AnalyzeCreditUseCase({
    required this.calculator,
    required this.classifier,
  });
}
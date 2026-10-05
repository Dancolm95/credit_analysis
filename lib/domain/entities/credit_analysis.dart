class CreditAnalysis {
  final double monthlyIncome;
  final double creditCards;
  final double personalLoans;
  final double vehicleLoan;
  final double mortgage;
  final double otherDebts;
  final double totalDebt;
  final double percentage;
  final String category;
  final DateTime createdAt;

  CreditAnalysis({
    required this.monthlyIncome,
    required this.creditCards,
    required this.personalLoans,
    required this.vehicleLoan,
    required this.mortgage,
    required this.otherDebts,
    required this.totalDebt,
    required this.percentage,
    required this.category,
    required this.createdAt,
  });
}

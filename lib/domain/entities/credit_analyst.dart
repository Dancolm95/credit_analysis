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
}

CreditAnalysis(
  this.monthlyIncome,
  this.creditCards,
  this.personalLoans, 
  this.vehicleLoan, 
  this.mortgage, 
  this.otherDebts, 
  this.totalDebt, 
  this.percentage, 
  this.category, 
  this.createdAt);
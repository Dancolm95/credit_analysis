class DebtToIncomeCalculator {
  double calculate({
    required double monthlyIncome,
    required double creditCards,
    required double personalLoans,
    required double vehicleLoan,
    required double mortgage,
    required double otherDebts,
  }) {
    if (monthlyIncome <= 0) {
      throw ArgumentError('El ingreso mensual debe ser mayor que cero.');
    }
    if (creditCards < 0 ||
        personalLoans < 0 ||
        vehicleLoan < 0 ||
        mortgage < 0 ||
        otherDebts < 0) {
      throw ArgumentError('Las deudas no pueden ser negativas.');
    }
    final totalDebt =
        creditCards +
        personalLoans +
        vehicleLoan +
        mortgage +
        otherDebts;

    return (totalDebt / monthlyIncome) * 100;
  }
}
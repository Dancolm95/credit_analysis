class CreditAnalysisResultFormatter {
  String format({required double percentage, required String category}) {
    return 'Porcentaje de deuda: $percentage%\nCategoría: $category';
  }
}

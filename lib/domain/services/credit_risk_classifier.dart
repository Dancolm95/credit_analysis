class CreditRiskClassifier {
  String classify(double percentage) {
    if (percentage < 0) {
      throw ArgumentError('El porcentaje no puede ser negativo.');
    }

    if (percentage <= 30) {
      return 'Bajo';
    }
    if (percentage <= 40) {
      return 'Moderado';
    }
    if (percentage <= 50) {
      return 'Alto';
    }
    return 'Muy alto';
  }
}

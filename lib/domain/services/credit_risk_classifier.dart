class CreditRiskClassifier {
  String classify(double percentage) {
    if(percentage < 0) {
      throw ArgumentError('El porcentaje no puede ser negativo.');
    }

    if (percentage <= 30) {
      return 'Bajo';
    }
    if (percentage <= 35) {
      return 'Moderado';
    }
    if (percentage <= 45) {
      return 'Alto';
    }
    return 'Muy alto';

    throw UnimplementedError();
  }
  
}
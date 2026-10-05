import 'package:flutter_test/flutter_test.dart';
import 'package:credit_analysis_app/domain/services/credit_risk_classifier.dart';

void main() {
  test('clasifica 30% como riesgo bajo', () {
    final classifier = CreditRiskClassifier();

    final result = classifier.classify(30.0);

    expect(result, 'Bajo');
  });
  test('clasifica 35% como riesgo moderado', () {
    final classifier = CreditRiskClassifier();

    final result = classifier.classify(35.0);

    expect(result, 'Moderado');
  });

  test('clasifica 40% como riesgo moderado', () {
    final classifier = CreditRiskClassifier();

    final result = classifier.classify(40.0);

    expect(result, 'Moderado');
  });

  test('clasifica 45% como riesgo alto', () {
    final classifier = CreditRiskClassifier();
    final result = classifier.classify(45.0);
    expect(result, 'Alto');
  });
  test('clasifica 50% como riesgo alto', () {
    final classifier = CreditRiskClassifier();

    final result = classifier.classify(50.0);

    expect(result, 'Alto');
  });
  test('clasifica 60% como riesgo muy alto', () {
    final classifier = CreditRiskClassifier();

    final result = classifier.classify(60.0);

    expect(result, 'Muy alto');
  });
  test('lanza error cuando el porcentaje es negativo', () {
    final classifier = CreditRiskClassifier();

    expect(() => classifier.classify(-10), throwsArgumentError);
  });
}

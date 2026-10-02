import 'package:flutter_test/flutter_test.dart';
import 'package:credit_analysis_app/domain/services/credit_analysis_result_formatter.dart';

void main() {
  test('formatea porcentaje y categoria', () {
    final formatter = CreditAnalysisResultFormatter();

    final result = formatter.format(
      percentage: 35.0,
      category: 'Moderado',
    );

    expect(
      result,
      'Porcentaje de deuda: 35.0%\nCategoría: Moderado',
    );
  });
}
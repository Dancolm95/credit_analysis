import 'package:flutter_test/flutter_test.dart';
import 'package:credit_analysis_app/application/use_cases/save_credit_analysis.dart';
import 'package:credit_analysis_app/domain/entities/credit_analysis.dart';
import 'package:credit_analysis_app/domain/repositories/credit_analysis_repository.dart';

class FakeCreditAnalysisRepository implements CreditAnalysisRepository {
  CreditAnalysis? savedAnalysis;

  @override
  Future<void> save(CreditAnalysis analysis) async {
    savedAnalysis = analysis;
  }
}

void main() {
  test('guarda el analisis usando el repositorio', () async {
    final repository = FakeCreditAnalysisRepository();
    final useCase = SaveCreditAnalysis(repository: repository);

    final analysis = CreditAnalysis(
      monthlyIncome: 5000,
      creditCards: 500,
      personalLoans: 400,
      vehicleLoan: 300,
      mortgage: 200,
      otherDebts: 100,
      totalDebt: 1500,
      percentage: 30,
      category: 'Bajo',
      createdAt: DateTime(2026, 10, 2),
    );

    await useCase.execute(analysis);

    expect(repository.savedAnalysis, same(analysis));
  });
}

import '../../domain/entities/credit_analysis.dart';
import '../../domain/repositories/credit_analysis_repository.dart';

class SaveCreditAnalysis {
  final CreditAnalysisRepository repository;

  SaveCreditAnalysis({required this.repository});

  Future<void> execute(CreditAnalysis analysis) async {
    await repository.save(analysis);
  }
}
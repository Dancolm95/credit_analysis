import '../entities/credit_analysis.dart';

abstract class CreditAnalysisRepository {
  Future<void> save(CreditAnalysis analysis);
}

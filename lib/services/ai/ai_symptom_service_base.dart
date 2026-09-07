import '../../models/ai_symptom_parse_result.dart';

abstract class AISymptomServiceBase {
  Future<AISymptomParseResult> parseSymptoms({
    required String symptomText,
    required int age,
    required String gender,
  });
}
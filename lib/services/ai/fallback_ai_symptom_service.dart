import '../../models/ai_symptom_parse_result.dart';
import 'ai_symptom_service_base.dart';
import 'mock_ai_symptom_service.dart';
import 'remote_ai_symptom_service.dart';

class FallbackAISymptomService implements AISymptomServiceBase {
  final RemoteAISymptomService _remoteService = RemoteAISymptomService();
  final MockAISymptomService _mockService = MockAISymptomService();

  bool usedFallback = false;

  @override
  Future<AISymptomParseResult> parseSymptoms({
    required String symptomText,
    required int age,
    required String gender,
  }) async {
    usedFallback = false;

    try {
      return await _remoteService.parseSymptoms(
        symptomText: symptomText,
        age: age,
        gender: gender,
      );
    } catch (_) {
      usedFallback = true;

      return _mockService.parseSymptoms(
        symptomText: symptomText,
        age: age,
        gender: gender,
      );
    }
  }
}
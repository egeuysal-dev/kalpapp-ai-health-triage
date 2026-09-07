import 'ai_symptom_service_base.dart';
import 'fallback_ai_symptom_service.dart';
import 'mock_ai_symptom_service.dart';
import 'remote_ai_symptom_service.dart';

enum AIServiceMode {
  mock,
  remote,
  fallback,
}

class AIServiceFactory {
  static const AIServiceMode currentMode = AIServiceMode.fallback;

  static AISymptomServiceBase create() {
    switch (currentMode) {
      case AIServiceMode.remote:
        return RemoteAISymptomService();
      case AIServiceMode.fallback:
        return FallbackAISymptomService();
      case AIServiceMode.mock:
        return MockAISymptomService();
    }
  }
}
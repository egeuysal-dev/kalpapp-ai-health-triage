import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/ai_symptom_parse_result.dart';
import 'ai_symptom_service_base.dart';

class RemoteAISymptomService implements AISymptomServiceBase {
  static const String baseUrl = 'http://192.168.1.5:3000';

  @override
  Future<AISymptomParseResult> parseSymptoms({
    required String symptomText,
    required int age,
    required String gender,
  }) async {
    final uri = Uri.parse('$baseUrl/api/ai/parse-symptoms');

    try {
      final response = await http
          .post(
            uri,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'symptomText': symptomText,
              'age': age,
              'gender': gender,
            }),
          )
          .timeout(const Duration(seconds: 8));

      if (response.statusCode != 200) {
        throw Exception(
          'Backend hatası: ${response.statusCode} ${response.body}',
        );
      }

      final Map<String, dynamic> data = jsonDecode(response.body);

      return AISymptomParseResult(
        chestPain: data['chestPain'] ?? false,
        painRadiation: data['painRadiation'] ?? false,
        shortnessOfBreath: data['shortnessOfBreath'] ?? false,
        coldSweating: data['coldSweating'] ?? false,
        nausea: data['nausea'] ?? false,
        dizziness: data['dizziness'] ?? false,
        faintingFeeling: data['faintingFeeling'] ?? false,
        durationMinutesEstimate: data['durationMinutesEstimate'] ?? 5,
        painSeverityEstimate: data['painSeverityEstimate'] ?? 4,
        summary: data['summary'] ?? '',
      );
    } on TimeoutException {
      throw Exception('AI servisine ulaşılamadı. İstek zaman aşımına uğradı.');
    } catch (e) {
      throw Exception('AI servisine bağlanılamadı: $e');
    }
  }
}
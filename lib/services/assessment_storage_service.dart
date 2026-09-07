import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/assessment_result.dart';

class AssessmentStorageService {
  static const String _assessmentKey = 'saved_assessments';

  static Future<void> saveAssessment(AssessmentResult result) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = await loadAssessments();

    final updated = [result, ...existing];
    final encoded = updated.map((e) => e.toMap()).toList();

    await prefs.setString(_assessmentKey, jsonEncode(encoded));
  }

  static Future<List<AssessmentResult>> loadAssessments() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_assessmentKey);

    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded
        .map((item) => AssessmentResult.fromMap(item as Map<String, dynamic>))
        .toList();
  }

  static Future<void> clearAssessments() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_assessmentKey);
  }
}
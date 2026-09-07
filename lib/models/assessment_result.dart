class AssessmentResult {
  final int riskScore;
  final String riskLevel;
  final String resultMessage;
  final String actionLevel;
  final String symptomSummary;
  final String emergencyPhone;
  final List<String> riskReasons;
  final String analysisSource;
  final String createdAt;

  const AssessmentResult({
    required this.riskScore,
    required this.riskLevel,
    required this.resultMessage,
    required this.actionLevel,
    required this.symptomSummary,
    this.emergencyPhone = '',
    required this.riskReasons,
    required this.analysisSource,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'riskScore': riskScore,
      'riskLevel': riskLevel,
      'resultMessage': resultMessage,
      'actionLevel': actionLevel,
      'symptomSummary': symptomSummary,
      'emergencyPhone': emergencyPhone,
      'riskReasons': riskReasons,
      'analysisSource': analysisSource,
      'createdAt': createdAt,
    };
  }

  factory AssessmentResult.fromMap(Map<String, dynamic> map) {
    return AssessmentResult(
      riskScore: map['riskScore'] ?? 0,
      riskLevel: map['riskLevel'] ?? '',
      resultMessage: map['resultMessage'] ?? '',
      actionLevel: map['actionLevel'] ?? '',
      symptomSummary: map['symptomSummary'] ?? '',
      emergencyPhone: map['emergencyPhone'] ?? '',
      riskReasons: List<String>.from(map['riskReasons'] ?? []),
      analysisSource: map['analysisSource'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }
}
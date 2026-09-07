class RiskEvaluationResult {
  final int score;
  final String riskLevel;
  final String resultMessage;
  final String actionLevel;
  final List<String> reasons;

  const RiskEvaluationResult({
    required this.score,
    required this.riskLevel,
    required this.resultMessage,
    required this.actionLevel,
    required this.reasons,
  });
}
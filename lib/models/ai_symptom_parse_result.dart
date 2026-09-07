class AISymptomParseResult {
  final bool chestPain;
  final bool painRadiation;
  final bool shortnessOfBreath;
  final bool coldSweating;
  final bool nausea;
  final bool dizziness;
  final bool faintingFeeling;
  final int durationMinutesEstimate;
  final int painSeverityEstimate;
  final String summary;

  const AISymptomParseResult({
    required this.chestPain,
    required this.painRadiation,
    required this.shortnessOfBreath,
    required this.coldSweating,
    required this.nausea,
    required this.dizziness,
    required this.faintingFeeling,
    required this.durationMinutesEstimate,
    required this.painSeverityEstimate,
    required this.summary,
  });
}
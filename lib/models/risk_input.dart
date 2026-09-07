import 'user_profile.dart';

class RiskInput {
  final UserProfile profile;
  final bool chestPain;
  final bool painRadiation;
  final bool shortnessOfBreath;
  final bool coldSweating;
  final bool nausea;
  final bool dizziness;
  final bool faintingFeeling;
  final int symptomDurationMinutes;
  final int painSeverity;
  final String analysisSource;

  const RiskInput({
    required this.profile,
    required this.chestPain,
    required this.painRadiation,
    required this.shortnessOfBreath,
    required this.coldSweating,
    required this.nausea,
    required this.dizziness,
    required this.faintingFeeling,
    required this.symptomDurationMinutes,
    required this.painSeverity,
    required this.analysisSource,
  });
}
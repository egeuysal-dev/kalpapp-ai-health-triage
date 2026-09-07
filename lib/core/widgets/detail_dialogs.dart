import 'package:flutter/material.dart';

import '../../models/assessment_result.dart';
import '../../models/user_profile.dart';
import '../localization/app_strings.dart';

Future<void> showAssessmentDetailDialog(
  BuildContext context,
  AssessmentResult result,
) async {
  final t = AppStrings.of(context);
  final color = _assessmentColor(result.riskLevel);

  await showDialog(
    context: context,
    builder: (_) => _ModernInfoDialog(
      accentColor: color,
      icon: Icons.assignment_turned_in_rounded,
      title: t.riskLevelText(result.riskLevel),
      subtitle: t.riskScoreValue(result.riskScore),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoSection(
            title: t.generalInformation,
            child: Column(
              children: [
                _InfoRow(
                  label: t.riskScore,
                  value: '${result.riskScore}',
                ),
                _InfoRow(
                  label: t.actionLevel,
                  value: result.actionLevel.isEmpty
                      ? t.notSpecified
                      : t.actionLevelText(result.actionLevel),
                ),
                _InfoRow(
                  label: t.analysisSourcePrefix,
                  value: result.analysisSource.isEmpty
                      ? t.notSpecified
                      : t.analysisSourceDisplay(result.analysisSource),
                ),
                _InfoRow(
                  label: t.dateLabel,
                  value: result.createdAt,
                  isLast: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _InfoSection(
            title: t.symptomSummaryTitle,
            child: Text(
              result.symptomSummary.isEmpty
                  ? t.noSymptomSummary
                  : result.symptomSummary,
              style: const TextStyle(
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 14),
          _InfoSection(
            title: t.riskReasonsTitle,
            child: result.riskReasons.isEmpty
                ? Text(
                    t.noRiskReason,
                    style: const TextStyle(
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  )
                : Column(
                    children: result.riskReasons
                        .map(
                          (reason) => _ReasonTile(
                            text: t.riskReasonText(reason),
                          ),
                        )
                        .toList(),
                  ),
          ),
          const SizedBox(height: 14),
          _InfoSection(
            title: t.resultMessageTitle,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: color.withValues(alpha: 0.20),
                ),
              ),
              child: Text(
                result.resultMessage.isEmpty
                    ? t.noResultMessage
                    : t.resultMessageText(result.resultMessage),
                style: const TextStyle(
                  height: 1.5,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Future<void> showProfileSummaryDialog(
  BuildContext context,
  UserProfile profile,
) async {
  final t = AppStrings.of(context);

  await showDialog(
    context: context,
    builder: (_) => _ModernInfoDialog(
      accentColor: const Color(0xFF3949AB),
      icon: Icons.person_rounded,
      title: t.profileSummary,
      subtitle: profile.fullName,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoSection(
            title: t.basicInformation,
            child: Column(
              children: [
                _InfoRow(
                  label: t.fullNameLabel,
                  value: profile.fullName,
                ),
                _InfoRow(
                  label: t.ageLabel,
                  value: '${profile.age}',
                ),
                _InfoRow(
                  label: t.genderLabel,
                  value: t.genderText(profile.gender),
                  isLast: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _InfoSection(
            title: t.healthStatus,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _StatusChip(
                  label: t.riskFactorLabel('Önceki Kalp Krizi'),
                  value: profile.previousHeartAttack,
                ),
                _StatusChip(
                  label: t.riskFactorLabel('Kalp Hastalığı'),
                  value: profile.heartDisease,
                ),
                _StatusChip(
                  label: t.riskFactorLabel('Hipertansiyon'),
                  value: profile.hypertension,
                ),
                _StatusChip(
                  label: t.riskFactorLabel('Diyabet'),
                  value: profile.diabetes,
                ),
                _StatusChip(
                  label: t.riskFactorLabel('Yüksek Kolesterol'),
                  value: profile.highCholesterol,
                ),
                _StatusChip(
                  label: t.riskFactorLabel('Sigara'),
                  value: profile.smoking,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _InfoSection(
            title: t.medicationInformation,
            child: Text(
              profile.medications.isEmpty ? t.notSpecified : profile.medications,
              style: const TextStyle(
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 14),
          _InfoSection(
            title: t.emergencyContactCommunication,
            child: Column(
              children: [
                _InfoRow(
                  label: t.emergencyContact,
                  value: profile.emergencyContactName.isEmpty
                      ? t.notSpecified
                      : profile.emergencyContactName,
                ),
                _InfoRow(
                  label: t.phoneNumber,
                  value: profile.emergencyContactPhone.isEmpty
                      ? t.notSpecified
                      : profile.emergencyContactPhone,
                ),
                _InfoRow(
                  label: t.relationLabel,
                  value: profile.emergencyContactRelation.isEmpty
                      ? t.notSpecified
                      : profile.emergencyContactRelation,
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Future<void> showBraceletCriticalAlertDialog(
  BuildContext context, {
  required String personName,
  required int heartRate,
}) async {
  final t = AppStrings.of(context);

  await showDialog(
    context: context,
    builder: (_) => _ModernInfoDialog(
      accentColor: Colors.red,
      icon: Icons.warning_rounded,
      title: t.braceletCriticalAlertTitle,
      subtitle: t.criticalHeartRhythmSimulation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoSection(
            title: t.alertInformation,
            child: Column(
              children: [
                _InfoRow(
                  label: t.personLabel,
                  value: personName,
                ),
                _InfoRow(
                  label: t.alertType,
                  value: t.braceletStatusText('Kritik uyarı'),
                ),
                _InfoRow(
                  label: t.heartRate,
                  value: '$heartRate bpm',
                  isLast: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _InfoSection(
            title: t.description,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.red.withValues(alpha: 0.20),
                ),
              ),
              child: Text(
                t.criticalAlertSavedInfo,
                style: const TextStyle(
                  height: 1.5,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          _InfoSection(
            title: t.emergencyNote,
            child: Text(
              t.criticalRhythmEmergencyNote,
              style: const TextStyle(
                height: 1.5,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Color _assessmentColor(String level) {
  if (level == 'Kritik Risk') return Colors.red;
  if (level == 'Yüksek Risk') return Colors.orange;
  if (level == 'Orta Risk') return Colors.amber.shade700;

  return Colors.green;
}

class _ModernInfoDialog extends StatelessWidget {
  final Color accentColor;
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget child;

  const _ModernInfoDialog({
    required this.accentColor,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.82,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(28, 0, 0, 0),
              blurRadius: 24,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: child,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(t.commonClose),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _InfoSection({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE6E8EC),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1D1D1F),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isLast;

  const _InfoRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: isLast ? 0 : 10,
      ),
      margin: EdgeInsets.only(
        bottom: isLast ? 0 : 10,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : const BorderSide(
                  color: Color(0xFFE6E8EC),
                ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReasonTile extends StatelessWidget {
  final String text;

  const _ReasonTile({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE6E8EC),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.arrow_right_rounded,
            color: Colors.black54,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black87,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final bool value;

  const _StatusChip({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);

    final bgColor =
        value ? const Color(0xFFFFEBEE) : const Color(0xFFE8F5E9);

    final textColor =
        value ? const Color(0xFFC62828) : const Color(0xFF2E7D32);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: textColor.withValues(alpha: 0.18),
        ),
      ),
      child: Text(
        '$label: ${value ? t.yes : t.no}',
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w700,
          fontSize: 12.5,
        ),
      ),
    );
  }
}
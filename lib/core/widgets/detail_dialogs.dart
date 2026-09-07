import 'package:flutter/material.dart';
import '../../models/assessment_result.dart';
import '../../models/user_profile.dart';

Future<void> showAssessmentDetailDialog(
  BuildContext context,
  AssessmentResult result,
) async {
  final color = _assessmentColor(result.riskLevel);

  await showDialog(
    context: context,
    builder: (_) => _ModernInfoDialog(
      accentColor: color,
      icon: Icons.assignment_turned_in_rounded,
      title: result.riskLevel,
      subtitle: 'Risk skoru: ${result.riskScore}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoSection(
            title: 'Genel Bilgiler',
            child: Column(
              children: [
                _InfoRow(label: 'Risk Skoru', value: '${result.riskScore}'),
                _InfoRow(
                  label: 'Aksiyon Seviyesi',
                  value: result.actionLevel.isEmpty
                      ? 'Belirtilmedi'
                      : result.actionLevel,
                ),
                _InfoRow(
                  label: 'Analiz Kaynağı',
                  value: result.analysisSource.isEmpty
                      ? 'Belirtilmedi'
                      : result.analysisSource,
                ),
                _InfoRow(
                  label: 'Tarih',
                  value: result.createdAt,
                  isLast: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _InfoSection(
            title: 'Semptom Özeti',
            child: Text(
              result.symptomSummary.isEmpty
                  ? 'Semptom özeti bulunmuyor.'
                  : result.symptomSummary,
              style: const TextStyle(
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 14),
          _InfoSection(
            title: 'Risk Nedenleri',
            child: result.riskReasons.isEmpty
                ? const Text(
                    'Belirtilmedi.',
                    style: TextStyle(
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  )
                : Column(
                    children: result.riskReasons
                        .map(
                          (reason) => _ReasonTile(text: reason),
                        )
                        .toList(),
                  ),
          ),
          const SizedBox(height: 14),
          _InfoSection(
            title: 'Sonuç Mesajı',
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: color.withOpacity(0.20),
                ),
              ),
              child: Text(
                result.resultMessage.isEmpty
                    ? 'Sonuç mesajı bulunmuyor.'
                    : result.resultMessage,
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
  await showDialog(
    context: context,
    builder: (_) => _ModernInfoDialog(
      accentColor: const Color(0xFF3949AB),
      icon: Icons.person_rounded,
      title: 'Profil Özeti',
      subtitle: profile.fullName,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoSection(
            title: 'Temel Bilgiler',
            child: Column(
              children: [
                _InfoRow(label: 'Ad Soyad', value: profile.fullName),
                _InfoRow(label: 'Yaş', value: '${profile.age}'),
                _InfoRow(
                  label: 'Cinsiyet',
                  value: profile.gender,
                  isLast: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _InfoSection(
            title: 'Sağlık Durumu',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _StatusChip(
                  label: 'Önceki Kalp Krizi',
                  value: profile.previousHeartAttack,
                ),
                _StatusChip(
                  label: 'Kalp Hastalığı',
                  value: profile.heartDisease,
                ),
                _StatusChip(
                  label: 'Hipertansiyon',
                  value: profile.hypertension,
                ),
                _StatusChip(
                  label: 'Diyabet',
                  value: profile.diabetes,
                ),
                _StatusChip(
                  label: 'Yüksek Kolesterol',
                  value: profile.highCholesterol,
                ),
                _StatusChip(
                  label: 'Sigara',
                  value: profile.smoking,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _InfoSection(
            title: 'İlaç Bilgisi',
            child: Text(
              profile.medications.isEmpty
                  ? 'Belirtilmedi'
                  : profile.medications,
              style: const TextStyle(
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 14),
          _InfoSection(
            title: 'Acil Durum İletişimi',
            child: Column(
              children: [
                _InfoRow(
                  label: 'Acil Kişi',
                  value: profile.emergencyContactName.isEmpty
                      ? 'Belirtilmedi'
                      : profile.emergencyContactName,
                ),
                _InfoRow(
                  label: 'Telefon',
                  value: profile.emergencyContactPhone.isEmpty
                      ? 'Belirtilmedi'
                      : profile.emergencyContactPhone,
                ),
                _InfoRow(
                  label: 'Yakınlık',
                  value: profile.emergencyContactRelation.isEmpty
                      ? 'Belirtilmedi'
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
  await showDialog(
    context: context,
    builder: (_) => _ModernInfoDialog(
      accentColor: Colors.red,
      icon: Icons.warning_rounded,
      title: 'Bileklik Uyarısı',
      subtitle: 'Kritik kalp ritmi simülasyonu',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoSection(
            title: 'Uyarı Bilgisi',
            child: Column(
              children: [
                _InfoRow(
                  label: 'Kişi',
                  value: personName,
                ),
                _InfoRow(
                  label: 'Uyarı Tipi',
                  value: 'Kritik uyarı',
                ),
                _InfoRow(
                  label: 'Kalp Ritmi',
                  value: '$heartRate bpm',
                  isLast: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _InfoSection(
            title: 'Açıklama',
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.red.withOpacity(0.20),
                ),
              ),
              child: const Text(
                'Bu olay Bileklik Uyarı Geçmişi ekranına kaydedildi. Gerçek üründe bu durumda kullanıcıya anlık bildirim gönderilir ve takip edilen kişinin durumu kontrol edilir.',
                style: TextStyle(
                  height: 1.5,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          _InfoSection(
            title: 'Acil Durum Notu',
            child: const Text(
              'Kritik ritim uyarısı tek başına kesin tanı anlamına gelmez. Ancak bilinç kaybı, göğüs ağrısı, nefes darlığı veya ciddi kötüleşme varsa 112 aranmalıdır.',
              style: TextStyle(
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
                      color: Colors.white.withOpacity(0.18),
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
                  child: const Text('Kapat'),
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
          color: textColor.withOpacity(0.18),
        ),
      ),
      child: Text(
        '$label: ${value ? "Evet" : "Hayır"}',
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w700,
          fontSize: 12.5,
        ),
      ),
    );
  }
}
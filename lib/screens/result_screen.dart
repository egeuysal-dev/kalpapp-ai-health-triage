import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/assessment_result.dart';
import '../services/firestore_user_service.dart';

class ResultScreen extends StatefulWidget {
  final int riskScore;
  final String riskLevel;
  final String resultMessage;
  final String actionLevel;
  final String symptomSummary;
  final String emergencyPhone;
  final List<String> riskReasons;
  final String analysisSource;

  const ResultScreen({
    super.key,
    required this.riskScore,
    required this.riskLevel,
    required this.resultMessage,
    required this.actionLevel,
    required this.symptomSummary,
    required this.emergencyPhone,
    required this.riskReasons,
    required this.analysisSource,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _isSaving = false;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _saveResult();
  }

  Color _riskColor() {
    if (widget.riskLevel == 'Kritik Risk') return Colors.red;
    if (widget.riskLevel == 'Yüksek Risk') return Colors.orange;
    if (widget.riskLevel == 'Orta Risk') return Colors.amber.shade700;
    return Colors.green;
  }

  IconData _riskIcon() {
    if (widget.riskLevel == 'Kritik Risk') return Icons.warning_rounded;
    if (widget.riskLevel == 'Yüksek Risk') return Icons.priority_high_rounded;
    if (widget.riskLevel == 'Orta Risk') return Icons.info_outline;
    return Icons.check_circle_outline;
  }

  String _nowText() {
    return DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now());
  }

  Future<void> _saveResult() async {
    if (_isSaved || _isSaving) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final result = AssessmentResult(
        riskScore: widget.riskScore,
        riskLevel: widget.riskLevel,
        resultMessage: widget.resultMessage,
        actionLevel: widget.actionLevel,
        symptomSummary: widget.symptomSummary,
        emergencyPhone: widget.emergencyPhone,
        riskReasons: widget.riskReasons,
        analysisSource: widget.analysisSource,
        createdAt: _nowText(),
      );

      await FirestoreUserService.saveAssessment(result);

      if (!mounted) return;

      setState(() {
        _isSaved = true;
        _isSaving = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sonuç kaydedilirken bir hata oluştu.'),
        ),
      );
    }
  }

  Future<void> _call112() async {
    final uri = Uri.parse('tel:112');

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              '112 araması başlatılamadı. Emülatörde bu normal olabilir.',
            ),
          ),
        );
      }
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Arama başlatılamadı. Gerçek telefonda tekrar deneyin.'),
        ),
      );
    }
  }

  Future<void> _callEmergencyContact() async {
    final phone = widget.emergencyPhone.trim();

    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Acil kişi telefonu kayıtlı değil.'),
        ),
      );
      return;
    }

    final uri = Uri.parse('tel:$phone');

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Acil kişi araması başlatılamadı.'),
          ),
        );
      }
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Acil kişi araması başlatılamadı.'),
        ),
      );
    }
  }

  Widget _buildHeaderResultCard() {
    final color = _riskColor();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color,
            color.withOpacity(0.72),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 86,
            height: 86,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(26),
            ),
            child: Icon(
              _riskIcon(),
              color: Colors.white,
              size: 48,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            widget.riskLevel,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.actionLevel.isEmpty
                ? 'Aksiyon seviyesi belirtilmedi'
                : widget.actionLevel,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.4,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.16),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              'Risk Skoru: ${widget.riskScore}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveStatusCard() {
    Color color;
    IconData icon;
    String text;

    if (_isSaving) {
      color = Colors.blueGrey;
      icon = Icons.sync;
      text = 'Sonuç kaydediliyor...';
    } else if (_isSaved) {
      color = Colors.green;
      icon = Icons.cloud_done_outlined;
      text = 'Sonuç geçmişe kaydedildi.';
    } else {
      color = Colors.orange;
      icon = Icons.cloud_off_outlined;
      text = 'Sonuç kaydedilemedi.';
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withOpacity(0.28),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(14, 0, 0, 0),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: _riskColor(),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Color(0xFF1D1D1F),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _buildMessageCard() {
    return _buildSectionCard(
      title: 'Sonuç Mesajı',
      icon: Icons.medical_information_outlined,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: _riskColor().withOpacity(0.08),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _riskColor().withOpacity(0.20),
          ),
        ),
        child: Text(
          widget.resultMessage.isEmpty
              ? 'Sonuç mesajı bulunmuyor.'
              : widget.resultMessage,
          style: const TextStyle(
            height: 1.5,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildScoreAndSourceCard() {
    return _buildSectionCard(
      title: 'Analiz Bilgileri',
      icon: Icons.analytics_outlined,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildMetricPill(
                  icon: Icons.speed,
                  label: 'Risk Skoru',
                  value: widget.riskScore.toString(),
                  color: _riskColor(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricPill(
                  icon: Icons.auto_awesome,
                  label: 'Analiz Kaynağı',
                  value: widget.analysisSource.isEmpty
                      ? 'Belirtilmedi'
                      : widget.analysisSource,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildMetricPill(
            icon: Icons.flag_outlined,
            label: 'Aksiyon Seviyesi',
            value: widget.actionLevel.isEmpty
                ? 'Belirtilmedi'
                : widget.actionLevel,
            color: Colors.deepPurple,
          ),
        ],
      ),
    );
  }

  Widget _buildMetricPill({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withOpacity(0.18),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 22,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black45,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomSummaryCard() {
    return _buildSectionCard(
      title: 'Semptom Özeti',
      icon: Icons.checklist_rounded,
      child: Text(
        widget.symptomSummary.isEmpty
            ? 'Semptom özeti bulunmuyor.'
            : widget.symptomSummary,
        style: const TextStyle(
          height: 1.5,
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildRiskReasonsCard() {
    return _buildSectionCard(
      title: 'Risk Nedenleri',
      icon: Icons.fact_check_outlined,
      child: widget.riskReasons.isEmpty
          ? const Text(
              'Risk nedeni belirtilmedi.',
              style: TextStyle(
                color: Colors.black54,
                height: 1.5,
              ),
            )
          : Column(
              children: widget.riskReasons
                  .map(
                    (reason) => _buildReasonTile(reason),
                  )
                  .toList(),
            ),
    );
  }

  Widget _buildReasonTile(String reason) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE6E8EC),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.arrow_right_rounded,
            color: _riskColor(),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              reason,
              style: const TextStyle(
                height: 1.45,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyActionsCard() {
    final hasEmergencyContact = widget.emergencyPhone.trim().isNotEmpty;

    return _buildSectionCard(
      title: 'Acil Durum İşlemleri',
      icon: Icons.emergency,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFFEBEE),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFFE53935).withOpacity(0.28),
              ),
            ),
            child: const Text(
              'Ciddi belirti varsa sonucu yorumlamakla vakit kaybetmeden 112 aranmalıdır. Bu uygulama tanı koymaz ve acil sağlık hizmetlerinin yerine geçmez.',
              style: TextStyle(
                color: Color(0xFF8A1C1C),
                height: 1.45,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _call112,
                  icon: const Icon(Icons.call),
                  label: const Text('112’yi Ara'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE53935),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: hasEmergencyContact ? _callEmergencyContact : null,
                  icon: const Icon(Icons.contact_phone_outlined),
                  label: const Text('Acil Kişi'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (hasEmergencyContact) ...[
            const SizedBox(height: 10),
            Text(
              'Acil kişi telefonu: ${widget.emergencyPhone}',
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 18, bottom: 24),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Geri Dön'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _saveResult,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Kaydet'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _riskColor(),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final showEmergencyActions =
        widget.riskLevel == 'Kritik Risk' || widget.riskLevel == 'Yüksek Risk';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text('Değerlendirme Sonucu'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildHeaderResultCard(),
            _buildSaveStatusCard(),
            _buildMessageCard(),
            _buildScoreAndSourceCard(),
            _buildSymptomSummaryCard(),
            _buildRiskReasonsCard(),
            if (showEmergencyActions) _buildEmergencyActionsCard(),
            _buildBottomActions(),
          ],
        ),
      ),
    );
  }
}
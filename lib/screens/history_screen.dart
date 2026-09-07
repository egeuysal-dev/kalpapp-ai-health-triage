import 'package:flutter/material.dart';
import '../core/widgets/detail_dialogs.dart';
import '../models/assessment_result.dart';
import '../services/firestore_user_service.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  Color _riskColor(String level) {
    if (level == 'Kritik Risk') return Colors.red;
    if (level == 'Yüksek Risk') return Colors.orange;
    if (level == 'Orta Risk') return Colors.amber.shade700;
    return Colors.green;
  }

  IconData _riskIcon(String level) {
    if (level == 'Kritik Risk') return Icons.warning_rounded;
    if (level == 'Yüksek Risk') return Icons.priority_high_rounded;
    if (level == 'Orta Risk') return Icons.info_outline;
    return Icons.check_circle_outline;
  }

  Future<void> _clearHistory(BuildContext context) async {
    await FirestoreUserService.clearAssessments();

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Geçmiş değerlendirmeler silindi.'),
      ),
    );
  }

  Future<void> _showClearConfirmDialog(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Geçmişi Sil'),
        content: const Text(
          'Tüm değerlendirme geçmişi silinsin mi?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Vazgeç'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sil'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _clearHistory(context);
    }
  }

  Widget _buildHistoryCard(
    BuildContext context,
    AssessmentResult item,
  ) {
    final color = _riskColor(item.riskLevel);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(14, 0, 0, 0),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: color.withOpacity(0.14),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            _riskIcon(item.riskLevel),
            color: color,
          ),
        ),
        title: Text(
          item.riskLevel,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            'Skor: ${item.riskScore}\n'
            'Aksiyon: ${item.actionLevel}\n'
            'Kaynak: ${item.analysisSource}\n'
            'Tarih: ${item.createdAt}',
            style: const TextStyle(height: 1.45),
          ),
        ),
        isThreeLine: true,
        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.black45,
        ),
        onTap: () async {
          await showAssessmentDetailDialog(context, item);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Container(
          padding: const EdgeInsets.all(24),
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
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.history_toggle_off,
                size: 64,
                color: Colors.black38,
              ),
              SizedBox(height: 16),
              Text(
                'Henüz kayıtlı değerlendirme yok.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Yeni bir değerlendirme yaptıktan sonra geçmiş kayıtların burada görünecek.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderInfoCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFF1976D2).withOpacity(0.25),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: Color(0xFF1976D2),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Bu ekranda önceki semptom değerlendirmeleri, risk skoru, aksiyon seviyesi ve analiz kaynağı ile birlikte listelenir.',
              style: TextStyle(
                color: Color(0xFF0D47A1),
                height: 1.45,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClearButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () => _showClearConfirmDialog(context),
          icon: const Icon(Icons.delete_outline),
          label: const Text('Tüm Geçmişi Sil'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.red,
            side: const BorderSide(color: Colors.red),
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text('Geçmiş Değerlendirmeler'),
        elevation: 0,
      ),
      body: StreamBuilder<List<AssessmentResult>>(
        stream: FirestoreUserService.assessmentsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Bir hata oluştu:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final assessments = snapshot.data ?? [];

          if (assessments.isEmpty) {
            return _buildEmptyState();
          }

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 8),
                  children: [
                    _buildHeaderInfoCard(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Column(
                        children: assessments
                            .map(
                              (item) => _buildHistoryCard(context, item),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              _buildClearButton(context),
            ],
          );
        },
      ),
    );
  }
}
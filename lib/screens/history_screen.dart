import 'package:flutter/material.dart';

import '../core/localization/app_strings.dart';
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
    final t = AppStrings.of(context);

    await FirestoreUserService.clearAssessments();

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(t.assessmentHistoryCleared),
      ),
    );
  }

  Future<void> _showClearConfirmDialog(BuildContext context) async {
    final t = AppStrings.of(context);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(t.clearHistoryDialogTitle),
        content: Text(t.clearHistoryDialogMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(t.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(t.commonDelete),
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
    final t = AppStrings.of(context);
    final color = _riskColor(item.riskLevel);

    final riskLevelText = t.riskLevelText(item.riskLevel);
    final actionText = item.actionLevel.isEmpty
        ? t.notSpecified
        : t.actionLevelText(item.actionLevel);
    final sourceText = item.analysisSource.isEmpty
        ? t.notSpecified
        : t.analysisSourceDisplay(item.analysisSource);

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
          color: color.withValues(alpha: 0.14),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            _riskIcon(item.riskLevel),
            color: color,
          ),
        ),
        title: Text(
          riskLevelText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            t.historyCardSubtitle(
              score: item.riskScore,
              action: actionText,
              source: sourceText,
              date: item.createdAt,
            ),
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

  Widget _buildEmptyState(BuildContext context) {
    final t = AppStrings.of(context);

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.history_toggle_off,
                size: 64,
                color: Colors.black38,
              ),
              const SizedBox(height: 16),
              Text(
                t.emptyHistoryTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                t.emptyHistoryMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
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

  Widget _buildHeaderInfoCard(BuildContext context) {
    final t = AppStrings.of(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFF1976D2).withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            color: Color(0xFF1976D2),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              t.historyInfoMessage,
              style: const TextStyle(
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
    final t = AppStrings.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () => _showClearConfirmDialog(context),
          icon: const Icon(Icons.delete_outline),
          label: Text(t.clearAllHistory),
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
    final t = AppStrings.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: Text(t.historyScreenTitle),
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
                  '${t.errorOccurredPrefix}:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final assessments = snapshot.data ?? [];

          if (assessments.isEmpty) {
            return _buildEmptyState(context);
          }

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 8),
                  children: [
                    _buildHeaderInfoCard(context),
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
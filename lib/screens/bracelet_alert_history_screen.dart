import 'package:flutter/material.dart';

import '../core/localization/app_strings.dart';
import '../models/bracelet_alert.dart';
import '../services/monitored_person_service.dart';

class BraceletAlertHistoryScreen extends StatelessWidget {
  const BraceletAlertHistoryScreen({super.key});

  Color _alertColor(String type) {
    if (type == 'Kritik uyarı') return Colors.red;
    if (type == 'Düşük kalp ritmi uyarısı') return Colors.orange;
    if (type == 'Yüksek kalp ritmi uyarısı') return Colors.deepOrange;

    return Colors.blueGrey;
  }

  IconData _alertIcon(String type) {
    if (type == 'Kritik uyarı') return Icons.warning_rounded;
    if (type == 'Düşük kalp ritmi uyarısı') return Icons.arrow_downward;
    if (type == 'Yüksek kalp ritmi uyarısı') return Icons.arrow_upward;

    return Icons.info_outline;
  }

  int _criticalCount(List<BraceletAlert> alerts) {
    return alerts.where((alert) => alert.alertType == 'Kritik uyarı').length;
  }

  int _lowCount(List<BraceletAlert> alerts) {
    return alerts
        .where((alert) => alert.alertType == 'Düşük kalp ritmi uyarısı')
        .length;
  }

  int _highCount(List<BraceletAlert> alerts) {
    return alerts
        .where((alert) => alert.alertType == 'Yüksek kalp ritmi uyarısı')
        .length;
  }

  Future<void> _clearAlerts(BuildContext context) async {
    final t = AppStrings.of(context);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(t.clearBraceletAlertDialogTitle),
        content: Text(t.clearBraceletAlertDialogMessage),
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

    if (confirm != true) return;

    await MonitoredPersonService.clearBraceletAlerts();

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(t.braceletAlertHistoryCleared),
      ),
    );
  }

  Widget _buildSummaryHeader(
    BuildContext context,
    List<BraceletAlert> alerts,
  ) {
    final t = AppStrings.of(context);

    final total = alerts.length;
    final critical = _criticalCount(alerts);
    final low = _lowCount(alerts);
    final high = _highCount(alerts);
    final latest = alerts.isNotEmpty ? alerts.first : null;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1976D2), Color(0xFF00ACC1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(34, 25, 118, 210),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.notifications_active_outlined,
                color: Colors.white,
                size: 34,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  t.braceletAlertSummary,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildSummaryBox(
                  label: t.totalAlerts,
                  value: total.toString(),
                  icon: Icons.list_alt,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildSummaryBox(
                  label: t.criticalAlertShort,
                  value: critical.toString(),
                  icon: Icons.warning_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildSummaryBox(
                  label: t.lowRhythmShort,
                  value: low.toString(),
                  icon: Icons.arrow_downward,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildSummaryBox(
                  label: t.highRhythmShort,
                  value: high.toString(),
                  icon: Icons.arrow_upward,
                ),
              ),
            ],
          ),
          if (latest != null) ...[
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                t.latestBraceletAlert(
                  personName: latest.personName,
                  alertType: latest.alertType,
                  heartRate: latest.heartRate,
                ),
                style: const TextStyle(
                  color: Colors.white,
                  height: 1.35,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryBox({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 23,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    final t = AppStrings.of(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
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
              t.braceletAlertInfoMessage,
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

  Widget _buildAlertCard(
    BuildContext context,
    BraceletAlert alert,
  ) {
    final t = AppStrings.of(context);
    final color = _alertColor(alert.alertType);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: color.withValues(alpha: 0.22),
        ),
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
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  _alertIcon(alert.alertType),
                  color: color,
                  size: 32,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.shortBraceletAlertTitle(alert.alertType),
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      alert.personName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Color(0xFF1D1D1F),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      alert.createdAtText,
                      style: const TextStyle(
                        color: Colors.black45,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: color.withValues(alpha: 0.22),
                  ),
                ),
                child: Text(
                  t.braceletAlertBadgeText(alert.alertType),
                  style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildMetricPill(
                  icon: Icons.favorite,
                  label: t.heartRate,
                  value: '${alert.heartRate} bpm',
                  color: color,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricPill(
                  icon: Icons.watch_outlined,
                  label: t.deviceId,
                  value: alert.deviceId,
                  color: const Color(0xFF1976D2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F8FA),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFFE6E8EC),
              ),
            ),
            child: Text(
              alert.message.isEmpty
                  ? t.braceletAlertMessageMissing
                  : t.braceletAlertMessageText(alert.message),
              style: const TextStyle(
                color: Colors.black87,
                height: 1.45,
                fontWeight: FontWeight.w500,
              ),
            ),
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 21,
          ),
          const SizedBox(width: 8),
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
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
                Icons.notifications_none,
                size: 66,
                color: Colors.black38,
              ),
              const SizedBox(height: 16),
              Text(
                t.braceletAlertEmptyTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                t.braceletAlertEmptyMessage,
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

  Widget _buildClearButton(BuildContext context) {
    final t = AppStrings.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () => _clearAlerts(context),
          icon: const Icon(Icons.delete_outline),
          label: Text(t.clearBraceletAlertHistory),
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
        title: Text(t.braceletAlertHistoryTitle),
      ),
      body: StreamBuilder<List<BraceletAlert>>(
        stream: MonitoredPersonService.braceletAlertsStream(),
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
                  '${t.braceletAlertLoadError}:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final alerts = snapshot.data ?? [];

          if (alerts.isEmpty) {
            return _buildEmptyState(context);
          }

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 8),
                  children: [
                    _buildSummaryHeader(context, alerts),
                    _buildInfoCard(context),
                    ...alerts.map(
                      (alert) => _buildAlertCard(context, alert),
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
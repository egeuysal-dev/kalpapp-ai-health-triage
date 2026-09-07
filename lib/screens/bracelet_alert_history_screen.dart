import 'package:flutter/material.dart';
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

  String _shortAlertTitle(String type) {
    if (type == 'Kritik uyarı') return 'Kritik';
    if (type == 'Düşük kalp ritmi uyarısı') return 'Düşük Ritim';
    if (type == 'Yüksek kalp ritmi uyarısı') return 'Yüksek Ritim';
    return type;
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
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Uyarı Geçmişini Sil'),
        content: const Text(
          'Tüm bileklik uyarı geçmişi silinsin mi?',
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

    if (confirm != true) return;

    await MonitoredPersonService.clearBraceletAlerts();

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Bileklik uyarı geçmişi silindi.'),
      ),
    );
  }

  Widget _buildSummaryHeader(List<BraceletAlert> alerts) {
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
          const Row(
            children: [
              Icon(
                Icons.notifications_active_outlined,
                color: Colors.white,
                size: 34,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Bileklik Uyarı Özeti',
                  style: TextStyle(
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
                  label: 'Toplam',
                  value: total.toString(),
                  icon: Icons.list_alt,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildSummaryBox(
                  label: 'Kritik',
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
                  label: 'Düşük',
                  value: low.toString(),
                  icon: Icons.arrow_downward,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildSummaryBox(
                  label: 'Yüksek',
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
                color: Colors.white.withOpacity(0.16),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Son uyarı: ${latest.personName} • ${_shortAlertTitle(latest.alertType)} • ${latest.heartRate} bpm',
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
        color: Colors.white.withOpacity(0.16),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.12),
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

  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
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
              'Bu ekran, sanal bileklikten gelen uyarı olaylarını kaydeder. Gerçek üründe bu kayıtlar cihazdan gelen canlı sensör verileriyle oluşur.',
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

  Widget _buildAlertCard(BraceletAlert alert) {
    final color = _alertColor(alert.alertType);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: color.withOpacity(0.22),
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
                  color: color.withOpacity(0.12),
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
                      _shortAlertTitle(alert.alertType),
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
                  color: color.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: color.withOpacity(0.22),
                  ),
                ),
                child: Text(
                  alert.alertType == 'Kritik uyarı' ? 'ACİL' : 'UYARI',
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
                  label: 'Kalp Ritmi',
                  value: '${alert.heartRate} bpm',
                  color: color,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricPill(
                  icon: Icons.watch_outlined,
                  label: 'Cihaz',
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
                  ? 'Uyarı açıklaması bulunmuyor.'
                  : alert.message,
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
                Icons.notifications_none,
                size: 66,
                color: Colors.black38,
              ),
              SizedBox(height: 16),
              Text(
                'Henüz bileklik uyarısı yok.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Takip Ettiklerim ekranından düşük, yüksek veya kritik ritim simülasyonu oluşturduğunuzda kayıtlar burada görünür.',
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

  Widget _buildClearButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () => _clearAlerts(context),
          icon: const Icon(Icons.delete_outline),
          label: const Text('Uyarı Geçmişini Sil'),
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
        title: const Text('Bileklik Uyarı Geçmişi'),
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
                  'Uyarı geçmişi yüklenirken hata oluştu:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final alerts = snapshot.data ?? [];

          if (alerts.isEmpty) {
            return _buildEmptyState();
          }

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 8),
                  children: [
                    _buildSummaryHeader(alerts),
                    _buildInfoCard(),
                    ...alerts.map(_buildAlertCard),
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
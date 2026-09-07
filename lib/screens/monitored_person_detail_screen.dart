import 'package:flutter/material.dart';
import '../core/widgets/detail_dialogs.dart';
import '../models/monitored_person.dart';
import '../services/monitored_person_service.dart';

class MonitoredPersonDetailScreen extends StatelessWidget {
  final MonitoredPerson person;

  const MonitoredPersonDetailScreen({
    super.key,
    required this.person,
  });

  Color _statusColor(String status) {
    if (status == 'Kritik uyarı') return Colors.red;
    if (status == 'Düşük kalp ritmi uyarısı') return Colors.orange;
    if (status == 'Yüksek kalp ritmi uyarısı') return Colors.deepOrange;
    if (status == 'Normal') return Colors.green;
    return Colors.blueGrey;
  }

  IconData _statusIcon(String status) {
    if (status == 'Kritik uyarı') return Icons.warning_rounded;
    if (status == 'Düşük kalp ritmi uyarısı') return Icons.arrow_downward;
    if (status == 'Yüksek kalp ritmi uyarısı') return Icons.arrow_upward;
    if (status == 'Normal') return Icons.check_circle_outline;
    return Icons.info_outline;
  }

  String _shortStatus(String status) {
    if (status == 'Kritik uyarı') return 'Kritik';
    if (status == 'Düşük kalp ritmi uyarısı') return 'Düşük Ritim';
    if (status == 'Yüksek kalp ritmi uyarısı') return 'Yüksek Ritim';
    if (status == 'Normal') return 'Normal';
    return status;
  }

  Future<void> _showCriticalAlertDialog(
    BuildContext context,
    MonitoredPerson currentPerson,
  ) async {
    await showBraceletCriticalAlertDialog(
      context,
      personName: currentPerson.fullName,
      heartRate: 42,
    );
  }

  Widget _buildHeaderCard(MonitoredPerson currentPerson) {
    final color = _statusColor(currentPerson.status);

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
          Row(
            children: [
              Container(
                width: 74,
                height: 74,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Icon(
                  _statusIcon(currentPerson.status),
                  color: Colors.white,
                  size: 42,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentPerson.fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${currentPerson.relation} • ${currentPerson.age} yaş • ${currentPerson.gender}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            '${currentPerson.heartRate} bpm',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 46,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.17),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              _shortStatus(currentPerson.status),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Son ölçüm: ${currentPerson.lastMeasurement}',
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w500,
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
                color: const Color(0xFF1976D2),
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

  Widget _buildInfoRow({
    required String label,
    required String value,
    bool isLast = false,
  }) {
    return Container(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
      margin: EdgeInsets.only(bottom: isLast ? 0 : 10),
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
            width: 112,
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

  Widget _buildPersonInfoCard(MonitoredPerson currentPerson) {
    return _buildSectionCard(
      title: 'Yakın Bilgileri',
      icon: Icons.person_outline,
      child: Column(
        children: [
          _buildInfoRow(label: 'Ad Soyad', value: currentPerson.fullName),
          _buildInfoRow(label: 'Yakınlık', value: currentPerson.relation),
          _buildInfoRow(label: 'Yaş', value: '${currentPerson.age}'),
          _buildInfoRow(
            label: 'Cinsiyet',
            value: currentPerson.gender,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceCard(MonitoredPerson currentPerson) {
    return _buildSectionCard(
      title: 'Bileklik Bilgileri',
      icon: Icons.watch_outlined,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildMetricPill(
                  icon: Icons.qr_code_2,
                  label: 'Cihaz ID',
                  value: currentPerson.deviceId,
                  color: const Color(0xFF1976D2),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricPill(
                  icon: Icons.cloud_done_outlined,
                  label: 'Bağlantı',
                  value: 'Demo aktif',
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildMetricPill(
            icon: Icons.sensors,
            label: 'Veri Tipi',
            value: 'Kalp ritmi simülasyonu',
            color: Colors.teal,
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFF1976D2).withOpacity(0.25),
              ),
            ),
            child: const Text(
              'Bu prototipte fiziksel bileklik simüle edilmektedir. Gerçek üründe cihaz ID, fiziksel bileklikten gelen canlı sensör verileriyle eşleşir.',
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

  Widget _buildRiskHistoryCard(MonitoredPerson currentPerson) {
    final riskItems = [
      _RiskItem('Önceki Kalp Krizi', currentPerson.previousHeartAttack),
      _RiskItem('Kalp Hastalığı', currentPerson.heartDisease),
      _RiskItem('Hipertansiyon', currentPerson.hypertension),
      _RiskItem('Diyabet', currentPerson.diabetes),
      _RiskItem('Yüksek Kolesterol', currentPerson.highCholesterol),
      _RiskItem('Sigara', currentPerson.smoking),
    ];

    final activeRiskCount = riskItems.where((item) => item.value).length;

    Color summaryColor;
    String summaryText;

    if (activeRiskCount >= 4) {
      summaryColor = Colors.red;
      summaryText = 'Yüksek risk profili';
    } else if (activeRiskCount >= 2) {
      summaryColor = Colors.orange;
      summaryText = 'Orta risk profili';
    } else if (activeRiskCount == 1) {
      summaryColor = Colors.amber.shade700;
      summaryText = 'Düşük/orta risk profili';
    } else {
      summaryColor = Colors.green;
      summaryText = 'Belirgin risk faktörü yok';
    }

    return _buildSectionCard(
      title: 'Risk Geçmişi',
      icon: Icons.health_and_safety_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: summaryColor.withOpacity(0.10),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: summaryColor.withOpacity(0.25),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.analytics_outlined,
                  color: summaryColor,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '$summaryText • Seçili risk faktörü: $activeRiskCount',
                    style: TextStyle(
                      color: summaryColor,
                      fontWeight: FontWeight.w700,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: riskItems
                .map(
                  (item) => _buildRiskChip(
                    label: item.label,
                    value: item.value,
                  ),
                )
                .toList(),
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
              'İlaçlar: ${currentPerson.medications.isEmpty ? "Belirtilmedi" : currentPerson.medications}',
              style: const TextStyle(
                color: Colors.black87,
                height: 1.45,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskChip({
    required String label,
    required bool value,
  }) {
    final bgColor = value ? const Color(0xFFFFEBEE) : const Color(0xFFE8F5E9);
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

  Widget _buildSimulationCard(
    BuildContext context,
    MonitoredPerson currentPerson,
  ) {
    return _buildSectionCard(
      title: 'Demo Simülasyon',
      icon: Icons.tune,
      child: Column(
        children: [
          const Text(
            'Sunum sırasında fiziksel bileklikten veri geliyormuş gibi farklı kalp ritmi durumları oluşturabilirsiniz.',
            style: TextStyle(
              color: Colors.black54,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                await MonitoredPersonService.simulateCriticalAlert(
                  currentPerson.id,
                );

                if (!context.mounted) return;

                await _showCriticalAlertDialog(context, currentPerson);
              },
              icon: const Icon(Icons.warning_rounded),
              label: const Text('Kritik Uyarı Simüle Et'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildSmallActionButton(
                  text: 'Normal',
                  icon: Icons.check_circle_outline,
                  color: Colors.green,
                  onPressed: () {
                    MonitoredPersonService.simulateNormal(currentPerson.id);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSmallActionButton(
                  text: 'Düşük',
                  icon: Icons.arrow_downward,
                  color: Colors.orange,
                  onPressed: () {
                    MonitoredPersonService.simulateLowHeartRate(
                      currentPerson.id,
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildSmallActionButton(
                  text: 'Yüksek',
                  icon: Icons.arrow_upward,
                  color: Colors.deepOrange,
                  onPressed: () {
                    MonitoredPersonService.simulateHighHeartRate(
                      currentPerson.id,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallActionButton({
    required String text,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(
          color: color.withOpacity(0.55),
        ),
        minimumSize: const Size(double.infinity, 44),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget _buildEmergencyInfoCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE53935).withOpacity(0.35),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.emergency,
            color: Color(0xFFE53935),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Gerçek kullanımda kritik ritim uyarısı alındığında kişi kontrol edilmeli; bilinç kaybı, göğüs ağrısı veya nefes darlığı varsa 112 aranmalıdır.',
              style: TextStyle(
                color: Color(0xFF8A1C1C),
                height: 1.45,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MonitoredPerson>>(
      stream: MonitoredPersonService.monitoredPeopleStream(),
      builder: (context, snapshot) {
        final people = snapshot.data ?? [];

        MonitoredPerson currentPerson = person;

        for (final item in people) {
          if (item.id == person.id) {
            currentPerson = item;
            break;
          }
        }

        return Scaffold(
          backgroundColor: const Color(0xFFF5F7FB),
          appBar: AppBar(
            title: Text(currentPerson.fullName),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildHeaderCard(currentPerson),
                _buildPersonInfoCard(currentPerson),
                _buildDeviceCard(currentPerson),
                _buildRiskHistoryCard(currentPerson),
                _buildSimulationCard(context, currentPerson),
                _buildEmergencyInfoCard(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RiskItem {
  final String label;
  final bool value;

  const _RiskItem(this.label, this.value);
}
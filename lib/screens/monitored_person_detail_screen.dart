import 'package:flutter/material.dart';

import '../core/localization/app_strings.dart';
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

  Widget _buildHeaderCard(
    BuildContext context,
    MonitoredPerson currentPerson,
  ) {
    final t = AppStrings.of(context);
    final color = _statusColor(currentPerson.status);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color,
            color.withValues(alpha: 0.72),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
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
                  color: Colors.white.withValues(alpha: 0.18),
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
                      t.relationAgeGender(
                        relation: currentPerson.relation,
                        age: currentPerson.age,
                        gender: currentPerson.gender,
                      ),
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
              color: Colors.white.withValues(alpha: 0.17),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              t.shortPersonStatusText(currentPerson.status),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            '${t.lastMeasurement}: ${currentPerson.lastMeasurement}',
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

  Widget _buildPersonInfoCard(
    BuildContext context,
    MonitoredPerson currentPerson,
  ) {
    final t = AppStrings.of(context);

    return _buildSectionCard(
      title: t.personInformation,
      icon: Icons.person_outline,
      child: Column(
        children: [
          _buildInfoRow(
            label: t.fullNameLabel,
            value: currentPerson.fullName,
          ),
          _buildInfoRow(
            label: t.relationLabel,
            value: currentPerson.relation,
          ),
          _buildInfoRow(
            label: t.ageLabel,
            value: '${currentPerson.age}',
          ),
          _buildInfoRow(
            label: t.genderLabel,
            value: t.genderText(currentPerson.gender),
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceCard(
    BuildContext context,
    MonitoredPerson currentPerson,
  ) {
    final t = AppStrings.of(context);

    return _buildSectionCard(
      title: t.braceletInformation,
      icon: Icons.watch_outlined,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildMetricPill(
                  icon: Icons.qr_code_2,
                  label: t.deviceId,
                  value: currentPerson.deviceId,
                  color: const Color(0xFF1976D2),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricPill(
                  icon: Icons.cloud_done_outlined,
                  label: t.connection,
                  value: t.demoActive,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildMetricPill(
            icon: Icons.sensors,
            label: t.dataType,
            value: t.heartRateSimulation,
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
                color: const Color(0xFF1976D2).withValues(alpha: 0.25),
              ),
            ),
            child: Text(
              t.wearablePrototypeInfo,
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

  Widget _buildMetricPill({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(13),
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

  Widget _buildRiskHistoryCard(
    BuildContext context,
    MonitoredPerson currentPerson,
  ) {
    final t = AppStrings.of(context);

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
      summaryText = isEnglishText(context, 'Yüksek risk profili', 'High risk profile');
    } else if (activeRiskCount >= 2) {
      summaryColor = Colors.orange;
      summaryText = isEnglishText(context, 'Orta risk profili', 'Moderate risk profile');
    } else if (activeRiskCount == 1) {
      summaryColor = Colors.amber.shade700;
      summaryText = isEnglishText(context, 'Düşük/orta risk profili', 'Low/moderate risk profile');
    } else {
      summaryColor = Colors.green;
      summaryText = t.noClearRiskFactor;
    }

    return _buildSectionCard(
      title: t.riskHistory,
      icon: Icons.health_and_safety_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: summaryColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: summaryColor.withValues(alpha: 0.25),
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
                    '$summaryText • ${t.selectedRiskFactorCount(activeRiskCount)}',
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
                    context: context,
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
              '${t.medicationsPrefix}: ${currentPerson.medications.isEmpty ? t.notSpecified : currentPerson.medications}',
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

  String isEnglishText(
    BuildContext context,
    String tr,
    String en,
  ) {
    final t = AppStrings.of(context);

    return t.isEnglish ? en : tr;
  }

  Widget _buildRiskChip({
    required BuildContext context,
    required String label,
    required bool value,
  }) {
    final t = AppStrings.of(context);
    final bgColor = value ? const Color(0xFFFFEBEE) : const Color(0xFFE8F5E9);
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
        '${t.riskFactorLabel(label)}: ${value ? t.yes : t.no}',
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
    final t = AppStrings.of(context);

    return _buildSectionCard(
      title: t.demoSimulation,
      icon: Icons.tune,
      child: Column(
        children: [
          Text(
            t.demoSimulationMessage,
            style: const TextStyle(
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
              label: Text(t.simulateCriticalAlert),
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
                  text: t.low,
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
                  text: t.high,
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
          color: color.withValues(alpha: 0.55),
        ),
        minimumSize: const Size(double.infinity, 44),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget _buildEmergencyInfoCard(BuildContext context) {
    final t = AppStrings.of(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE53935).withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.emergency,
            color: Color(0xFFE53935),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              t.realUseEmergencyInfo,
              style: const TextStyle(
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
                _buildHeaderCard(context, currentPerson),
                _buildPersonInfoCard(context, currentPerson),
                _buildDeviceCard(context, currentPerson),
                _buildRiskHistoryCard(context, currentPerson),
                _buildSimulationCard(context, currentPerson),
                _buildEmergencyInfoCard(context),
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
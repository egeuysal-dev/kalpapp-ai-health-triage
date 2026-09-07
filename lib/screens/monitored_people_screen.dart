import 'package:flutter/material.dart';
import '../core/widgets/detail_dialogs.dart';
import '../models/monitored_person.dart';
import '../services/monitored_person_service.dart';
import 'add_monitored_person_screen.dart';
import 'bracelet_alert_history_screen.dart';
import 'monitored_person_detail_screen.dart';

class MonitoredPeopleScreen extends StatelessWidget {
  const MonitoredPeopleScreen({super.key});

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

  Future<void> _deletePerson(
    BuildContext context,
    MonitoredPerson person,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Yakını Sil'),
        content: Text(
          '${person.fullName} ve bağlı sanal bileklik kaydı silinsin mi?',
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

    await MonitoredPersonService.deletePerson(person.id);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Yakın kaydı silindi.'),
      ),
    );
  }

  Future<void> _showCriticalAlertDialog(
    BuildContext context,
    MonitoredPerson person,
  ) async {
    await showBraceletCriticalAlertDialog(
      context,
      personName: person.fullName,
      heartRate: 42,
    );
  }

  Widget _buildHeaderInfoCard() {
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
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.watch_outlined,
            color: Colors.white,
            size: 38,
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Yakın ve Bileklik Takibi',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Kalp hastalığı riski taşıyan yakınlarınızı sanal bileklik kimliğiyle takip edin. Demo modunda ritim uyarılarını simüle edebilirsiniz.',
                  style: TextStyle(
                    color: Colors.white70,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonCard(BuildContext context, MonitoredPerson person) {
    final color = _statusColor(person.status);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(16, 0, 0, 0),
            blurRadius: 14,
            offset: Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: color.withOpacity(0.20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPersonHeader(context, person, color),
          const SizedBox(height: 16),
          _buildHeartRateStatusPanel(person, color),
          const SizedBox(height: 14),
          _buildDeviceAndTimeRow(person),
          const SizedBox(height: 14),
          _buildPrimaryActions(context, person),
          const SizedBox(height: 10),
          _buildSimulationActions(person),
        ],
      ),
    );
  }

  Widget _buildPersonHeader(
    BuildContext context,
    MonitoredPerson person,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            _statusIcon(person.status),
            color: color,
            size: 34,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                person.fullName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: Color(0xFF1D1D1F),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${person.relation} • ${person.age} yaş • ${person.gender}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => _deletePerson(context, person),
          icon: const Icon(Icons.delete_outline),
          color: Colors.red,
          tooltip: 'Sil',
        ),
      ],
    );
  }

  Widget _buildHeartRateStatusPanel(
    MonitoredPerson person,
    Color color,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.20),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildMetricBlock(
              icon: Icons.favorite,
              label: 'Kalp Ritmi',
              value: '${person.heartRate} bpm',
              color: color,
            ),
          ),
          Container(
            width: 1,
            height: 48,
            color: color.withOpacity(0.18),
          ),
          Expanded(
            child: _buildMetricBlock(
              icon: _statusIcon(person.status),
              label: 'Durum',
              value: _shortStatus(person.status),
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricBlock({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 27,
        ),
        const SizedBox(width: 10),
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
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDeviceAndTimeRow(MonitoredPerson person) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoPill(
            icon: Icons.watch_outlined,
            label: 'Cihaz',
            value: person.deviceId,
            color: const Color(0xFF1976D2),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildInfoPill(
            icon: Icons.access_time,
            label: 'Son Ölçüm',
            value: person.lastMeasurement,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoPill({
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
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryActions(
    BuildContext context,
    MonitoredPerson person,
  ) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MonitoredPersonDetailScreen(person: person),
                ),
              );
            },
            icon: const Icon(Icons.info_outline),
            label: const Text('Detay'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () async {
              await MonitoredPersonService.simulateCriticalAlert(person.id);

              if (!context.mounted) return;

              await _showCriticalAlertDialog(context, person);
            },
            icon: const Icon(Icons.warning_rounded),
            label: const Text('Kritik'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSimulationActions(MonitoredPerson person) {
    return Row(
      children: [
        Expanded(
          child: _buildSmallActionButton(
            text: 'Normal',
            icon: Icons.check_circle_outline,
            color: Colors.green,
            onPressed: () {
              MonitoredPersonService.simulateNormal(person.id);
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
              MonitoredPersonService.simulateLowHeartRate(person.id);
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
              MonitoredPersonService.simulateHighHeartRate(person.id);
            },
          ),
        ),
      ],
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

  Widget _buildEmptyState(BuildContext context) {
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
                Icons.watch_outlined,
                size: 66,
                color: Colors.black38,
              ),
              const SizedBox(height: 16),
              const Text(
                'Henüz takip edilen yakın yok.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Bir yakınınızı ve ona ait sanal bileklik cihaz kimliğini ekleyerek demo takibe başlayabilirsiniz.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AddMonitoredPersonScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.person_add_alt_1),
                  label: const Text('Yakın Ekle'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openAlertHistory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const BraceletAlertHistoryScreen(),
      ),
    );
  }

  void _openAddPerson(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddMonitoredPersonScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text('Takip Ettiklerim'),
        actions: [
          IconButton(
            onPressed: () => _openAlertHistory(context),
            icon: const Icon(Icons.notifications_active_outlined),
            tooltip: 'Bileklik Uyarı Geçmişi',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openAddPerson(context),
        icon: const Icon(Icons.add),
        label: const Text('Yakın Ekle'),
      ),
      body: StreamBuilder<List<MonitoredPerson>>(
        stream: MonitoredPersonService.monitoredPeopleStream(),
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
                  'Takip edilen yakınlar yüklenirken hata oluştu:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final people = snapshot.data ?? [];

          if (people.isEmpty) {
            return _buildEmptyState(context);
          }

          return ListView(
            padding: const EdgeInsets.only(bottom: 90),
            children: [
              _buildHeaderInfoCard(),
              ...people.map(
                (person) => _buildPersonCard(context, person),
              ),
            ],
          );
        },
      ),
    );
  }
}
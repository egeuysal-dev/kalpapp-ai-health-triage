import 'package:flutter/material.dart';

import '../core/localization/app_strings.dart';
import '../core/widgets/detail_dialogs.dart';
import '../models/assessment_result.dart';
import '../models/monitored_person.dart';
import '../models/user_profile.dart';
import '../services/firebase_auth_service.dart';
import '../services/firestore_user_service.dart';
import '../services/monitored_person_service.dart';
import 'about_screen.dart';
import 'account_settings_screen.dart';
import 'bracelet_alert_history_screen.dart';
import 'history_screen.dart';
import 'login_screen.dart';
import 'monitored_people_screen.dart';
import 'monitored_person_detail_screen.dart';
import 'privacy_policy_screen.dart';
import 'profile_screen.dart';
import 'symptom_screen.dart';

class HomeScreen extends StatelessWidget {
  final UserProfile profile;

  const HomeScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);

    return StreamBuilder<UserProfile?>(
      stream: FirestoreUserService.profileStream(),
      initialData: profile,
      builder: (context, snapshot) {
        final currentProfile = snapshot.data ?? profile;

        return Scaffold(
          backgroundColor: const Color(0xFFF5F7FB),
          appBar: AppBar(
            title: const Text('KalpAPP'),
            automaticallyImplyLeading: false,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.info_outline),
                tooltip: t.aboutApp,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AboutScreen(),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: t.logout,
                onPressed: () async {
                  await FirebaseAuthService.signOut();

                  if (!context.mounted) return;

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildWelcomeCard(context, currentProfile),
                const SizedBox(height: 16),
                _buildActiveBraceletAlertCard(context),
                const SizedBox(height: 16),
                _buildCategorySection(
                  title: t.quickActions,
                  children: [
                    _buildMenuGridItem(
                      context,
                      icon: Icons.emergency,
                      title: t.heartAssessment,
                      subtitle: t.symptomAnalysis,
                      color: const Color(0xFFE53935),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                SymptomScreen(profile: currentProfile),
                          ),
                        );
                      },
                    ),
                    _buildMenuGridItem(
                      context,
                      icon: Icons.people_alt_outlined,
                      title: t.monitoredPeople,
                      subtitle: t.relativesAndWearable,
                      color: const Color(0xFF1976D2),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MonitoredPeopleScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildCategorySection(
                  title: t.recordsAndAlerts,
                  children: [
                    _buildMenuGridItem(
                      context,
                      icon: Icons.assignment_turned_in_outlined,
                      title: t.lastAssessment,
                      subtitle: t.lastRiskResult,
                      color: Colors.green,
                      onTap: () {
                        _showLastAssessmentDialog(context);
                      },
                    ),
                    _buildMenuGridItem(
                      context,
                      icon: Icons.history,
                      title: t.history,
                      subtitle: t.riskRecords,
                      color: Colors.deepPurple,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HistoryScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuGridItem(
                      context,
                      icon: Icons.notifications_active_outlined,
                      title: t.braceletAlerts,
                      subtitle: t.alertHistory,
                      color: Colors.orange,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const BraceletAlertHistoryScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuGridItem(
                      context,
                      icon: Icons.monitor_heart_outlined,
                      title: t.braceletMonitoring,
                      subtitle: t.liveDemoStatus,
                      color: Colors.teal,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MonitoredPeopleScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildLastAssessmentCompactCard(context),
                const SizedBox(height: 16),
                _buildCategorySection(
                  title: t.account,
                  children: [
                    _buildMenuGridItem(
                      context,
                      icon: Icons.edit,
                      title: t.editProfile,
                      subtitle: t.updateInformation,
                      color: Colors.indigo,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ProfileScreen(existingProfile: currentProfile),
                          ),
                        );
                      },
                    ),
                    _buildMenuGridItem(
                      context,
                      icon: Icons.person,
                      title: t.profileSummary,
                      subtitle: t.savedInformation,
                      color: Colors.blueGrey,
                      onTap: () {
                        _showProfileSummary(context, currentProfile);
                      },
                    ),
                    _buildMenuGridItem(
                      context,
                      icon: Icons.settings,
                      title: t.accountSecurity,
                      subtitle: t.dataAndSession,
                      color: Colors.brown,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AccountSettingsScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuGridItem(
                      context,
                      icon: Icons.logout,
                      title: t.logout,
                      subtitle: t.closeSession,
                      color: Colors.redAccent,
                      onTap: () async {
                        await FirebaseAuthService.signOut();

                        if (!context.mounted) return;

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildCategorySection(
                  title: t.information,
                  children: [
                    _buildMenuGridItem(
                      context,
                      icon: Icons.privacy_tip_outlined,
                      title: t.privacyAndKvkk,
                      subtitle: t.dataPolicy,
                      color: Colors.cyan,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PrivacyPolicyScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuGridItem(
                      context,
                      icon: Icons.info_outline,
                      title: t.aboutApp,
                      subtitle: t.purposeAndVersion,
                      color: Colors.pink,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AboutScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

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

  Color _braceletStatusColor(String status) {
    if (status == 'Kritik uyarı') return Colors.red;
    if (status == 'Düşük kalp ritmi uyarısı') return Colors.orange;
    if (status == 'Yüksek kalp ritmi uyarısı') return Colors.deepOrange;

    return Colors.green;
  }

  IconData _braceletStatusIcon(String status) {
    if (status == 'Kritik uyarı') return Icons.warning_rounded;
    if (status == 'Düşük kalp ritmi uyarısı') return Icons.arrow_downward;
    if (status == 'Yüksek kalp ritmi uyarısı') return Icons.arrow_upward;

    return Icons.check_circle_outline;
  }

  bool _isAlertStatus(String status) {
    return status == 'Kritik uyarı' ||
        status == 'Düşük kalp ritmi uyarısı' ||
        status == 'Yüksek kalp ritmi uyarısı';
  }

  Widget _buildWelcomeCard(
    BuildContext context,
    UserProfile currentProfile,
  ) {
    final t = AppStrings.of(context);
    final gender = t.genderText(currentProfile.gender);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE53935), Color(0xFFD81B60)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(40, 229, 57, 53),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.favorite,
              color: Colors.white,
              size: 34,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.welcomeUser(currentProfile.fullName),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  t.ageGender(currentProfile.age, gender),
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
    );
  }

  Widget _buildActiveBraceletAlertCard(BuildContext context) {
    final t = AppStrings.of(context);

    return StreamBuilder<List<MonitoredPerson>>(
      stream: MonitoredPersonService.monitoredPeopleStream(),
      builder: (context, snapshot) {
        final people = snapshot.data ?? [];

        final alerts = people.where((person) {
          return _isAlertStatus(person.status);
        }).toList();

        if (alerts.isEmpty) {
          return const SizedBox.shrink();
        }

        final alert = alerts.first;
        final color = _braceletStatusColor(alert.status);
        final statusText = t.braceletStatusText(alert.status);

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: color.withValues(alpha: 0.35),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(18, 0, 0, 0),
                blurRadius: 14,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _braceletStatusIcon(alert.status),
                    color: color,
                    size: 32,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      t.activeBraceletAlert,
                      style: TextStyle(
                        color: color,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                t.braceletAlertDetected(alert.fullName, statusText),
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${t.heartRate}: ${alert.heartRate} bpm\n'
                '${t.deviceId}: ${alert.deviceId}\n'
                '${t.lastMeasurement}: ${alert.lastMeasurement}',
                style: const TextStyle(
                  color: Colors.black87,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                MonitoredPersonDetailScreen(person: alert),
                          ),
                        );
                      },
                      icon: const Icon(Icons.monitor_heart_outlined),
                      label: Text(t.openDetail),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await MonitoredPersonService.simulateNormal(alert.id);
                      },
                      icon: const Icon(Icons.check_circle_outline),
                      label: Text(t.normalize),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: color,
                        side: BorderSide(color: color),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategorySection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(12, 0, 0, 0),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF1D1D1F),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.18,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: children,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuGridItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: color.withValues(alpha: 0.20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: color,
                size: 30,
              ),
              const Spacer(),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLastAssessmentCompactCard(BuildContext context) {
    final t = AppStrings.of(context);

    return StreamBuilder<List<AssessmentResult>>(
      stream: FirestoreUserService.assessmentsStream(),
      builder: (context, snapshot) {
        final assessments = snapshot.data ?? [];

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                ),
                const SizedBox(width: 14),
                Text(t.lastAssessmentLoading),
              ],
            ),
          );
        }

        if (snapshot.hasError || assessments.isEmpty) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(12, 0, 0, 0),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.history_toggle_off, color: Colors.black45),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    t.noAssessmentYet,
                    style: const TextStyle(
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        final last = assessments.first;
        final color = _riskColor(last.riskLevel);
        final riskText = t.riskLevelText(last.riskLevel);

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(12, 0, 0, 0),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  _riskIcon(last.riskLevel),
                  color: color,
                  size: 30,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.lastAssessment,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      riskText,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      t.scoreAndDate(last.riskScore, last.createdAt),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  showAssessmentDetailDialog(context, last);
                },
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showLastAssessmentDialog(BuildContext context) async {
    final t = AppStrings.of(context);
    final assessments = await FirestoreUserService.loadAssessments();

    if (!context.mounted) return;

    if (assessments.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.noSavedAssessment),
        ),
      );
      return;
    }

    await showAssessmentDetailDialog(context, assessments.first);
  }

  void _showProfileSummary(BuildContext context, UserProfile currentProfile) {
    showProfileSummaryDialog(context, currentProfile);
  }
}
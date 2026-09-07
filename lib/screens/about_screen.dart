import 'package:flutter/material.dart';

import '../core/localization/app_strings.dart';
import '../core/widgets/section_card.dart';
import 'privacy_policy_screen.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const String appVersion = '1.0.0';

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.aboutApp),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildHeaderCard(context),
            const SizedBox(height: 16),
            SectionCard(
              title: t.aboutPurposeTitle,
              child: Text(
                t.aboutPurposeText,
                style: const TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: t.aboutWearableTrackingTitle,
              child: Text(
                t.aboutWearableTrackingText,
                style: const TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: t.aboutFamilyMonitoringTitle,
              child: Text(
                t.aboutFamilyMonitoringText,
                style: const TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: t.aboutWearableAlertHistoryTitle,
              child: Text(
                t.aboutWearableAlertHistoryText,
                style: const TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: t.aboutMedicalWarningTitle,
              child: Text(
                t.aboutMedicalWarningText,
                style: const TextStyle(
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SectionCard(
              title: t.aboutAnalysisSystemTitle,
              child: Text(
                t.aboutAnalysisSystemText,
                style: const TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: t.aboutDataSecurityTitle,
              child: Text(
                t.aboutDataSecurityText,
                style: const TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: t.aboutPrivacyTitle,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.aboutPrivacyText,
                    style: const TextStyle(height: 1.5),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PrivacyPolicyScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.privacy_tip_outlined),
                      label: Text(t.openPrivacyPolicy),
                    ),
                  ),
                ],
              ),
            ),
            SectionCard(
              title: t.aboutProjectInfoTitle,
              child: Text(
                t.aboutProjectInfoText,
                style: const TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: t.aboutDemoModeTitle,
              child: Text(
                t.aboutDemoModeText,
                style: const TextStyle(height: 1.5),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              t.aboutFooterText,
              style: const TextStyle(
                color: Colors.black45,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    final t = AppStrings.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE53935), Color(0xFFD81B60)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(40, 229, 57, 53),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.favorite,
              color: Colors.white,
              size: 44,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'KalpAPP',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            t.aboutHeaderSubtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              t.aboutVersionText(appVersion),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
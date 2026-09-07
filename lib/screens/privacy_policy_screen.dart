import 'package:flutter/material.dart';

import '../core/localization/app_strings.dart';
import '../core/widgets/section_card.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.privacyScreenTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SectionCard(
              title: t.privacyInfoTitle,
              child: Text(
                t.privacyInfoText,
                style: const TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: t.collectedUserDataTitle,
              child: Text(
                t.collectedUserDataText,
                style: const TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: t.monitoredFamilyDataTitle,
              child: Text(
                t.monitoredFamilyDataText,
                style: const TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: t.wearableDeviceIdentityTitle,
              child: Text(
                t.wearableDeviceIdentityText,
                style: const TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: t.privacyWearableAlertHistoryTitle,
              child: Text(
                t.privacyWearableAlertHistoryText,
                style: const TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: t.healthDataTitle,
              child: Text(
                t.healthDataText,
                style: const TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: t.aiUsageTitle,
              child: Text(
                t.aiUsageText,
                style: const TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: t.speechSymptomInputTitle,
              child: Text(
                t.speechSymptomInputText,
                style: const TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: t.dataUsagePurposeTitle,
              child: Text(
                t.dataUsagePurposeText,
                style: const TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: t.privacyEmergencyWarningTitle,
              child: Text(
                t.privacyEmergencyWarningText,
                style: const TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: t.privacyDemoPrototypeTitle,
              child: Text(
                t.privacyDemoPrototypeText,
                style: const TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: t.dataDeletionTitle,
              child: Text(
                t.dataDeletionText,
                style: const TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: t.privacyNoteTitle,
              child: Text(
                t.privacyNoteText,
                style: const TextStyle(height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
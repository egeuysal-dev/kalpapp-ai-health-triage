import 'package:flutter/material.dart';

import '../core/localization/app_language.dart';
import '../core/localization/app_language_controller.dart';
import '../core/localization/app_strings.dart';
import '../core/widgets/primary_button.dart';
import '../core/widgets/section_card.dart';
import '../services/firebase_auth_service.dart';
import '../services/firestore_user_service.dart';
import 'login_screen.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  bool _isProcessing = false;

  Future<bool> _confirm({
    required String title,
    required String message,
    required String confirmText,
  }) async {
    final t = AppStrings.of(context);

    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(t.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(confirmText),
          ),
        ],
      ),
    );

    return result == true;
  }

  Future<void> _changeLanguage(AppLanguage language) async {
    await LanguageScope.of(context).setLanguage(language);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppStrings.of(context).languageChanged),
      ),
    );
  }

  Future<void> _clearHistory() async {
    final t = AppStrings.of(context);

    final confirm = await _confirm(
      title: t.clearHistoryDialogTitle,
      message: t.clearHistoryDialogMessage,
      confirmText: t.commonDelete,
    );

    if (!confirm) return;

    setState(() => _isProcessing = true);

    try {
      await FirestoreUserService.clearAssessments();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.historyCleared),
        ),
      );
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.historyClearError),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  Future<void> _deleteProfileData() async {
    final t = AppStrings.of(context);

    final confirm = await _confirm(
      title: t.deleteProfileDataDialogTitle,
      message: t.deleteProfileDataDialogMessage,
      confirmText: t.deleteProfileDataConfirm,
    );

    if (!confirm) return;

    setState(() => _isProcessing = true);

    try {
      await FirestoreUserService.deleteAllUserData();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.profileDataDeleted),
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.profileDataDeleteError),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  Future<void> _deleteAccountCompletely() async {
    final t = AppStrings.of(context);

    final confirm = await _confirm(
      title: t.deleteAccountDialogTitle,
      message: t.deleteAccountDialogMessage,
      confirmText: t.deleteAccountConfirm,
    );

    if (!confirm) return;

    setState(() => _isProcessing = true);

    try {
      await FirestoreUserService.deleteAllUserData();

      final error = await FirebaseAuthService.deleteCurrentUser();

      if (!mounted) return;

      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );

        if (error.contains('tekrar giriş')) {
          await FirebaseAuthService.signOut();

          if (!mounted) return;

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
          );
        }

        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.accountDeleted),
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.accountDeleteError),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  Future<void> _logout() async {
    await FirebaseAuthService.signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);
    final languageController = LanguageScope.of(context);
    final email = FirebaseAuthService.currentUserEmail ?? t.commonUnknown;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.accountAndSecurity),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SectionCard(
              title: t.accountInfo,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.signedInEmail,
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    email,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SectionCard(
              title: t.languageTitle,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.languageSubtitle,
                    style: const TextStyle(
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _LanguageOptionTile(
                    title: t.turkish,
                    subtitle: 'Türkçe arayüz',
                    isSelected: languageController.language == AppLanguage.tr,
                    onTap: _isProcessing
                        ? null
                        : () {
                            _changeLanguage(AppLanguage.tr);
                          },
                  ),
                  const Divider(height: 1),
                  _LanguageOptionTile(
                    title: t.english,
                    subtitle: 'English interface',
                    isSelected: languageController.language == AppLanguage.en,
                    onTap: _isProcessing
                        ? null
                        : () {
                            _changeLanguage(AppLanguage.en);
                          },
                  ),
                ],
              ),
            ),
            SectionCard(
              title: t.dataManagement,
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.history),
                    title: Text(t.clearAssessmentHistory),
                    subtitle: Text(t.clearAssessmentHistorySubtitle),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _isProcessing ? null : _clearHistory,
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.person_remove_outlined),
                    title: Text(t.deleteProfileData),
                    subtitle: Text(t.deleteProfileDataSubtitle),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _isProcessing ? null : _deleteProfileData,
                  ),
                ],
              ),
            ),
            SectionCard(
              title: t.session,
              child: Column(
                children: [
                  PrimaryButton(
                    text: t.logout,
                    onPressed: _isProcessing ? null : _logout,
                    icon: Icons.logout,
                  ),
                ],
              ),
            ),
            SectionCard(
              title: t.dangerZone,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.deleteAccountWarning,
                    style: const TextStyle(
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _isProcessing ? null : _deleteAccountCompletely,
                      icon: const Icon(Icons.delete_forever),
                      label: Text(t.deleteAccount),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        minimumSize: const Size(double.infinity, 52),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_isProcessing)
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOptionTile extends StatelessWidget {
  const _LanguageOptionTile({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }
}
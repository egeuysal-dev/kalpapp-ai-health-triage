import 'package:flutter/material.dart';
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
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Vazgeç'),
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

  Future<void> _clearHistory() async {
    final confirm = await _confirm(
      title: 'Geçmişi Sil',
      message: 'Tüm değerlendirme geçmişiniz silinsin mi?',
      confirmText: 'Sil',
    );

    if (!confirm) return;

    setState(() => _isProcessing = true);

    try {
      await FirestoreUserService.clearAssessments();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Değerlendirme geçmişi silindi.'),
        ),
      );
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Geçmiş silinirken bir hata oluştu.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  Future<void> _deleteProfileData() async {
    final confirm = await _confirm(
      title: 'Profil Verilerini Sil',
      message:
          'Profil bilgileriniz ve değerlendirme geçmişiniz silinsin mi? Hesabınız silinmez, sadece verileriniz temizlenir.',
      confirmText: 'Verileri Sil',
    );

    if (!confirm) return;

    setState(() => _isProcessing = true);

    try {
      await FirestoreUserService.deleteAllUserData();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profil ve geçmiş verileri silindi.'),
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
        const SnackBar(
          content: Text('Veriler silinirken bir hata oluştu.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  Future<void> _deleteAccountCompletely() async {
    final confirm = await _confirm(
      title: 'Hesabı Kalıcı Olarak Sil',
      message:
          'Bu işlem hesabınızı ve tüm uygulama verilerinizi siler. Bu işlem geri alınamaz.',
      confirmText: 'Hesabımı Sil',
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
        const SnackBar(
          content: Text('Hesabınız silindi.'),
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
        const SnackBar(
          content: Text('Hesap silinirken bir hata oluştu.'),
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
    final email = FirebaseAuthService.currentUserEmail ?? 'Bilinmiyor';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hesap ve Güvenlik'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SectionCard(
              title: 'Hesap Bilgileri',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Giriş yapılan e-posta',
                    style: TextStyle(
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
              title: 'Veri Yönetimi',
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.history),
                    title: const Text('Değerlendirme Geçmişini Sil'),
                    subtitle: const Text('Sadece geçmiş risk kayıtlarını siler.'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _isProcessing ? null : _clearHistory,
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.person_remove_outlined),
                    title: const Text('Profil Verilerini Sil'),
                    subtitle: const Text(
                      'Profil ve geçmiş verilerini siler, hesabı silmez.',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _isProcessing ? null : _deleteProfileData,
                  ),
                ],
              ),
            ),
            SectionCard(
              title: 'Oturum',
              child: Column(
                children: [
                  PrimaryButton(
                    text: 'Çıkış Yap',
                    onPressed: _isProcessing ? null : _logout,
                    icon: Icons.logout,
                  ),
                ],
              ),
            ),
            SectionCard(
              title: 'Tehlikeli Bölge',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hesabınızı silerseniz profiliniz, değerlendirme geçmişiniz ve hesabınız kalıcı olarak silinir.',
                    style: TextStyle(
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed:
                          _isProcessing ? null : _deleteAccountCompletely,
                      icon: const Icon(Icons.delete_forever),
                      label: const Text('Hesabımı Kalıcı Olarak Sil'),
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
import 'package:flutter/material.dart';

import 'app_language.dart';
import 'app_language_controller.dart';

class AppStrings {
  const AppStrings._(this.language);

  final AppLanguage language;

  static AppStrings of(BuildContext context) {
    return AppStrings._(LanguageScope.languageOf(context));
  }

  bool get isEnglish => language == AppLanguage.en;

  String get appName => 'KalpAPP';

  // Common
  String get commonCancel => isEnglish ? 'Cancel' : 'Vazgeç';
  String get commonDelete => isEnglish ? 'Delete' : 'Sil';
  String get commonSend => isEnglish ? 'Send' : 'Gönder';
  String get commonUnknown => isEnglish ? 'Unknown' : 'Bilinmiyor';
  String get commonError => isEnglish ? 'An error occurred.' : 'Bir hata oluştu.';

  // Validation
  String get emailRequired => isEnglish ? 'Email is required.' : 'E-posta zorunludur.';
  String get validEmailRequired =>
      isEnglish ? 'Please enter a valid email address.' : 'Geçerli bir e-posta girin.';

  String get passwordRequired => isEnglish ? 'Password is required.' : 'Şifre zorunludur.';
  String get passwordMinLength =>
      isEnglish ? 'Password must be at least 6 characters.' : 'Şifre en az 6 karakter olmalıdır.';
  String get passwordMustContainLetter =>
      isEnglish ? 'Password must contain at least one letter.' : 'Şifre en az bir harf içermelidir.';
  String get passwordMustContainNumber =>
      isEnglish ? 'Password must contain at least one number.' : 'Şifre en az bir rakam içermelidir.';

  String get confirmPasswordRequired =>
      isEnglish ? 'Password confirmation is required.' : 'Şifre tekrar zorunludur.';
  String get passwordsDoNotMatch =>
      isEnglish ? 'Passwords do not match.' : 'Şifreler eşleşmiyor.';

  // Login
  String get loginSubtitle =>
      isEnglish ? 'Sign in to continue' : 'Devam etmek için giriş yapın';
  String get loginInfoTitle => isEnglish ? 'Login Information' : 'Giriş Bilgileri';
  String get emailLabel => isEnglish ? 'Email' : 'E-posta';
  String get passwordLabel => isEnglish ? 'Password' : 'Şifre';
  String get forgotPassword => isEnglish ? 'Forgot Password?' : 'Şifremi Unuttum';
  String get sending => isEnglish ? 'Sending...' : 'Gönderiliyor...';
  String get signingIn => isEnglish ? 'Signing In...' : 'Giriş Yapılıyor...';
  String get signIn => isEnglish ? 'Sign In' : 'Giriş Yap';
  String get noAccountRegister =>
      isEnglish ? "Don't have an account? Register" : 'Hesabın yok mu? Kayıt ol';

  String get resetPasswordEmailRequired => isEnglish
      ? 'Enter your email address to reset your password.'
      : 'Şifre sıfırlamak için e-posta adresinizi girin.';

  String get resetPasswordTitle =>
      isEnglish ? 'Password Reset' : 'Şifre Sıfırlama';

  String resetPasswordConfirmMessage(String email) {
    return isEnglish
        ? 'Send a password reset link to $email?'
        : '$email adresine şifre sıfırlama bağlantısı gönderilsin mi?';
  }

  String get resetPasswordSent => isEnglish
      ? 'Password reset link has been sent to your email address.'
      : 'Şifre sıfırlama bağlantısı e-posta adresinize gönderildi.';

  // Register
  String get createAccount => isEnglish ? 'Create Account' : 'Hesap Oluştur';
  String get registerInfoTitle => isEnglish ? 'Registration Information' : 'Kayıt Bilgileri';
  String get passwordHelperText => isEnglish
      ? 'At least 6 characters, must include letters and numbers'
      : 'En az 6 karakter, harf ve rakam içermeli';
  String get confirmPasswordLabel =>
      isEnglish ? 'Confirm Password' : 'Şifre Tekrar';
  String get creatingAccount =>
      isEnglish ? 'Creating Account...' : 'Kayıt Oluşturuluyor...';
  String get register => isEnglish ? 'Register' : 'Kayıt Ol';
  String get registerSuccess => isEnglish
      ? 'Registration successful. You can now sign in.'
      : 'Kayıt başarılı. Şimdi giriş yapabilirsiniz.';

  // Account Settings
  String get accountAndSecurity =>
      isEnglish ? 'Account and Security' : 'Hesap ve Güvenlik';

  String get accountInfo =>
      isEnglish ? 'Account Information' : 'Hesap Bilgileri';

  String get signedInEmail =>
      isEnglish ? 'Signed-in email' : 'Giriş yapılan e-posta';

  String get languageTitle => isEnglish ? 'Language' : 'Dil';

  String get languageSubtitle => isEnglish
      ? 'Choose the application language.'
      : 'Uygulama dilini seçin.';

  String get turkish => 'Türkçe';
  String get english => 'English';

  String get languageChanged => isEnglish
      ? 'Application language changed to English.'
      : 'Uygulama dili Türkçe olarak değiştirildi.';

  String get dataManagement =>
      isEnglish ? 'Data Management' : 'Veri Yönetimi';

  String get clearAssessmentHistory =>
      isEnglish ? 'Clear Assessment History' : 'Değerlendirme Geçmişini Sil';

  String get clearAssessmentHistorySubtitle => isEnglish
      ? 'Only clears previous risk assessment records.'
      : 'Sadece geçmiş risk kayıtlarını siler.';

  String get clearHistoryDialogTitle =>
      isEnglish ? 'Clear History' : 'Geçmişi Sil';

  String get clearHistoryDialogMessage => isEnglish
      ? 'Do you want to clear all assessment history?'
      : 'Tüm değerlendirme geçmişiniz silinsin mi?';

  String get historyCleared => isEnglish
      ? 'Assessment history has been cleared.'
      : 'Değerlendirme geçmişi silindi.';

  String get historyClearError => isEnglish
      ? 'An error occurred while clearing the history.'
      : 'Geçmiş silinirken bir hata oluştu.';

  String get deleteProfileData =>
      isEnglish ? 'Delete Profile Data' : 'Profil Verilerini Sil';

  String get deleteProfileDataSubtitle => isEnglish
      ? 'Deletes profile and history data, but does not delete the account.'
      : 'Profil ve geçmiş verilerini siler, hesabı silmez.';

  String get deleteProfileDataDialogTitle =>
      isEnglish ? 'Delete Profile Data' : 'Profil Verilerini Sil';

  String get deleteProfileDataDialogMessage => isEnglish
      ? 'Do you want to delete your profile information and assessment history? Your account will not be deleted.'
      : 'Profil bilgileriniz ve değerlendirme geçmişiniz silinsin mi? Hesabınız silinmez, sadece verileriniz temizlenir.';

  String get deleteProfileDataConfirm =>
      isEnglish ? 'Delete Data' : 'Verileri Sil';

  String get profileDataDeleted => isEnglish
      ? 'Profile and history data have been deleted.'
      : 'Profil ve geçmiş verileri silindi.';

  String get profileDataDeleteError => isEnglish
      ? 'An error occurred while deleting the data.'
      : 'Veriler silinirken bir hata oluştu.';

  String get session => isEnglish ? 'Session' : 'Oturum';

  String get logout => isEnglish ? 'Log Out' : 'Çıkış Yap';

  String get dangerZone => isEnglish ? 'Danger Zone' : 'Tehlikeli Bölge';

  String get deleteAccountWarning => isEnglish
      ? 'If you delete your account, your profile, assessment history, and account will be permanently deleted.'
      : 'Hesabınızı silerseniz profiliniz, değerlendirme geçmişiniz ve hesabınız kalıcı olarak silinir.';

  String get deleteAccount =>
      isEnglish ? 'Delete My Account Permanently' : 'Hesabımı Kalıcı Olarak Sil';

  String get deleteAccountDialogTitle =>
      isEnglish ? 'Delete Account Permanently' : 'Hesabı Kalıcı Olarak Sil';

  String get deleteAccountDialogMessage => isEnglish
      ? 'This action will delete your account and all application data. This action cannot be undone.'
      : 'Bu işlem hesabınızı ve tüm uygulama verilerinizi siler. Bu işlem geri alınamaz.';

  String get deleteAccountConfirm =>
      isEnglish ? 'Delete My Account' : 'Hesabımı Sil';

  String get accountDeleted =>
      isEnglish ? 'Your account has been deleted.' : 'Hesabınız silindi.';

  String get accountDeleteError => isEnglish
      ? 'An error occurred while deleting the account.'
      : 'Hesap silinirken bir hata oluştu.';
}
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

  String get commonCancel => isEnglish ? 'Cancel' : 'Vazgeç';
  String get commonDelete => isEnglish ? 'Delete' : 'Sil';
  String get commonUnknown => isEnglish ? 'Unknown' : 'Bilinmiyor';
  String get commonError => isEnglish ? 'An error occurred.' : 'Bir hata oluştu.';

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
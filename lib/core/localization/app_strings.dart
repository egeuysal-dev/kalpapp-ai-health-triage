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

        // Home Screen
  String get aboutApp => isEnglish ? 'About Application' : 'Uygulama Hakkında';

  String get quickActions => isEnglish ? 'Quick Actions' : 'Hızlı İşlemler';

  String get heartAssessment =>
      isEnglish ? 'Heart Assessment' : 'Kalp Değerlendirme';

  String get symptomAnalysis =>
      isEnglish ? 'Symptom analysis' : 'Semptom analizi';

  String get monitoredPeople =>
      isEnglish ? 'Monitored People' : 'Takip Ettiklerim';

  String get relativesAndWearable =>
      isEnglish ? 'Family and wearable' : 'Yakın ve bileklik';

  String get recordsAndAlerts =>
      isEnglish ? 'Records and Alerts' : 'Kayıtlar ve Uyarılar';

  String get lastAssessment =>
      isEnglish ? 'Last Assessment' : 'Son Değerlendirme';

  String get lastRiskResult =>
      isEnglish ? 'Last risk result' : 'Son risk sonucu';

  String get history => isEnglish ? 'History' : 'Geçmiş';

  String get riskRecords => isEnglish ? 'Risk records' : 'Risk kayıtları';

  String get braceletAlerts =>
      isEnglish ? 'Wearable Alerts' : 'Bileklik Uyarıları';

  String get alertHistory => isEnglish ? 'Alert history' : 'Uyarı geçmişi';

  String get braceletMonitoring =>
      isEnglish ? 'Wearable Monitoring' : 'Bileklik Takibi';

  String get liveDemoStatus =>
      isEnglish ? 'Live/demo status' : 'Canlı/demo durum';

  String get account => isEnglish ? 'Account' : 'Hesap';

  String get editProfile => isEnglish ? 'Edit Profile' : 'Profili Düzenle';

  String get updateInformation =>
      isEnglish ? 'Update information' : 'Bilgileri güncelle';

  String get profileSummary =>
      isEnglish ? 'Profile Summary' : 'Profil Özeti';

  String get savedInformation =>
      isEnglish ? 'Saved information' : 'Kayıtlı bilgiler';

  String get accountSecurity =>
      isEnglish ? 'Account Security' : 'Hesap Güvenliği';

  String get dataAndSession =>
      isEnglish ? 'Data and session' : 'Veri ve oturum';

  String get closeSession => isEnglish ? 'Close session' : 'Oturumu kapat';

  String get information => isEnglish ? 'Information' : 'Bilgilendirme';

  String get privacyAndKvkk =>
      isEnglish ? 'Privacy and Data Policy' : 'Gizlilik ve KVKK';

  String get dataPolicy => isEnglish ? 'Data policy' : 'Veri politikası';

  String get purposeAndVersion =>
      isEnglish ? 'Purpose and version' : 'Amaç ve sürüm';

  String welcomeUser(String fullName) {
    return isEnglish ? 'Welcome,\n$fullName' : 'Hoş geldiniz,\n$fullName';
  }

  String ageGender(int age, String gender) {
    return isEnglish ? 'Age: $age • $gender' : 'Yaş: $age • $gender';
  }

  String genderText(String gender) {
    if (!isEnglish) return gender;

    final normalized = gender.trim().toLowerCase();

    if (normalized == 'erkek') return 'Male';
    if (normalized == 'kadın' || normalized == 'kadin') return 'Female';

    return gender;
  }

  String get activeBraceletAlert =>
      isEnglish ? 'Active Wearable Alert' : 'Aktif Bileklik Uyarısı';

  String braceletAlertDetected(String fullName, String status) {
    return isEnglish
        ? '$status was detected for $fullName.'
        : '$fullName için ${status.toLowerCase()} algılandı.';
  }

  String get heartRate => isEnglish ? 'Heart rate' : 'Kalp ritmi';

  String get deviceId => isEnglish ? 'Device ID' : 'Cihaz ID';

  String get lastMeasurement =>
      isEnglish ? 'Last measurement' : 'Son ölçüm';

  String get openDetail => isEnglish ? 'Open Detail' : 'Detayı Aç';

  String get normalize => isEnglish ? 'Normalize' : 'Normalleştir';

  String get lastAssessmentLoading => isEnglish
      ? 'Last assessment is loading...'
      : 'Son değerlendirme yükleniyor...';

  String get noAssessmentYet => isEnglish
      ? 'No assessment has been completed yet. The first result will appear here.'
      : 'Henüz değerlendirme yapılmadı. İlk sonuç burada görünecek.';

  String scoreAndDate(Object score, String date) {
    return isEnglish ? 'Score: $score • $date' : 'Skor: $score • $date';
  }

  String get noSavedAssessment => isEnglish
      ? 'There is no saved assessment yet.'
      : 'Henüz kayıtlı değerlendirme yok.';

  String riskLevelText(String level) {
    if (!isEnglish) return level;

    switch (level) {
      case 'Kritik Risk':
        return 'Critical Risk';
      case 'Yüksek Risk':
        return 'High Risk';
      case 'Orta Risk':
        return 'Moderate Risk';
      case 'Düşük Risk':
        return 'Low Risk';
      default:
        return level;
    }
  }

  String braceletStatusText(String status) {
    if (!isEnglish) return status;

    switch (status) {
      case 'Kritik uyarı':
        return 'Critical alert';
      case 'Düşük kalp ritmi uyarısı':
        return 'Low heart rate alert';
      case 'Yüksek kalp ritmi uyarısı':
        return 'High heart rate alert';
      case 'Normal':
        return 'Normal';
      default:
        return status;
    }
  }

    // Symptom Screen
  String get symptomAssessmentTitle =>
      isEnglish ? 'Symptom Assessment' : 'Semptom Değerlendirme';

  String get symptomAssessmentSubtitle => isEnglish
      ? 'Write your symptoms, speak them, or select them manually.'
      : 'Semptomlarınızı yazın, konuşarak aktarın veya manuel olarak seçin.';

  String get seriousSymptomWarningTitle =>
      isEnglish ? 'Serious Symptom Warning' : 'Ciddi Belirti Uyarısı';

  String get seriousSymptomWarningMessage => isEnglish
      ? 'The symptoms you selected may be serious. In case of chest pain, shortness of breath, fainting feeling, cold sweating, or radiating pain, call emergency services without waiting for the application result.'
      : 'Seçtiğiniz belirtiler ciddi olabilir. Göğüs ağrısı, nefes darlığı, bayılma hissi, soğuk terleme veya yayılan ağrı durumunda uygulama sonucunu beklemeden 112 aranması önerilir.';

  String get emergencyWarningText => isEnglish
      ? 'If you have severe chest pain, shortness of breath, fainting feeling, cold sweating, or pain spreading to the arm/jaw, call emergency services without waiting for the application result.'
      : 'Şiddetli göğüs ağrısı, nefes darlığı, bayılma hissi, soğuk terleme veya kola/çeneye yayılan ağrı varsa uygulama sonucunu beklemeden 112’yi arayın.';

  String get call112 => isEnglish ? 'Call 112' : '112’yi Ara';

  String get viewResult => isEnglish ? 'View Result' : 'Sonucu Gör';

  String get writeOrSpeak => isEnglish ? 'Write or Speak' : 'Yaz veya Konuş';

  String get symptomDescription =>
      isEnglish ? 'Symptom description' : 'Semptom açıklaması';

  String get symptomInputHint => isEnglish
      ? 'Example: I have had chest pressure for 20 minutes, it spreads to my left arm and I feel short of breath.'
      : 'Örn: 20 dakikadır göğsümde baskı var, sol koluma vuruyor ve nefesim daralıyor';

  String get speak => isEnglish ? 'Speak' : 'Konuş';

  String get stopListening => isEnglish ? 'Stop' : 'Durdur';

  String get clearSymptomInput => isEnglish ? 'Clear' : 'Temizle';

  String get analyzeWithAi => isEnglish ? 'Analyze with AI' : 'AI ile Analiz Et';

  String get analyzingWithAi =>
      isEnglish ? 'Analyzing...' : 'Analiz Ediliyor...';

  String get symptomOptionsTitle =>
      isEnglish ? 'Symptom Options' : 'Semptom Seçenekleri';

  String get severityAndDuration =>
      isEnglish ? 'Severity and Duration' : 'Şiddet ve Süre';

  String get symptomDurationTitle =>
      isEnglish ? 'Symptom Duration' : 'Semptom Süresi';

  String get painSeverityTitle =>
      isEnglish ? 'Pain Severity' : 'Ağrı Şiddeti';

  String minutesValue(int minutes) {
    return isEnglish ? '$minutes minutes' : '$minutes dakika';
  }

  String painSeverityValue(int value) {
    return '$value / 10';
  }

  String get chestPainPressure =>
      isEnglish ? 'Chest pain / pressure' : 'Göğüs ağrısı / baskı';

  String get radiatingPain =>
      isEnglish ? 'Pain spreading to arm/jaw' : 'Kola/çeneye yayılan ağrı';

  String get shortnessOfBreathText =>
      isEnglish ? 'Shortness of breath' : 'Nefes darlığı';

  String get coldSweatingText =>
      isEnglish ? 'Cold sweating' : 'Soğuk terleme';

  String get nauseaText => isEnglish ? 'Nausea' : 'Mide bulantısı';

  String get dizzinessText => isEnglish ? 'Dizziness' : 'Baş dönmesi';

  String get faintingFeelingText =>
      isEnglish ? 'Fainting feeling' : 'Bayılma hissi';

  String get noSymptomSelected =>
      isEnglish ? 'No clear symptom selected' : 'Belirgin semptom seçilmedi';

  String get pleaseEnterSymptomText => isEnglish
      ? 'Please write or speak your symptom first.'
      : 'Lütfen önce semptomunuzu yazın veya konuşun.';

  String get manualSelection =>
      isEnglish ? 'Manual selection' : 'Manuel seçim';

  String get backendAiAnalysis =>
      isEnglish ? 'Backend AI analysis' : 'Backend AI analizi';

  String get localFallbackAnalysis =>
      isEnglish ? 'Local fallback analysis' : 'Yerel yedek analiz';

  String analysisSourceDisplay(String source) {
    if (source == 'Backend AI analizi') return backendAiAnalysis;
    if (source == 'Yerel yedek analiz') return localFallbackAnalysis;
    if (source == 'Manuel seçim') return manualSelection;

    return source;
  }

  String get analysisSourcePrefix =>
      isEnglish ? 'Analysis source' : 'Analiz kaynağı';

  String get micUnavailablePermission => isEnglish
      ? 'Microphone is unavailable. Please check microphone permission.'
      : 'Mikrofon kullanılamıyor. Lütfen mikrofon iznini kontrol edin.';

  String get noSpeechDetectedShort =>
      isEnglish ? 'No speech was detected. Please try again.' : 'Ses algılanamadı. Tekrar deneyin.';

  String get noSpeechDetectedLong => isEnglish
      ? 'No speech was detected. Please try again and start speaking right after pressing the button.'
      : 'Ses algılanamadı. Tekrar deneyin ve butona bastıktan hemen sonra konuşun.';

  String microphoneError(String error) {
    return isEnglish ? 'Microphone error: $error' : 'Mikrofon hatası: $error';
  }

  String get call112EmulatorError => isEnglish
      ? '112 call could not be started. This may be normal on an emulator.'
      : '112 araması başlatılamadı. Emülatörde bu normal olabilir.';

  String get call112DeviceError => isEnglish
      ? 'The call could not be started. Please try again on a real phone.'
      : 'Arama başlatılamadı. Gerçek telefonda tekrar deneyin.';

  String get backendUnavailableFallback => isEnglish
      ? 'Backend could not be reached. Continued with local analysis.'
      : 'Backend’e ulaşılamadı. Yerel analiz ile devam edildi.';

  String get symptomTextAnalyzed =>
      isEnglish ? 'Symptom text has been analyzed.' : 'Semptom metni analiz edildi.';

  String analysisError(Object error) {
    return isEnglish
        ? 'An error occurred during analysis: $error'
        : 'Analiz sırasında hata oluştu: $error';
  }

  String speechStatusDisplay(String status) {
    if (!isEnglish) return status;

    if (status == 'Mikrofon hazırlanıyor...') {
      return 'Preparing microphone...';
    }

    if (status == 'Mikrofon hazır') {
      return 'Microphone ready';
    }

    if (status == 'Dinleniyor...') {
      return 'Listening...';
    }

    if (status == 'Dinleme durdu') {
      return 'Listening stopped';
    }

    if (status == 'Konuşma tanıma bu cihazda kullanılamıyor') {
      return 'Speech recognition is not available on this device';
    }

    if (status == 'Konuşma tanıma başlatılamadı') {
      return 'Speech recognition could not be started';
    }

    if (status.startsWith('Mikrofon hatası:')) {
      final detail = status.replaceFirst('Mikrofon hatası:', '').trim();
      return 'Microphone error: $detail';
    }

    return status;
  }

    // Result Screen
  String get resultScreenTitle =>
      isEnglish ? 'Assessment Result' : 'Değerlendirme Sonucu';

  String get resultMessageTitle =>
      isEnglish ? 'Result Message' : 'Sonuç Mesajı';

  String get noResultMessage =>
      isEnglish ? 'No result message found.' : 'Sonuç mesajı bulunmuyor.';

  String get analysisInformation =>
      isEnglish ? 'Analysis Information' : 'Analiz Bilgileri';

  String get riskScore => isEnglish ? 'Risk Score' : 'Risk Skoru';

  String get notSpecified => isEnglish ? 'Not specified' : 'Belirtilmedi';

  String get actionLevel => isEnglish ? 'Action Level' : 'Aksiyon Seviyesi';

  String get symptomSummaryTitle =>
      isEnglish ? 'Symptom Summary' : 'Semptom Özeti';

  String get noSymptomSummary =>
      isEnglish ? 'No symptom summary found.' : 'Semptom özeti bulunmuyor.';

  String get riskReasonsTitle =>
      isEnglish ? 'Risk Reasons' : 'Risk Nedenleri';

  String get noRiskReason =>
      isEnglish ? 'No risk reason specified.' : 'Risk nedeni belirtilmedi.';

  String get emergencyActions =>
      isEnglish ? 'Emergency Actions' : 'Acil Durum İşlemleri';

  String get emergencyDisclaimer => isEnglish
      ? 'If serious symptoms are present, call 112 without spending time interpreting the result. This application does not provide diagnosis and does not replace emergency medical services.'
      : 'Ciddi belirti varsa sonucu yorumlamakla vakit kaybetmeden 112 aranmalıdır. Bu uygulama tanı koymaz ve acil sağlık hizmetlerinin yerine geçmez.';

  String get emergencyContact =>
      isEnglish ? 'Emergency Contact' : 'Acil Kişi';

  String get emergencyContactPhone =>
      isEnglish ? 'Emergency contact phone' : 'Acil kişi telefonu';

  String get emergencyPhoneMissing => isEnglish
      ? 'Emergency contact phone is not saved.'
      : 'Acil kişi telefonu kayıtlı değil.';

  String get emergencyContactCallFailed => isEnglish
      ? 'Emergency contact call could not be started.'
      : 'Acil kişi araması başlatılamadı.';

  String get goBack => isEnglish ? 'Go Back' : 'Geri Dön';

  String get save => isEnglish ? 'Save' : 'Kaydet';

  String get resultSaving =>
      isEnglish ? 'Saving result...' : 'Sonuç kaydediliyor...';

  String get resultSaved =>
      isEnglish ? 'Result saved to history.' : 'Sonuç geçmişe kaydedildi.';

  String get resultNotSaved =>
      isEnglish ? 'Result could not be saved.' : 'Sonuç kaydedilemedi.';

  String get resultSaveError => isEnglish
      ? 'An error occurred while saving the result.'
      : 'Sonuç kaydedilirken bir hata oluştu.';

  String get actionLevelNotSpecified => isEnglish
      ? 'Action level not specified'
      : 'Aksiyon seviyesi belirtilmedi';

  String riskScoreValue(int score) {
    return isEnglish ? 'Risk Score: $score' : 'Risk Skoru: $score';
  }

  String resultMessageText(String message) {
    if (!isEnglish) return message;

    switch (message) {
      case 'Belirtileriniz ciddi olabilir. Beklemeden 112 aranması önerilir.':
        return 'Your symptoms may be serious. Calling 112 immediately is recommended.';
      case 'Kalp krizi ile uyumlu olabilecek belirtiler mevcut. Acil tıbbi yardım alınması önerilir.':
        return 'Some symptoms may be consistent with a heart attack. Urgent medical assistance is recommended.';
      case 'Önemli belirtiler mevcut. Kısa sürede tıbbi değerlendirme önerilir.':
        return 'Important symptoms are present. Medical evaluation soon is recommended.';
      case 'Mevcut belirtiler düşük riskli görünüyor. Şikayetler sürerse sağlık kuruluşuna başvurun.':
        return 'Current symptoms appear to be low risk. If complaints continue, contact a healthcare facility.';
      default:
        return message;
    }
  }

  String actionLevelText(String level) {
    if (!isEnglish) return level;

    switch (level) {
      case 'Acil Eylem Gerekli':
        return 'Immediate Action Required';
      case 'Bugün Acil Değerlendirme':
        return 'Urgent Evaluation Today';
      case 'Yakın Sürede Doktor Görüşü':
        return 'Doctor Consultation Soon';
      case 'Takip ve Gözlem':
        return 'Follow-up and Observation';
      default:
        return level;
    }
  }

  String riskReasonText(String reason) {
    if (!isEnglish) return reason;

    switch (reason) {
      case 'Göğüs ağrısı/baskı bildirildi.':
        return 'Chest pain/pressure was reported.';
      case 'Ağrının kola, sırta, boyna veya çeneye yayılması bildirildi.':
        return 'Pain spreading to the arm, back, neck, or jaw was reported.';
      case 'Nefes darlığı bildirildi.':
        return 'Shortness of breath was reported.';
      case 'Soğuk terleme bildirildi.':
        return 'Cold sweating was reported.';
      case 'Mide bulantısı bildirildi.':
        return 'Nausea was reported.';
      case 'Baş dönmesi bildirildi.':
        return 'Dizziness was reported.';
      case 'Bayılma hissi bildirildi.':
        return 'Fainting feeling was reported.';
      case 'Semptom süresi 30 dakika veya daha fazla.':
        return 'Symptom duration is 30 minutes or more.';
      case 'Semptom süresi 15 dakikadan fazla.':
        return 'Symptom duration is more than 15 minutes.';
      case 'Semptomlar birkaç dakikadır sürüyor.':
        return 'Symptoms have been continuing for several minutes.';
      case 'Ağrı şiddeti çok yüksek.':
        return 'Pain severity is very high.';
      case 'Ağrı şiddeti belirgin düzeyde.':
        return 'Pain severity is significant.';
      case 'İleri yaş ek risk oluşturuyor.':
        return 'Advanced age creates additional risk.';
      case '50 yaş üzeri olmak riski artırıyor.':
        return 'Being over 50 increases the risk.';
      case 'Daha önce kalp krizi öyküsü var.':
        return 'There is a previous heart attack history.';
      case 'Kalp hastalığı öyküsü var.':
        return 'There is a history of heart disease.';
      case 'Hipertansiyon öyküsü var.':
        return 'There is a history of hypertension.';
      case 'Diyabet öyküsü var.':
        return 'There is a history of diabetes.';
      case 'Yüksek kolesterol öyküsü var.':
        return 'There is a history of high cholesterol.';
      case 'Sigara kullanımı bildirildi.':
        return 'Smoking was reported.';
      case 'Göğüs ağrısı + yayılan ağrı + nefes darlığı kritik kombinasyon olarak değerlendirildi.':
        return 'Chest pain + radiating pain + shortness of breath was evaluated as a critical combination.';
      case 'Göğüs ağrısı + soğuk terleme + mide bulantısı birlikte görüldü.':
        return 'Chest pain + cold sweating + nausea were seen together.';
      case 'Bayılma hissi ve nefes darlığı birlikte bildirildi.':
        return 'Fainting feeling and shortness of breath were reported together.';
      default:
        return reason;
    }
  }

      // History Screen
  String get historyScreenTitle =>
      isEnglish ? 'Assessment History' : 'Geçmiş Değerlendirmeler';

  String get historyInfoMessage => isEnglish
      ? 'This screen lists previous symptom assessments together with risk score, action level, and analysis source.'
      : 'Bu ekranda önceki semptom değerlendirmeleri, risk skoru, aksiyon seviyesi ve analiz kaynağı ile birlikte listelenir.';

  String get clearAllHistory =>
      isEnglish ? 'Clear All History' : 'Tüm Geçmişi Sil';

  String get assessmentHistoryCleared => isEnglish
      ? 'Assessment history has been cleared.'
      : 'Geçmiş değerlendirmeler silindi.';

  String get emptyHistoryTitle =>
      isEnglish ? 'No assessment history yet.' : 'Henüz kayıtlı değerlendirme yok.';

  String get emptyHistoryMessage => isEnglish
      ? 'After completing a new assessment, your previous records will appear here.'
      : 'Yeni bir değerlendirme yaptıktan sonra geçmiş kayıtların burada görünecek.';

  String get dateLabel => isEnglish ? 'Date' : 'Tarih';

  String get errorOccurredPrefix =>
      isEnglish ? 'An error occurred' : 'Bir hata oluştu';

  String historyCardSubtitle({
    required int score,
    required String action,
    required String source,
    required String date,
  }) {
    return isEnglish
        ? 'Score: $score\n'
            'Action: $action\n'
            'Source: $source\n'
            'Date: $date'
        : 'Skor: $score\n'
            'Aksiyon: $action\n'
            'Kaynak: $source\n'
            'Tarih: $date';
  }


    // Bracelet Alert History Screen
  String get braceletAlertHistoryTitle =>
      isEnglish ? 'Wearable Alert History' : 'Bileklik Uyarı Geçmişi';

  String get braceletAlertSummary =>
      isEnglish ? 'Wearable Alert Summary' : 'Bileklik Uyarı Özeti';

  String get totalAlerts => isEnglish ? 'Total' : 'Toplam';

  String get criticalAlertShort => isEnglish ? 'Critical' : 'Kritik';

  String get lowRhythmShort => isEnglish ? 'Low' : 'Düşük';

  String get highRhythmShort => isEnglish ? 'High' : 'Yüksek';

  String latestBraceletAlert({
    required String personName,
    required String alertType,
    required int heartRate,
  }) {
    return isEnglish
        ? 'Latest alert: $personName • ${shortBraceletAlertTitle(alertType)} • $heartRate bpm'
        : 'Son uyarı: $personName • ${shortBraceletAlertTitle(alertType)} • $heartRate bpm';
  }

  String get braceletAlertInfoMessage => isEnglish
      ? 'This screen records alert events from the virtual wearable. In the real product, these records would be generated by live sensor data from the device.'
      : 'Bu ekran, sanal bileklikten gelen uyarı olaylarını kaydeder. Gerçek üründe bu kayıtlar cihazdan gelen canlı sensör verileriyle oluşur.';

  String get clearBraceletAlertHistory =>
      isEnglish ? 'Clear Alert History' : 'Uyarı Geçmişini Sil';

  String get clearBraceletAlertDialogTitle =>
      isEnglish ? 'Clear Alert History' : 'Uyarı Geçmişini Sil';

  String get clearBraceletAlertDialogMessage => isEnglish
      ? 'Do you want to clear all wearable alert history?'
      : 'Tüm bileklik uyarı geçmişi silinsin mi?';

  String get braceletAlertHistoryCleared => isEnglish
      ? 'Wearable alert history has been cleared.'
      : 'Bileklik uyarı geçmişi silindi.';

  String get braceletAlertMessageMissing => isEnglish
      ? 'No alert description found.'
      : 'Uyarı açıklaması bulunmuyor.';

  String get braceletAlertEmptyTitle => isEnglish
      ? 'No wearable alerts yet.'
      : 'Henüz bileklik uyarısı yok.';

  String get braceletAlertEmptyMessage => isEnglish
      ? 'When you create a low, high, or critical rhythm simulation from the Monitored People screen, records will appear here.'
      : 'Takip Ettiklerim ekranından düşük, yüksek veya kritik ritim simülasyonu oluşturduğunuzda kayıtlar burada görünür.';

  String get braceletAlertLoadError => isEnglish
      ? 'An error occurred while loading alert history'
      : 'Uyarı geçmişi yüklenirken hata oluştu';

  String shortBraceletAlertTitle(String type) {
    if (!isEnglish) {
      if (type == 'Kritik uyarı') return 'Kritik';
      if (type == 'Düşük kalp ritmi uyarısı') return 'Düşük Ritim';
      if (type == 'Yüksek kalp ritmi uyarısı') return 'Yüksek Ritim';

      return type;
    }

    if (type == 'Kritik uyarı') return 'Critical';
    if (type == 'Düşük kalp ritmi uyarısı') return 'Low Rhythm';
    if (type == 'Yüksek kalp ritmi uyarısı') return 'High Rhythm';

    return type;
  }

  String braceletAlertBadgeText(String type) {
    if (isEnglish) {
      return type == 'Kritik uyarı' ? 'URGENT' : 'ALERT';
    }

    return type == 'Kritik uyarı' ? 'ACİL' : 'UYARI';
  }

  String braceletAlertMessageText(String message) {
    if (!isEnglish) return message;

    switch (message) {
      case 'Bileklik düşük kalp ritmi algıladı. Kişinin durumu kontrol edilmelidir.':
        return 'The wearable detected a low heart rhythm. The person should be checked.';
      case 'Bileklik yüksek kalp ritmi algıladı. Aktivite, stres veya tıbbi durum açısından kontrol önerilir.':
        return 'The wearable detected a high heart rhythm. Checking activity, stress, or possible medical conditions is recommended.';
      case 'Bileklik kritik kalp ritmi algıladı. Kişi hemen kontrol edilmeli; bilinç kaybı, göğüs ağrısı veya nefes darlığı varsa 112 aranmalıdır.':
        return 'The wearable detected a critical heart rhythm. The person should be checked immediately; if there is loss of consciousness, chest pain, or shortness of breath, 112 should be called.';
      default:
        return message;
    }
  }

    // Monitored People Screen
  String get monitoredPeopleHeaderTitle => isEnglish
      ? 'Family and Wearable Monitoring'
      : 'Yakın ve Bileklik Takibi';

  String get monitoredPeopleHeaderMessage => isEnglish
      ? 'Track family members with virtual wearable device IDs. In demo mode, you can simulate rhythm alerts.'
      : 'Kalp hastalığı riski taşıyan yakınlarınızı sanal bileklik kimliğiyle takip edin. Demo modunda ritim uyarılarını simüle edebilirsiniz.';

  String get addMonitoredPerson =>
      isEnglish ? 'Add Person' : 'Yakın Ekle';

  String get deleteMonitoredPersonTitle =>
      isEnglish ? 'Delete Person' : 'Yakını Sil';

  String deleteMonitoredPersonMessage(String fullName) {
    return isEnglish
        ? 'Delete $fullName and the connected virtual wearable record?'
        : '$fullName ve bağlı sanal bileklik kaydı silinsin mi?';
  }

  String get monitoredPersonDeleted =>
      isEnglish ? 'Person record deleted.' : 'Yakın kaydı silindi.';

  String get monitoredPeopleLoadError => isEnglish
      ? 'An error occurred while loading monitored people'
      : 'Takip edilen yakınlar yüklenirken hata oluştu';

  String get monitoredPeopleEmptyTitle => isEnglish
      ? 'No monitored person yet.'
      : 'Henüz takip edilen yakın yok.';

  String get monitoredPeopleEmptyMessage => isEnglish
      ? 'You can start demo monitoring by adding a family member and a virtual wearable device ID.'
      : 'Bir yakınınızı ve ona ait sanal bileklik cihaz kimliğini ekleyerek demo takibe başlayabilirsiniz.';

  String get statusLabel => isEnglish ? 'Status' : 'Durum';

  String get deviceLabel => isEnglish ? 'Device' : 'Cihaz';

  String get detail => isEnglish ? 'Detail' : 'Detay';

  String get critical => isEnglish ? 'Critical' : 'Kritik';

  String get low => isEnglish ? 'Low' : 'Düşük';

  String get high => isEnglish ? 'High' : 'Yüksek';

  String relationAgeGender({
    required String relation,
    required int age,
    required String gender,
  }) {
    final displayedGender = genderText(gender);

    return isEnglish
        ? '$relation • $age years old • $displayedGender'
        : '$relation • $age yaş • $displayedGender';
  }

  String shortPersonStatusText(String status) {
    if (!isEnglish) {
      if (status == 'Kritik uyarı') return 'Kritik';
      if (status == 'Düşük kalp ritmi uyarısı') return 'Düşük Ritim';
      if (status == 'Yüksek kalp ritmi uyarısı') return 'Yüksek Ritim';
      if (status == 'Normal') return 'Normal';

      return status;
    }

    if (status == 'Kritik uyarı') return 'Critical';
    if (status == 'Düşük kalp ritmi uyarısı') return 'Low Rhythm';
    if (status == 'Yüksek kalp ritmi uyarısı') return 'High Rhythm';
    if (status == 'Normal') return 'Normal';

    return status;
  }

    // Add Monitored Person Screen
  String get addMonitoredPersonScreenTitle =>
      isEnglish ? 'Add Person / Wearable' : 'Yakın / Bileklik Ekle';

  String get addMonitoredPersonHeaderTitle =>
      isEnglish ? 'Add Person and Wearable' : 'Yakın ve Bileklik Ekle';

  String get addMonitoredPersonHeaderMessage => isEnglish
      ? 'Create a virtual wearable profile for a family member who may carry heart-related risk.'
      : 'Kalp hastalığı riski taşıyan yakınınız için sanal bileklik profili oluşturun.';

  String get addMonitoredPersonDemoInfo => isEnglish
      ? 'In this prototype, a demo device ID is used instead of a physical wearable. In the real product, this ID would be matched with live sensor data from the wearable.'
      : 'Bu prototipte fiziksel bileklik yerine demo cihaz kimliği kullanılır. Gerçek üründe bu kimlik, bileklikten gelen canlı sensör verileriyle eşleştirilecektir.';

  String get personInformation =>
      isEnglish ? 'Person Information' : 'Yakın Bilgileri';

  String get fullNameLabel => isEnglish ? 'Full Name' : 'Ad Soyad';

  String get relationLabel =>
      isEnglish ? 'Relationship' : 'Yakınlık Derecesi';

  String get relationHint =>
      isEnglish ? 'Example: Grandfather, Mother, Father' : 'Örn: Dede, Anne, Baba';

  String get ageLabel => isEnglish ? 'Age' : 'Yaş';

  String get genderLabel => isEnglish ? 'Gender' : 'Cinsiyet';

  String get male => isEnglish ? 'Male' : 'Erkek';

  String get female => isEnglish ? 'Female' : 'Kadın';

  String get braceletInformation =>
      isEnglish ? 'Wearable Information' : 'Bileklik Bilgileri';

  String get demoBraceletId =>
      isEnglish ? 'Demo Wearable ID' : 'Demo Bileklik Kimliği';

  String get createNewDemoDeviceId => isEnglish
      ? 'Create New Demo Device ID'
      : 'Yeni Demo Cihaz Kimliği Oluştur';

  String get createNewDeviceIdTooltip => isEnglish
      ? 'Create new device ID'
      : 'Yeni cihaz kimliği oluştur';

  String get deviceIdLabel =>
      isEnglish ? 'Device ID' : 'Cihaz Kimliği';

  String get deviceIdHint =>
      isEnglish ? 'Example: KAPP-83721' : 'Örn: KAPP-83721';

  String get riskHistory =>
      isEnglish ? 'Risk History' : 'Risk Geçmişi';

  String get previousHeartAttackTitle => isEnglish
      ? 'Previous heart attack'
      : 'Daha önce kalp krizi geçirdi';

  String get previousHeartAttackSubtitle => isEnglish
      ? 'History of previous heart attack'
      : 'Önceki kalp krizi öyküsü';

  String get heartDiseaseTitle =>
      isEnglish ? 'Heart disease' : 'Kalp hastalığı var';

  String get heartDiseaseSubtitle => isEnglish
      ? 'Diagnosed heart disease'
      : 'Tanı almış kalp hastalığı';

  String get hypertensionTitle =>
      isEnglish ? 'Hypertension' : 'Hipertansiyon var';

  String get hypertensionSubtitle =>
      isEnglish ? 'History of high blood pressure' : 'Yüksek tansiyon öyküsü';

  String get diabetesTitle =>
      isEnglish ? 'Diabetes' : 'Diyabet var';

  String get diabetesSubtitle =>
      isEnglish ? 'History of diabetes' : 'Şeker hastalığı öyküsü';

  String get highCholesterolTitle =>
      isEnglish ? 'High cholesterol' : 'Yüksek kolesterol var';

  String get highCholesterolSubtitle =>
      isEnglish ? 'History of high cholesterol' : 'Kolesterol yüksekliği';

  String get smokingTitle =>
      isEnglish ? 'Smoking' : 'Sigara kullanıyor';

  String get smokingSubtitle =>
      isEnglish ? 'Smoking is a risk factor' : 'Sigara kullanımı risk faktörüdür';

  String get medicationsLabel =>
      isEnglish ? 'Medications' : 'Kullandığı İlaçlar';

  String get medicationsHint => isEnglish
      ? 'Example: Blood pressure medication, blood thinner...'
      : 'Örn: Tansiyon ilacı, kan sulandırıcı...';

  String get savingPerson =>
      isEnglish ? 'Saving...' : 'Kaydediliyor...';

  String get savePersonAndWearable => isEnglish
      ? 'Save Person and Wearable'
      : 'Yakını ve Bilekliği Kaydet';

  String get monitoredPersonAddSuccess => isEnglish
      ? 'Person and virtual wearable were added successfully.'
      : 'Yakın ve sanal bileklik başarıyla eklendi.';

  String get monitoredPersonAddError => isEnglish
      ? 'An error occurred while adding the person.'
      : 'Yakın eklenirken bir hata oluştu.';

  String get monitoredPersonFormInvalid => isEnglish
      ? 'Please fix the missing or incorrect fields in the form.'
      : 'Lütfen formdaki eksik veya hatalı alanları düzeltin.';

  String get monitoredPersonNameRequired => isEnglish
      ? 'The person name is required.'
      : 'Yakınınızın adı zorunludur.';

  String get monitoredPersonNameMinLength => isEnglish
      ? 'Name must be at least 3 characters.'
      : 'Ad en az 3 karakter olmalıdır.';

  String get monitoredPersonRelationRequired => isEnglish
      ? 'Relationship is required.'
      : 'Yakınlık derecesi zorunludur.';

  String get monitoredPersonAgeRequired =>
      isEnglish ? 'Age is required.' : 'Yaş zorunludur.';

  String get monitoredPersonAgeInvalid =>
      isEnglish ? 'Please enter a valid age.' : 'Geçerli bir yaş girin.';

  String get monitoredPersonAgeRange => isEnglish
      ? 'Age must be between 1 and 120.'
      : 'Yaş 1 ile 120 arasında olmalıdır.';

  String get monitoredPersonDeviceRequired =>
      isEnglish ? 'Device ID is required.' : 'Cihaz kimliği zorunludur.';

  String get monitoredPersonDeviceTooShort =>
      isEnglish ? 'Device ID is too short.' : 'Cihaz kimliği çok kısa.';

  String riskProfileSummary({
    required int riskCount,
  }) {
    String message;

    if (riskCount >= 4) {
      message = isEnglish ? 'High risk profile' : 'Yüksek risk profili';
    } else if (riskCount >= 2) {
      message = isEnglish ? 'Moderate risk profile' : 'Orta risk profili';
    } else if (riskCount == 1) {
      message = isEnglish ? 'Low/moderate risk profile' : 'Düşük/orta risk profili';
    } else {
      message = isEnglish
          ? 'No clear risk factor selected'
          : 'Belirgin risk faktörü seçilmedi';
    }

    return isEnglish
        ? '$message • Selected risk factors: $riskCount'
        : '$message • Seçilen risk faktörü: $riskCount';
  }

      // Monitored Person Detail Screen
  String get connection => isEnglish ? 'Connection' : 'Bağlantı';

  String get demoActive => isEnglish ? 'Demo active' : 'Demo aktif';

  String get dataType => isEnglish ? 'Data Type' : 'Veri Tipi';

  String get heartRateSimulation =>
      isEnglish ? 'Heart rate simulation' : 'Kalp ritmi simülasyonu';

  String get wearablePrototypeInfo => isEnglish
      ? 'In this prototype, the physical wearable is simulated. In the real product, the device ID would be matched with live sensor data from the physical wearable.'
      : 'Bu prototipte fiziksel bileklik simüle edilmektedir. Gerçek üründe cihaz ID, fiziksel bileklikten gelen canlı sensör verileriyle eşleşir.';

  String get noClearRiskFactor =>
      isEnglish ? 'No clear risk factor' : 'Belirgin risk faktörü yok';

  String selectedRiskFactorCount(int count) {
    return isEnglish
        ? 'Selected risk factors: $count'
        : 'Seçili risk faktörü: $count';
  }

  String get yes => isEnglish ? 'Yes' : 'Evet';

  String get no => isEnglish ? 'No' : 'Hayır';

  String get medicationsPrefix =>
      isEnglish ? 'Medications' : 'İlaçlar';

  String get demoSimulation =>
      isEnglish ? 'Demo Simulation' : 'Demo Simülasyon';

  String get demoSimulationMessage => isEnglish
      ? 'During the presentation, you can simulate different heart rhythm states as if data were coming from a physical wearable.'
      : 'Sunum sırasında fiziksel bileklikten veri geliyormuş gibi farklı kalp ritmi durumları oluşturabilirsiniz.';

  String get simulateCriticalAlert =>
      isEnglish ? 'Simulate Critical Alert' : 'Kritik Uyarı Simüle Et';

  String get realUseEmergencyInfo => isEnglish
      ? 'In real use, when a critical rhythm alert is received, the person should be checked. If there is loss of consciousness, chest pain, or shortness of breath, 112 should be called.'
      : 'Gerçek kullanımda kritik ritim uyarısı alındığında kişi kontrol edilmeli; bilinç kaybı, göğüs ağrısı veya nefes darlığı varsa 112 aranmalıdır.';

  String riskFactorLabel(String label) {
    if (!isEnglish) return label;

    switch (label) {
      case 'Önceki Kalp Krizi':
        return 'Previous Heart Attack';
      case 'Kalp Hastalığı':
        return 'Heart Disease';
      case 'Hipertansiyon':
        return 'Hypertension';
      case 'Diyabet':
        return 'Diabetes';
      case 'Yüksek Kolesterol':
        return 'High Cholesterol';
      case 'Sigara':
        return 'Smoking';
      default:
        return label;
    }
  }

      // Profile Screen
  String get createProfile =>
      isEnglish ? 'Create Profile' : 'Profil Oluştur';

  String get editProfileTitle =>
      isEnglish ? 'Edit Profile' : 'Profili Düzenle';

  String get personalInformation =>
      isEnglish ? 'Personal Information' : 'Kişisel Bilgiler';

  String get healthHistory =>
      isEnglish ? 'Health History' : 'Sağlık Geçmişi';

  String get emergencyContactInformation =>
      isEnglish ? 'Emergency Contact Information' : 'Acil Kişi Bilgileri';

  String get profileNameRequired =>
      isEnglish ? 'Full name is required.' : 'Ad soyad zorunludur.';

  String get profileNameMinLength => isEnglish
      ? 'Full name must be at least 3 characters.'
      : 'Ad soyad en az 3 karakter olmalıdır.';

  String get profileAgeRequired =>
      isEnglish ? 'Age is required.' : 'Yaş zorunludur.';

  String get profileAgeInvalid =>
      isEnglish ? 'Please enter a valid age.' : 'Geçerli bir yaş girin.';

  String get profileAgeRange => isEnglish
      ? 'Age must be between 1 and 120.'
      : 'Yaş 1 ile 120 arasında olmalıdır.';

  String get emergencyPhoneTooShort => isEnglish
      ? 'The phone number looks too short.'
      : 'Telefon numarası çok kısa görünüyor.';

  String get profileFormInvalid => isEnglish
      ? 'Please fix the errors in the form.'
      : 'Lütfen formdaki hataları düzeltin.';

  String get profileSaveError => isEnglish
      ? 'An error occurred while saving the profile.'
      : 'Profil kaydedilirken bir hata oluştu.';

  String get previousHeartAttackPersonal =>
      isEnglish ? 'I had a previous heart attack' : 'Daha önce kalp krizi geçirdim';

  String get heartDiseasePersonal =>
      isEnglish ? 'I have heart disease' : 'Kalp hastalığım var';

  String get hypertensionPersonal =>
      isEnglish ? 'I have hypertension' : 'Hipertansiyonum var';

  String get diabetesPersonal =>
      isEnglish ? 'I have diabetes' : 'Diyabetim var';

  String get highCholesterolPersonal =>
      isEnglish ? 'I have high cholesterol' : 'Kolesterol yüksekliğim var';

  String get smokingPersonal =>
      isEnglish ? 'I smoke' : 'Sigara kullanıyorum';

  String get medicationsPersonalLabel =>
      isEnglish ? 'Medications you use' : 'Kullandığınız ilaçlar';

  String get emergencyContactName =>
      isEnglish ? 'Emergency Contact Name' : 'Acil Kişi Adı';

  String get phoneNumber =>
      isEnglish ? 'Phone Number' : 'Telefon Numarası';

  String get emergencyRelationHint => isEnglish
      ? 'Relationship, such as mother or friend'
      : 'Yakınlık (Anne, Arkadaş vs.)';

  String get saveChanges =>
      isEnglish ? 'Save Changes' : 'Değişiklikleri Kaydet';

  String get saveProfile =>
      isEnglish ? 'Save Profile' : 'Profili Kaydet';

        // About Screen
  String get aboutHeaderSubtitle => isEnglish
      ? 'AI and wearable-supported early warning platform'
      : 'Yapay zeka ve akıllı bileklik destekli erken uyarı platformu';

  String aboutVersionText(String version) {
    return isEnglish
        ? 'Version $version • Development Build'
        : 'Sürüm $version • Geliştirme Sürümü';
  }

  String get aboutPurposeTitle =>
      isEnglish ? 'Application Purpose' : 'Uygulamanın Amacı';

  String get aboutPurposeText => isEnglish
      ? 'KalpAPP was developed to help users quickly evaluate symptoms that may suggest a heart attack risk.\n\n'
          'The user can select symptoms manually, write them as text, or enter them by speaking. The application evaluates these inputs using a rule-based risk engine and an AI-assisted symptom parsing system.'
      : 'KalpAPP, kalp krizi şüphesi oluşturabilecek belirtilerin kullanıcı tarafından hızlıca değerlendirilmesine yardımcı olmak amacıyla geliştirilmiştir.\n\n'
          'Kullanıcı; semptomlarını elle seçebilir, metin olarak yazabilir veya konuşarak giriş yapabilir. Uygulama bu verileri kural tabanlı risk motoru ve yapay zeka destekli semptom ayrıştırma sistemiyle değerlendirir.';

  String get aboutWearableTrackingTitle =>
      isEnglish ? 'Smart Wearable Monitoring' : 'Akıllı Bileklik Takibi';

  String get aboutWearableTrackingText => isEnglish
      ? 'KalpAPP is not only an individual symptom assessment application. It is also designed as an early warning platform that aims to monitor family members with heart-related risk through a smart wearable-like device.\n\n'
          'In this prototype, a virtual/demo wearable system is used instead of a physical device. The user can add a unique device ID for a family member and monitor heart rhythm status inside the application.\n\n'
          'In the real product, this device ID would be matched with heart rhythm and sensor data coming from a physical wearable.'
      : 'KalpAPP yalnızca bireysel semptom değerlendirme uygulaması değildir. Uygulama aynı zamanda kalp hastalığı riski taşıyan yakınların akıllı bileklik benzeri bir cihazla takip edilmesini hedefleyen bir erken uyarı platformu olarak tasarlanmıştır.\n\n'
          'Bu prototipte fiziksel bileklik yerine sanal/demo bileklik sistemi kullanılmaktadır. Kullanıcı, yakını için benzersiz bir cihaz kimliği ekleyebilir ve bu kişiye ait kalp ritmi durumlarını uygulama içinde takip edebilir.\n\n'
          'Gerçek üründe bu cihaz kimliği, fiziksel bileklikten gelen kalp ritmi ve sensör verileriyle eşleştirilecektir.';

  String get aboutFamilyMonitoringTitle =>
      isEnglish ? 'Family Monitoring System' : 'Yakın Takip Sistemi';

  String get aboutFamilyMonitoringText => isEnglish
      ? 'Through the Monitored People section, the user can create a profile for a grandfather, mother, father, or another family member who may carry heart-related risk.\n\n'
          'This profile can store information such as age, gender, relationship, device ID, disease history, previous heart attack history, hypertension, diabetes, cholesterol, and medications.\n\n'
          'In demo mode, low heart rhythm, high heart rhythm, and critical alert scenarios can be simulated.'
      : 'Takip Ettiklerim bölümü sayesinde kullanıcı; dedesi, annesi, babası veya kalp hastalığı riski taşıyan başka bir yakını için profil oluşturabilir.\n\n'
          'Bu profilde kişinin yaşı, cinsiyeti, yakınlık derecesi, cihaz kimliği, hastalık geçmişi, kalp krizi öyküsü, hipertansiyon, diyabet, kolesterol ve kullanılan ilaçlar gibi bilgiler saklanabilir.\n\n'
          'Demo modunda düşük kalp ritmi, yüksek kalp ritmi ve kritik uyarı senaryoları simüle edilebilir.';

  String get aboutWearableAlertHistoryTitle =>
      isEnglish ? 'Wearable Alert History' : 'Bileklik Uyarı Geçmişi';

  String get aboutWearableAlertHistoryText => isEnglish
      ? 'The application can save low rhythm, high rhythm, and critical rhythm alerts generated through the virtual wearable.\n\n'
          'This allows the user to view not only the instant alert, but also previous wearable events inside the application.\n\n'
          'In the real product, these records would be generated from live measurement data coming from the physical device.'
      : 'Uygulama, sanal bileklik üzerinden oluşan düşük ritim, yüksek ritim ve kritik ritim uyarılarını geçmişe kaydedebilir.\n\n'
          'Bu sayede kullanıcı sadece anlık uyarıyı değil, geçmişte oluşan bileklik olaylarını da uygulama içinden görüntüleyebilir.\n\n'
          'Gerçek üründe bu kayıtlar, fiziksel cihazdan gelen canlı ölçüm verileriyle oluşturulacaktır.';

  String get aboutMedicalWarningTitle =>
      isEnglish ? 'Medical Warning' : 'Tıbbi Uyarı';

  String get aboutMedicalWarningText => isEnglish
      ? 'This application does not provide medical diagnosis, does not replace doctors, and is not an alternative to emergency medical services.\n\n'
          'If serious symptoms such as chest pain, shortness of breath, cold sweating, fainting feeling, or pain spreading to the arm/jaw are present, 112 should be called without waiting for the application result.\n\n'
          'Wearable alerts do not mean a definitive diagnosis either. When a critical alert is received, the person should be checked, and emergency help should be requested if serious symptoms are present.'
      : 'Bu uygulama tıbbi tanı koymaz, doktor yerine geçmez ve acil sağlık hizmetlerinin alternatifi değildir.\n\n'
          'Göğüs ağrısı, nefes darlığı, soğuk terleme, bayılma hissi veya kola/çeneye yayılan ağrı gibi ciddi belirtiler varsa uygulama sonucunu beklemeden 112 aranmalıdır.\n\n'
          'Bileklik uyarıları da kesin tanı anlamına gelmez; kritik uyarı alındığında kişinin durumu kontrol edilmeli ve ciddi belirti varsa acil yardım alınmalıdır.';

  String get aboutAnalysisSystemTitle =>
      isEnglish ? 'Analysis System' : 'Analiz Sistemi';

  String get aboutAnalysisSystemText => isEnglish
      ? 'KalpAPP currently uses a hybrid analysis system:\n\n'
          '• Rule-based risk engine\n'
          '• Mock backend AI symptom parsing\n'
          '• Local fallback analysis when backend is unavailable\n'
          '• Manual symptom selection\n'
          '• Virtual wearable heart rhythm simulation\n'
          '• Wearable alert history recording\n\n'
          'Because the main architecture is ready, real AI integration can be activated later in the backend layer.'
      : 'KalpAPP şu anda hibrit bir analiz sistemi kullanır:\n\n'
          '• Kural tabanlı risk motoru\n'
          '• Mock backend AI semptom ayrıştırma\n'
          '• Backend erişilemezse yerel yedek analiz\n'
          '• Manuel semptom seçimi\n'
          '• Sanal bileklik kalp ritmi simülasyonu\n'
          '• Bileklik uyarı geçmişi kaydı\n\n'
          'Gerçek yapay zeka entegrasyonu, uygulamanın ana mimarisi hazır olduğu için ileride backend katmanında aktif edilebilir.';

  String get aboutDataSecurityTitle =>
      isEnglish ? 'Data and Security' : 'Veri ve Güvenlik';

  String get aboutDataSecurityText => isEnglish
      ? 'The application can store profile information, health history, symptom assessment results, monitored person information, virtual wearable device IDs, and wearable alert history on Firebase infrastructure linked to the user account.\n\n'
          'The user can delete history, profile data, or the account through the Account and Security screen.'
      : 'Uygulama; profil bilgileri, sağlık geçmişi, semptom değerlendirme sonuçları, takip edilen yakın bilgileri, sanal bileklik cihaz kimlikleri ve bileklik uyarı geçmişini Firebase altyapısı üzerinde kullanıcı hesabına bağlı olarak saklayabilir.\n\n'
          'Kullanıcı, Hesap ve Güvenlik ekranı üzerinden geçmişini, profil verilerini veya hesabını silebilir.';

  String get aboutPrivacyTitle => isEnglish ? 'Privacy' : 'Gizlilik';

  String get aboutPrivacyText => isEnglish
      ? 'You can view the privacy and data protection information inside the application. Since the wearable and family monitoring system may include health-related data, this section should be updated with professional legal support before a real release.'
      : 'Gizlilik ve KVKK bilgilendirme metnini uygulama içinden görüntüleyebilirsiniz. Bileklik ve yakın takip sistemi sağlık verisi niteliğinde bilgiler içerebileceği için bu bölüm gerçek yayına geçmeden önce profesyonel hukuki danışmanlıkla güncellenmelidir.';

  String get openPrivacyPolicy =>
      isEnglish ? 'Open Privacy Text' : 'Gizlilik ve KVKK Metnini Aç';

  String get aboutProjectInfoTitle =>
      isEnglish ? 'Project Information' : 'Proje Bilgisi';

  String get aboutProjectInfoText => isEnglish
      ? 'This application was developed within the scope of a software engineering project and is designed so that it can be transformed into a real health support application in the future.\n\n'
          'The project was developed by considering individual symptom assessment, AI-assisted symptom parsing, family monitoring, virtual wearable demo module, emergency guidance, data security, and sustainable software architecture.'
      : 'Bu uygulama yazılım mühendisliği projesi kapsamında geliştirilmiş olup, ileride gerçek bir sağlık destek uygulamasına dönüştürülebilecek şekilde tasarlanmaktadır.\n\n'
          'Proje; bireysel semptom değerlendirme, yapay zeka destekli semptom ayrıştırma, yakın takip sistemi, sanal bileklik demo modülü, acil durum yönlendirmesi, veri güvenliği ve sürdürülebilir yazılım mimarisi dikkate alınarak geliştirilmiştir.';

  String get aboutDemoModeTitle =>
      isEnglish ? 'Demo Mode Explanation' : 'Demo Modu Açıklaması';

  String get aboutDemoModeText => isEnglish
      ? 'In this development build, wearable data is not received from a real physical device. Heart rhythm and alert states are generated through simulation buttons inside the application.\n\n'
          'This approach is a prototype/demo logic prepared to demonstrate the product idea and user experience.'
      : 'Bu geliştirme sürümünde bileklik verileri gerçek bir fiziksel cihazdan alınmamaktadır. Kalp ritmi ve uyarı durumları uygulama içindeki simülasyon butonlarıyla oluşturulur.\n\n'
          'Bu yaklaşım, ürün fikrini ve kullanıcı deneyimini göstermek için hazırlanmış prototip/demo mantığıdır.';

  String get aboutFooterText => isEnglish
      ? 'KalpAPP • Development Build'
      : 'KalpAPP • Geliştirme Sürümü';

  // Privacy Policy Screen
  String get privacyScreenTitle =>
      isEnglish ? 'Privacy and Data Protection' : 'Gizlilik ve KVKK';

  String get privacyInfoTitle =>
      isEnglish ? 'Privacy Information' : 'Gizlilik Bilgilendirmesi';

  String get privacyInfoText => isEnglish
      ? 'KalpAPP was developed to help users assess their symptoms in case of suspected heart attack and to monitor family members who may carry risk.\n\n'
          'This application does not provide medical diagnosis, does not replace doctors, and is intended only for information, preliminary assessment, demo monitoring, and early warning purposes.'
      : 'KalpAPP, kullanıcının kalp krizi şüphesi durumunda semptomlarını değerlendirmesine ve riskli yakınlarını takip etmesine yardımcı olmak amacıyla geliştirilmiştir.\n\n'
          'Bu uygulama tıbbi teşhis koymaz, doktor yerine geçmez ve yalnızca bilgilendirme, ön değerlendirme, demo takip ve erken uyarı amacı taşır.';

  String get collectedUserDataTitle =>
      isEnglish ? 'Collected User Data' : 'Toplanan Kullanıcı Verileri';

  String get collectedUserDataText => isEnglish
      ? 'The application may store full name, age, gender, health history, medications, emergency contact information, and symptom assessment results.\n\n'
          'This data is used to create the user profile, show assessment history, and provide faster guidance in emergency situations.'
      : 'Uygulama; ad soyad, yaş, cinsiyet, sağlık geçmişi, kullanılan ilaçlar, acil kişi bilgileri ve semptom değerlendirme sonuçlarını kaydedebilir.\n\n'
          'Bu veriler, kullanıcının profilini oluşturmak, değerlendirme geçmişini göstermek ve acil durumda daha hızlı yönlendirme sağlamak amacıyla kullanılır.';

  String get monitoredFamilyDataTitle =>
      isEnglish ? 'Monitored Family Member Data' : 'Takip Edilen Yakın Verileri';

  String get monitoredFamilyDataText => isEnglish
      ? 'Inside KalpAPP, the user can create separate records to monitor family members who may carry heart-related risk.\n\n'
          'These records may include the person’s name, relationship, age, gender, device ID, health history, previous heart attack history, hypertension, diabetes, cholesterol, smoking, and medication information.\n\n'
          'This information may be considered sensitive health-related data.'
      : 'KalpAPP içinde kullanıcı, kalp hastalığı riski taşıyan yakınlarını takip etmek için ayrı kayıtlar oluşturabilir.\n\n'
          'Bu kayıtlarda yakının adı, yakınlık derecesi, yaşı, cinsiyeti, cihaz kimliği, sağlık geçmişi, kalp krizi öyküsü, hipertansiyon, diyabet, kolesterol, sigara kullanımı ve ilaç bilgileri saklanabilir.\n\n'
          'Bu bilgiler hassas sağlık verisi niteliğinde olabilir.';

  String get wearableDeviceIdentityTitle =>
      isEnglish ? 'Wearable and Device ID' : 'Bileklik ve Cihaz Kimliği';

  String get wearableDeviceIdentityText => isEnglish
      ? 'The application includes a virtual wearable system. The user can add a unique device ID for a monitored family member.\n\n'
          'Since there is no physical wearable in this prototype, device data is generated for demo/simulation purposes.\n\n'
          'In the real product, the device ID could be matched with heart rhythm and sensor data coming from the physical wearable.'
      : 'Uygulamada sanal bileklik sistemi bulunmaktadır. Kullanıcı, takip ettiği yakını için benzersiz bir cihaz kimliği ekleyebilir.\n\n'
          'Bu prototipte fiziksel bileklik bulunmadığı için cihaz verileri demo/simülasyon amacıyla oluşturulur.\n\n'
          'Gerçek üründe cihaz kimliği, fiziksel bileklikten gelen kalp ritmi ve sensör verileriyle eşleştirilebilir.';

  String get privacyWearableAlertHistoryTitle =>
      isEnglish ? 'Wearable Alert History' : 'Bileklik Uyarı Geçmişi';

  String get privacyWearableAlertHistoryText => isEnglish
      ? 'The application may save low heart rhythm, high heart rhythm, and critical alert events generated through the virtual wearable.\n\n'
          'These records may include the monitored person’s name, device ID, alert type, heart rate value, description message, and date information.\n\n'
          'In the real product, this data would be generated from measurements coming from the physical device.'
      : 'Uygulama, sanal bileklik üzerinden oluşan düşük kalp ritmi, yüksek kalp ritmi ve kritik uyarı olaylarını geçmişe kaydedebilir.\n\n'
          'Bu kayıtlar; takip edilen kişinin adı, cihaz kimliği, uyarı tipi, kalp ritmi değeri, açıklama mesajı ve tarih bilgisini içerebilir.\n\n'
          'Gerçek üründe bu veriler fiziksel cihazdan gelen ölçümlerle oluşturulacaktır.';

  String get healthDataTitle => isEnglish ? 'Health Data' : 'Sağlık Verileri';

  String get healthDataText => isEnglish
      ? 'Heart disease history, previous heart attack, diabetes, hypertension, cholesterol, heart rhythm values, and similar information may be considered sensitive health-related data.\n\n'
          'Therefore, the application aims to store user data securely during development.\n\n'
          'Before a real release, professional legal evaluation should be made according to KVKK and relevant health data regulations.'
      : 'Kalp hastalığı geçmişi, daha önce geçirilen kalp krizi, diyabet, hipertansiyon, kolesterol, kalp ritmi değerleri ve benzeri bilgiler hassas sağlık verisi niteliğinde olabilir.\n\n'
          'Bu nedenle uygulama geliştirilirken kullanıcı verilerinin güvenli şekilde saklanması hedeflenmektedir.\n\n'
          'Gerçek yayın öncesinde KVKK ve ilgili sağlık verisi mevzuatına uygun profesyonel hukuki değerlendirme yapılmalıdır.';

  String get aiUsageTitle =>
      isEnglish ? 'Artificial Intelligence Usage' : 'Yapay Zeka Kullanımı';

  String get aiUsageText => isEnglish
      ? 'AI-assisted features in the application may be used to convert symptoms written as free text or entered by speech into structured symptom fields.\n\n'
          'The AI system does not provide diagnosis by itself and does not make final medical decisions. Risk assessment works together with the rule-based system.'
      : 'Uygulamadaki yapay zeka destekli özellikler, kullanıcının serbest metin olarak yazdığı veya konuşarak aktardığı semptomları yapılandırılmış semptom alanlarına dönüştürmek için kullanılabilir.\n\n'
          'Yapay zeka sistemi tek başına teşhis koymaz ve nihai tıbbi karar vermez. Risk değerlendirme, kural tabanlı sistem ile birlikte çalışır.';

  String get speechSymptomInputTitle =>
      isEnglish ? 'Speech-Based Symptom Input' : 'Konuşma ile Semptom Girişi';

  String get speechSymptomInputText => isEnglish
      ? 'The application may offer speech-based symptom input by considering situations where the user cannot type.\n\n'
          'This feature may require microphone permission. Speech recognition depends on the device or the speech recognition infrastructure used by the platform.'
      : 'Uygulama, kullanıcının yazı yazamayacağı durumları dikkate alarak konuşma ile semptom girişi özelliği sunabilir.\n\n'
          'Bu özellik cihazın mikrofon iznine ihtiyaç duyabilir. Konuşma tanıma işlemi cihazın veya kullanılan platformun konuşma tanıma altyapısına bağlı olarak çalışabilir.';

  String get dataUsagePurposeTitle =>
      isEnglish ? 'Purpose of Data Usage' : 'Verilerin Kullanım Amacı';

  String get dataUsagePurposeText => isEnglish
      ? 'Collected data may be used to perform symptom assessment, show assessment history, monitor family members, display wearable alerts, provide a demo product experience, and guide the user faster in emergency situations.'
      : 'Toplanan veriler; semptom değerlendirmesi yapmak, değerlendirme geçmişini göstermek, takip edilen yakınların durumunu izlemek, bileklik uyarılarını göstermek, demo ürün deneyimi sunmak ve kullanıcıya acil durumda daha hızlı yönlendirme sağlamak amacıyla kullanılabilir.';

  String get privacyEmergencyWarningTitle =>
      isEnglish ? 'Emergency Warning' : 'Acil Durum Uyarısı';

  String get privacyEmergencyWarningText => isEnglish
      ? 'If serious symptoms such as chest pain, shortness of breath, cold sweating, fainting feeling, or pain spreading to the arm/jaw are present, 112 should be called without delay.\n\n'
          'Wearable alerts do not mean a definitive medical diagnosis either. When a critical rhythm alert is received, the person should be checked, and emergency help should be requested if serious symptoms are present.\n\n'
          'Results in the application are not definitive medical diagnoses.'
      : 'Göğüs ağrısı, nefes darlığı, soğuk terleme, bayılma hissi veya kola/çeneye yayılan ağrı gibi ciddi belirtiler varsa vakit kaybetmeden 112 aranmalıdır.\n\n'
          'Bileklik uyarıları da kesin tıbbi tanı anlamına gelmez. Kritik ritim uyarısı alındığında kişi kontrol edilmeli ve ciddi belirti varsa acil yardım alınmalıdır.\n\n'
          'Uygulamadaki sonuçlar kesin tıbbi tanı değildir.';

  String get privacyDemoPrototypeTitle =>
      isEnglish ? 'Demo and Prototype Explanation' : 'Demo ve Prototip Açıklaması';

  String get privacyDemoPrototypeText => isEnglish
      ? 'In this development build, wearable data is not received from a real physical device. Heart rhythm and alert states are generated through simulation buttons inside the application.\n\n'
          'This feature is a demo/prototype function prepared to demonstrate the product idea and user experience.'
      : 'Bu geliştirme sürümünde bileklik verileri gerçek bir fiziksel cihazdan alınmamaktadır. Kalp ritmi ve uyarı durumları uygulama içindeki simülasyon butonlarıyla oluşturulur.\n\n'
          'Bu özellik, ürün fikrini ve kullanıcı deneyimini göstermek için hazırlanmış demo/prototip işlevdir.';

  String get dataDeletionTitle => isEnglish ? 'Data Deletion' : 'Veri Silme';

  String get dataDeletionText => isEnglish
      ? 'The user can delete assessment history, profile data, or the account from the Account and Security screen.\n\n'
          'Wearable alert history can be deleted from the related history screen.\n\n'
          'Account deletion cannot be undone.'
      : 'Kullanıcı, Hesap ve Güvenlik ekranından değerlendirme geçmişini, profil verilerini veya hesabını silebilir.\n\n'
          'Bileklik uyarı geçmişi, ilgili geçmiş ekranından silinebilir.\n\n'
          'Hesap silme işlemi geri alınamaz.';

  String get privacyNoteTitle => isEnglish ? 'Note' : 'Not';

  String get privacyNoteText => isEnglish
      ? 'This text is a draft information notice prepared for the development stage. Before the application is released for real use, the privacy policy, explicit consent text, and terms of use should be prepared professionally with legal support.\n\n'
          'Explicit consent, data security, and retention policies should be evaluated separately, especially for health data and family monitoring data belonging to third parties.'
      : 'Bu metin geliştirme aşaması için hazırlanmış taslak bilgilendirmedir. Uygulama gerçek kullanıma açılmadan önce hukuki danışmanlık alınarak KVKK, gizlilik politikası, açık rıza metni ve kullanım şartları profesyonel şekilde hazırlanmalıdır.\n\n'
          'Özellikle sağlık verileri ve üçüncü kişilere ait yakın takip verileri için açık rıza, veri güvenliği ve saklama politikaları ayrıca değerlendirilmelidir.';
}
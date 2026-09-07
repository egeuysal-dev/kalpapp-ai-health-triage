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
}
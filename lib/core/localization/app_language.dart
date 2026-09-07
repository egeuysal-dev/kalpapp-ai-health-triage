enum AppLanguage {
  tr,
  en,
}

extension AppLanguageExtension on AppLanguage {
  String get code {
    switch (this) {
      case AppLanguage.tr:
        return 'tr';
      case AppLanguage.en:
        return 'en';
    }
  }

  String get label {
    switch (this) {
      case AppLanguage.tr:
        return 'Türkçe';
      case AppLanguage.en:
        return 'English';
    }
  }

  static AppLanguage fromCode(String? code) {
    switch (code) {
      case 'en':
        return AppLanguage.en;
      case 'tr':
      default:
        return AppLanguage.tr;
    }
  }
}
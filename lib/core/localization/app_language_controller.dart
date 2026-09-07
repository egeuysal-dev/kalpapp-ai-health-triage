import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_language.dart';

class AppLanguageController extends ChangeNotifier {
  static const String _storageKey = 'app_language';

  AppLanguage _language = AppLanguage.tr;
  bool _isLoaded = false;

  AppLanguage get language => _language;
  bool get isLoaded => _isLoaded;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCode = prefs.getString(_storageKey);

    _language = AppLanguageExtension.fromCode(savedCode);
    _isLoaded = true;

    notifyListeners();
  }

  Future<void> setLanguage(AppLanguage language) async {
    if (_language == language) return;

    _language = language;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, language.code);
  }
}

class LanguageScope extends InheritedNotifier<AppLanguageController> {
  const LanguageScope({
    super.key,
    required AppLanguageController controller,
    required super.child,
  }) : super(notifier: controller);

  static AppLanguageController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<LanguageScope>();

    assert(
      scope != null,
      'LanguageScope could not be found in the widget tree.',
    );

    return scope!.notifier!;
  }

  static AppLanguage languageOf(BuildContext context) {
    return of(context).language;
  }
}
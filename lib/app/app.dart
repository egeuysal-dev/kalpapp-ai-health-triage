import 'package:flutter/material.dart';

import '../core/localization/app_language_controller.dart';
import '../screens/splash_screen.dart';
import 'theme.dart';

class KalpAppRoot extends StatefulWidget {
  const KalpAppRoot({super.key});

  @override
  State<KalpAppRoot> createState() => _KalpAppRootState();
}

class _KalpAppRootState extends State<KalpAppRoot> {
  final AppLanguageController _languageController = AppLanguageController();

  @override
  void initState() {
    super.initState();
    _languageController.load();
  }

  @override
  void dispose() {
    _languageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LanguageScope(
      controller: _languageController,
      child: AnimatedBuilder(
        animation: _languageController,
        builder: (context, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'KalpAPP',
            theme: AppTheme.lightTheme,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
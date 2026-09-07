import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import 'theme.dart';

class KalpAppRoot extends StatelessWidget {
  const KalpAppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KalpAPP',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
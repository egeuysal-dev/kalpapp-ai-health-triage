import 'package:flutter/material.dart';

import '../core/localization/app_strings.dart';
import '../core/widgets/primary_button.dart';
import '../core/widgets/section_card.dart';
import '../services/firebase_auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  String? _validateEmail(String? value) {
    final t = AppStrings.of(context);
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return t.emailRequired;
    }

    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

    if (!emailRegex.hasMatch(email)) {
      return t.validEmailRequired;
    }

    return null;
  }

  String? _validatePassword(String? value) {
    final t = AppStrings.of(context);
    final password = value?.trim() ?? '';

    if (password.isEmpty) {
      return t.passwordRequired;
    }

    if (password.length < 6) {
      return t.passwordMinLength;
    }

    if (!RegExp(r'[A-Za-z]').hasMatch(password)) {
      return t.passwordMustContainLetter;
    }

    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return t.passwordMustContainNumber;
    }

    return null;
  }

  String? _validateConfirmPassword(String? value) {
    final t = AppStrings.of(context);
    final confirmPassword = value?.trim() ?? '';
    final password = _passwordController.text.trim();

    if (confirmPassword.isEmpty) {
      return t.confirmPasswordRequired;
    }

    if (confirmPassword != password) {
      return t.passwordsDoNotMatch;
    }

    return null;
  }

  Future<void> _register() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final t = AppStrings.of(context);
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    setState(() => _isLoading = true);

    final error = await FirebaseAuthService.register(
      email: email,
      password: password,
      isEnglish: t.isEnglish,
    );

    if (!mounted) return;

    setState(() => _isLoading = false);

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );

      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(t.registerSuccess),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: Text(t.createAccount),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SectionCard(
              title: t.registerInfoTitle,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: _validateEmail,
                      decoration: InputDecoration(
                        labelText: t.emailLabel,
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.next,
                      validator: _validatePassword,
                      decoration: InputDecoration(
                        labelText: t.passwordLabel,
                        helperText: t.passwordHelperText,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      textInputAction: TextInputAction.done,
                      validator: _validateConfirmPassword,
                      onFieldSubmitted: (_) => _register(),
                      decoration: InputDecoration(
                        labelText: t.confirmPasswordLabel,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    PrimaryButton(
                      text: _isLoading ? t.creatingAccount : t.register,
                      onPressed: _isLoading ? null : _register,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
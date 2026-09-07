import 'package:flutter/material.dart';

import '../core/localization/app_strings.dart';
import '../core/widgets/primary_button.dart';
import '../core/widgets/section_card.dart';
import '../models/user_profile.dart';
import '../services/firestore_user_service.dart';
import 'home_screen.dart';

class ProfileScreen extends StatefulWidget {
  final UserProfile? existingProfile;

  const ProfileScreen({super.key, this.existingProfile});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _ageController;
  late final TextEditingController _medicationsController;
  late final TextEditingController _emergencyNameController;
  late final TextEditingController _emergencyPhoneController;
  late final TextEditingController _emergencyRelationController;

  late String gender;

  late bool previousHeartAttack;
  late bool heartDisease;
  late bool hypertension;
  late bool diabetes;
  late bool highCholesterol;
  late bool smoking;

  bool _isSaving = false;

  bool get isEditMode => widget.existingProfile != null;

  @override
  void initState() {
    super.initState();

    final profile = widget.existingProfile;

    _nameController = TextEditingController(text: profile?.fullName ?? '');
    _ageController = TextEditingController(
      text: profile != null ? profile.age.toString() : '',
    );
    _medicationsController =
        TextEditingController(text: profile?.medications ?? '');
    _emergencyNameController =
        TextEditingController(text: profile?.emergencyContactName ?? '');
    _emergencyPhoneController =
        TextEditingController(text: profile?.emergencyContactPhone ?? '');
    _emergencyRelationController =
        TextEditingController(text: profile?.emergencyContactRelation ?? '');

    gender = profile?.gender ?? 'Erkek';

    previousHeartAttack = profile?.previousHeartAttack ?? false;
    heartDisease = profile?.heartDisease ?? false;
    hypertension = profile?.hypertension ?? false;
    diabetes = profile?.diabetes ?? false;
    highCholesterol = profile?.highCholesterol ?? false;
    smoking = profile?.smoking ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _medicationsController.dispose();
    _emergencyNameController.dispose();
    _emergencyPhoneController.dispose();
    _emergencyRelationController.dispose();

    super.dispose();
  }

  String? _validateName(String? value) {
    final t = AppStrings.of(context);
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return t.profileNameRequired;
    }

    if (text.length < 3) {
      return t.profileNameMinLength;
    }

    return null;
  }

  String? _validateAge(String? value) {
    final t = AppStrings.of(context);
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return t.profileAgeRequired;
    }

    final age = int.tryParse(text);

    if (age == null) {
      return t.profileAgeInvalid;
    }

    if (age < 1 || age > 120) {
      return t.profileAgeRange;
    }

    return null;
  }

  String? _validateEmergencyPhone(String? value) {
    final t = AppStrings.of(context);
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return null;
    }

    final cleaned = text.replaceAll(RegExp(r'[^0-9+]'), '');

    if (cleaned.length < 10) {
      return t.emergencyPhoneTooShort;
    }

    return null;
  }

  Widget _buildSwitch({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
      activeThumbColor: Theme.of(context).colorScheme.primary,
    );
  }

  Future<void> _saveProfile() async {
    FocusScope.of(context).unfocus();

    final t = AppStrings.of(context);

    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.profileFormInvalid),
        ),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final profile = UserProfile(
        fullName: _nameController.text.trim(),
        age: int.parse(_ageController.text.trim()),
        gender: gender,
        previousHeartAttack: previousHeartAttack,
        heartDisease: heartDisease,
        hypertension: hypertension,
        diabetes: diabetes,
        highCholesterol: highCholesterol,
        smoking: smoking,
        medications: _medicationsController.text.trim(),
        emergencyContactName: _emergencyNameController.text.trim(),
        emergencyContactPhone: _emergencyPhoneController.text.trim(),
        emergencyContactRelation: _emergencyRelationController.text.trim(),
      );

      await FirestoreUserService.saveProfile(profile);

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => HomeScreen(profile: profile),
        ),
        (route) => false,
      );
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.profileSaveError),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Widget _buildGenderDropdown() {
    final t = AppStrings.of(context);

    return DropdownButtonFormField<String>(
      initialValue: gender,
      decoration: InputDecoration(
        labelText: t.genderLabel,
      ),
      items: [
        DropdownMenuItem(
          value: 'Erkek',
          child: Text(t.male),
        ),
        DropdownMenuItem(
          value: 'Kadın',
          child: Text(t.female),
        ),
      ],
      onChanged: (value) {
        setState(() {
          gender = value ?? 'Erkek';
        });
      },
    );
  }

  Widget _buildPersonalInfoSection() {
    final t = AppStrings.of(context);

    return SectionCard(
      title: t.personalInformation,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            textInputAction: TextInputAction.next,
            validator: _validateName,
            decoration: InputDecoration(
              labelText: t.fullNameLabel,
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            validator: _validateAge,
            decoration: InputDecoration(
              labelText: t.ageLabel,
            ),
          ),
          const SizedBox(height: 12),
          _buildGenderDropdown(),
        ],
      ),
    );
  }

  Widget _buildHealthHistorySection() {
    final t = AppStrings.of(context);

    return SectionCard(
      title: t.healthHistory,
      child: Column(
        children: [
          _buildSwitch(
            title: t.previousHeartAttackPersonal,
            value: previousHeartAttack,
            onChanged: (value) {
              setState(() {
                previousHeartAttack = value;
              });
            },
          ),
          _buildSwitch(
            title: t.heartDiseasePersonal,
            value: heartDisease,
            onChanged: (value) {
              setState(() {
                heartDisease = value;
              });
            },
          ),
          _buildSwitch(
            title: t.hypertensionPersonal,
            value: hypertension,
            onChanged: (value) {
              setState(() {
                hypertension = value;
              });
            },
          ),
          _buildSwitch(
            title: t.diabetesPersonal,
            value: diabetes,
            onChanged: (value) {
              setState(() {
                diabetes = value;
              });
            },
          ),
          _buildSwitch(
            title: t.highCholesterolPersonal,
            value: highCholesterol,
            onChanged: (value) {
              setState(() {
                highCholesterol = value;
              });
            },
          ),
          _buildSwitch(
            title: t.smokingPersonal,
            value: smoking,
            onChanged: (value) {
              setState(() {
                smoking = value;
              });
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _medicationsController,
            maxLines: 2,
            textInputAction: TextInputAction.newline,
            decoration: InputDecoration(
              labelText: t.medicationsPersonalLabel,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContactSection() {
    final t = AppStrings.of(context);

    return SectionCard(
      title: t.emergencyContactInformation,
      child: Column(
        children: [
          TextFormField(
            controller: _emergencyNameController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: t.emergencyContactName,
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _emergencyPhoneController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            validator: _validateEmergencyPhone,
            decoration: InputDecoration(
              labelText: t.phoneNumber,
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _emergencyRelationController,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: t.emergencyRelationHint,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    final t = AppStrings.of(context);

    return PrimaryButton(
      text: _isSaving
          ? t.savingPerson
          : (isEditMode ? t.saveChanges : t.saveProfile),
      onPressed: _isSaving ? null : _saveProfile,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: Text(isEditMode ? t.editProfileTitle : t.createProfile),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildPersonalInfoSection(),
              _buildHealthHistorySection(),
              _buildEmergencyContactSection(),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }
}
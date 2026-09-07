import 'package:flutter/material.dart';
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
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Ad soyad zorunludur.';
    }
    if (text.length < 3) {
      return 'Ad soyad en az 3 karakter olmalıdır.';
    }
    return null;
  }

  String? _validateAge(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Yaş zorunludur.';
    }

    final age = int.tryParse(text);
    if (age == null) {
      return 'Geçerli bir yaş girin.';
    }
    if (age < 1 || age > 120) {
      return 'Yaş 1 ile 120 arasında olmalıdır.';
    }
    return null;
  }

  String? _validateEmergencyPhone(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return null;
    }

    final cleaned = text.replaceAll(RegExp(r'[^0-9+]'), '');

    if (cleaned.length < 10) {
      return 'Telefon numarası çok kısa görünüyor.';
    }

    return null;
  }

  Widget _buildSwitch(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
      activeColor: Theme.of(context).colorScheme.primary,
    );
  }

  Future<void> _saveProfile() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen formdaki hataları düzeltin.'),
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
        const SnackBar(
          content: Text('Profil kaydedilirken bir hata oluştu.'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'Profili Düzenle' : 'Profil Oluştur'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SectionCard(
                title: 'Kişisel Bilgiler',
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      validator: _validateName,
                      decoration: const InputDecoration(
                        labelText: 'Ad Soyad',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: _validateAge,
                      decoration: const InputDecoration(
                        labelText: 'Yaş',
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: gender,
                      decoration: const InputDecoration(
                        labelText: 'Cinsiyet',
                      ),
                      items: const [
                        DropdownMenuItem(value: 'Erkek', child: Text('Erkek')),
                        DropdownMenuItem(value: 'Kadın', child: Text('Kadın')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SectionCard(
                title: 'Sağlık Geçmişi',
                child: Column(
                  children: [
                    _buildSwitch(
                      'Daha önce kalp krizi geçirdim',
                      previousHeartAttack,
                      (value) => setState(() => previousHeartAttack = value),
                    ),
                    _buildSwitch(
                      'Kalp hastalığım var',
                      heartDisease,
                      (value) => setState(() => heartDisease = value),
                    ),
                    _buildSwitch(
                      'Hipertansiyonum var',
                      hypertension,
                      (value) => setState(() => hypertension = value),
                    ),
                    _buildSwitch(
                      'Diyabetim var',
                      diabetes,
                      (value) => setState(() => diabetes = value),
                    ),
                    _buildSwitch(
                      'Kolesterol yüksekliğim var',
                      highCholesterol,
                      (value) => setState(() => highCholesterol = value),
                    ),
                    _buildSwitch(
                      'Sigara kullanıyorum',
                      smoking,
                      (value) => setState(() => smoking = value),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _medicationsController,
                      maxLines: 2,
                      textInputAction: TextInputAction.newline,
                      decoration: const InputDecoration(
                        labelText: 'Kullandığınız ilaçlar',
                      ),
                    ),
                  ],
                ),
              ),
              SectionCard(
                title: 'Acil Kişi Bilgileri',
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emergencyNameController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Acil Kişi Adı',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emergencyPhoneController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      validator: _validateEmergencyPhone,
                      decoration: const InputDecoration(
                        labelText: 'Telefon Numarası',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emergencyRelationController,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        labelText: 'Yakınlık (Anne, Arkadaş vs.)',
                      ),
                    ),
                  ],
                ),
              ),
              PrimaryButton(
                text: _isSaving
                    ? 'Kaydediliyor...'
                    : (isEditMode
                        ? 'Değişiklikleri Kaydet'
                        : 'Profili Kaydet'),
                onPressed: _isSaving ? null : _saveProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/localization/app_strings.dart';
import '../core/widgets/primary_button.dart';
import '../models/monitored_person.dart';
import '../services/monitored_person_service.dart';

class AddMonitoredPersonScreen extends StatefulWidget {
  const AddMonitoredPersonScreen({super.key});

  @override
  State<AddMonitoredPersonScreen> createState() =>
      _AddMonitoredPersonScreenState();
}

class _AddMonitoredPersonScreenState extends State<AddMonitoredPersonScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _relationController = TextEditingController();
  final _ageController = TextEditingController();
  final _deviceIdController = TextEditingController();
  final _medicationsController = TextEditingController();

  String gender = 'Erkek';

  bool previousHeartAttack = false;
  bool heartDisease = false;
  bool hypertension = false;
  bool diabetes = false;
  bool highCholesterol = false;
  bool smoking = false;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _deviceIdController.text = _generateDemoDeviceId();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _relationController.dispose();
    _ageController.dispose();
    _deviceIdController.dispose();
    _medicationsController.dispose();
    super.dispose();
  }

  String _generateDemoDeviceId() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final shortCode = now.toString().substring(now.toString().length - 5);

    return 'KAPP-$shortCode';
  }

  String? _validateName(String? value) {
    final t = AppStrings.of(context);
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return t.monitoredPersonNameRequired;
    }

    if (text.length < 3) {
      return t.monitoredPersonNameMinLength;
    }

    return null;
  }

  String? _validateRelation(String? value) {
    final t = AppStrings.of(context);
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return t.monitoredPersonRelationRequired;
    }

    return null;
  }

  String? _validateAge(String? value) {
    final t = AppStrings.of(context);
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return t.monitoredPersonAgeRequired;
    }

    final age = int.tryParse(text);

    if (age == null) {
      return t.monitoredPersonAgeInvalid;
    }

    if (age < 1 || age > 120) {
      return t.monitoredPersonAgeRange;
    }

    return null;
  }

  String? _validateDeviceId(String? value) {
    final t = AppStrings.of(context);
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return t.monitoredPersonDeviceRequired;
    }

    if (text.length < 5) {
      return t.monitoredPersonDeviceTooShort;
    }

    return null;
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();

    final t = AppStrings.of(context);

    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.monitoredPersonFormInvalid),
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final person = MonitoredPerson(
        id: '',
        fullName: _nameController.text.trim(),
        relation: _relationController.text.trim(),
        age: int.parse(_ageController.text.trim()),
        gender: gender,
        deviceId: _deviceIdController.text.trim(),
        heartRate: 74,
        status: 'Normal',
        lastMeasurement: DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now()),
        previousHeartAttack: previousHeartAttack,
        heartDisease: heartDisease,
        hypertension: hypertension,
        diabetes: diabetes,
        highCholesterol: highCholesterol,
        smoking: smoking,
        medications: _medicationsController.text.trim(),
      );

      await MonitoredPersonService.addPerson(person);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.monitoredPersonAddSuccess),
        ),
      );

      Navigator.pop(context);
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.monitoredPersonAddError),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Widget _buildHeaderCard() {
    final t = AppStrings.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1976D2), Color(0xFF00ACC1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(34, 25, 118, 210),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.watch_outlined,
            color: Colors.white,
            size: 42,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.addMonitoredPersonHeaderTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  t.addMonitoredPersonHeaderMessage,
                  style: const TextStyle(
                    color: Colors.white70,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemoInfoCard() {
    final t = AppStrings.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFF1976D2).withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            color: Color(0xFF1976D2),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              t.addMonitoredPersonDemoInfo,
              style: const TextStyle(
                color: Color(0xFF0D47A1),
                height: 1.45,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    int maxLines = 1,
    String? Function(String?)? validator,
    IconData? icon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: icon == null ? null : Icon(icon),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    final t = AppStrings.of(context);

    return DropdownButtonFormField<String>(
      initialValue: gender,
      decoration: InputDecoration(
        labelText: t.genderLabel,
        prefixIcon: const Icon(Icons.wc),
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

  Widget _buildDevicePreviewCard() {
    final t = AppStrings.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE6E8EC),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFF1976D2).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.watch_outlined,
              color: Color(0xFF1976D2),
              size: 30,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.demoBraceletId,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _deviceIdController.text,
                  style: const TextStyle(
                    color: Color(0xFF1976D2),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _deviceIdController.text = _generateDemoDeviceId();
              });
            },
            icon: const Icon(Icons.refresh),
            tooltip: t.createNewDeviceIdTooltip,
          ),
        ],
      ),
    );
  }

  Widget _buildRiskSwitch({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: value ? const Color(0xFFFFEBEE) : const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: value
              ? const Color(0xFFE53935).withValues(alpha: 0.28)
              : const Color(0xFFE6E8EC),
        ),
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        secondary: Icon(
          icon,
          color: value ? const Color(0xFFE53935) : Colors.black45,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: value ? const Color(0xFFE53935) : Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.black54,
            height: 1.3,
          ),
        ),
      ),
    );
  }

  Widget _buildRiskSummaryBox() {
    final t = AppStrings.of(context);

    final riskCount = [
      previousHeartAttack,
      heartDisease,
      hypertension,
      diabetes,
      highCholesterol,
      smoking,
    ].where((item) => item).length;

    Color color;

    if (riskCount >= 4) {
      color = Colors.red;
    } else if (riskCount >= 2) {
      color = Colors.orange;
    } else if (riskCount == 1) {
      color = Colors.amber.shade700;
    } else {
      color = Colors.green;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.analytics_outlined,
            color: color,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              t.riskProfileSummary(riskCount: riskCount),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF1D1D1F),
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildModernSection({
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(14, 0, 0, 0),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(title),
          child,
        ],
      ),
    );
  }

  Widget _buildPersonInfoSection() {
    final t = AppStrings.of(context);

    return _buildModernSection(
      title: t.personInformation,
      child: Column(
        children: [
          _buildTextField(
            controller: _nameController,
            label: t.fullNameLabel,
            icon: Icons.person_outline,
            textInputAction: TextInputAction.next,
            validator: _validateName,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _relationController,
            label: t.relationLabel,
            hint: t.relationHint,
            icon: Icons.family_restroom,
            textInputAction: TextInputAction.next,
            validator: _validateRelation,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _ageController,
            label: t.ageLabel,
            icon: Icons.cake_outlined,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            validator: _validateAge,
          ),
          const SizedBox(height: 12),
          _buildGenderDropdown(),
        ],
      ),
    );
  }

  Widget _buildBraceletInfoSection() {
    final t = AppStrings.of(context);

    return _buildModernSection(
      title: t.braceletInformation,
      child: Column(
        children: [
          _buildDevicePreviewCard(),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _deviceIdController,
            label: t.deviceIdLabel,
            hint: t.deviceIdHint,
            icon: Icons.qr_code_2,
            textInputAction: TextInputAction.next,
            validator: _validateDeviceId,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  _deviceIdController.text = _generateDemoDeviceId();
                });
              },
              icon: const Icon(Icons.refresh),
              label: Text(t.createNewDemoDeviceId),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskHistorySection() {
    final t = AppStrings.of(context);

    return _buildModernSection(
      title: t.riskHistory,
      child: Column(
        children: [
          _buildRiskSummaryBox(),
          const SizedBox(height: 14),
          _buildRiskSwitch(
            title: t.previousHeartAttackTitle,
            subtitle: t.previousHeartAttackSubtitle,
            icon: Icons.favorite_border,
            value: previousHeartAttack,
            onChanged: (value) {
              setState(() => previousHeartAttack = value);
            },
          ),
          _buildRiskSwitch(
            title: t.heartDiseaseTitle,
            subtitle: t.heartDiseaseSubtitle,
            icon: Icons.monitor_heart_outlined,
            value: heartDisease,
            onChanged: (value) {
              setState(() => heartDisease = value);
            },
          ),
          _buildRiskSwitch(
            title: t.hypertensionTitle,
            subtitle: t.hypertensionSubtitle,
            icon: Icons.bloodtype_outlined,
            value: hypertension,
            onChanged: (value) {
              setState(() => hypertension = value);
            },
          ),
          _buildRiskSwitch(
            title: t.diabetesTitle,
            subtitle: t.diabetesSubtitle,
            icon: Icons.medical_information_outlined,
            value: diabetes,
            onChanged: (value) {
              setState(() => diabetes = value);
            },
          ),
          _buildRiskSwitch(
            title: t.highCholesterolTitle,
            subtitle: t.highCholesterolSubtitle,
            icon: Icons.health_and_safety_outlined,
            value: highCholesterol,
            onChanged: (value) {
              setState(() => highCholesterol = value);
            },
          ),
          _buildRiskSwitch(
            title: t.smokingTitle,
            subtitle: t.smokingSubtitle,
            icon: Icons.smoking_rooms_outlined,
            value: smoking,
            onChanged: (value) {
              setState(() => smoking = value);
            },
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _medicationsController,
            label: t.medicationsLabel,
            hint: t.medicationsHint,
            icon: Icons.medication_outlined,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSaveButton() {
    final t = AppStrings.of(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 18, bottom: 24),
      child: PrimaryButton(
        text: _isSaving ? t.savingPerson : t.savePersonAndWearable,
        onPressed: _isSaving ? null : _save,
        icon: Icons.person_add_alt_1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: Text(t.addMonitoredPersonScreenTitle),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildHeaderCard(),
              const SizedBox(height: 16),
              _buildDemoInfoCard(),
              _buildPersonInfoSection(),
              _buildBraceletInfoSection(),
              _buildRiskHistorySection(),
              _buildBottomSaveButton(),
            ],
          ),
        ),
      ),
    );
  }
}
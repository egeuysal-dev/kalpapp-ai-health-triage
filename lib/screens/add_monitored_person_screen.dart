import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return 'Yakınınızın adı zorunludur.';
    }

    if (text.length < 3) {
      return 'Ad en az 3 karakter olmalıdır.';
    }

    return null;
  }

  String? _validateRelation(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return 'Yakınlık derecesi zorunludur.';
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

  String? _validateDeviceId(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return 'Cihaz kimliği zorunludur.';
    }

    if (text.length < 5) {
      return 'Cihaz kimliği çok kısa.';
    }

    return null;
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen formdaki eksik veya hatalı alanları düzeltin.'),
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
        const SnackBar(
          content: Text('Yakın ve sanal bileklik başarıyla eklendi.'),
        ),
      );

      Navigator.pop(context);
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Yakın eklenirken bir hata oluştu.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Widget _buildHeaderCard() {
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
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.watch_outlined,
            color: Colors.white,
            size: 42,
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Yakın ve Bileklik Ekle',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Kalp hastalığı riski taşıyan yakınınız için sanal bileklik profili oluşturun.',
                  style: TextStyle(
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFF1976D2).withOpacity(0.25),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: Color(0xFF1976D2),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Bu prototipte fiziksel bileklik yerine demo cihaz kimliği kullanılır. Gerçek üründe bu kimlik, bileklikten gelen canlı sensör verileriyle eşleştirilecektir.',
              style: TextStyle(
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
    return DropdownButtonFormField<String>(
      value: gender,
      decoration: const InputDecoration(
        labelText: 'Cinsiyet',
        prefixIcon: Icon(Icons.wc),
      ),
      items: const [
        DropdownMenuItem(value: 'Erkek', child: Text('Erkek')),
        DropdownMenuItem(value: 'Kadın', child: Text('Kadın')),
      ],
      onChanged: (value) {
        setState(() {
          gender = value ?? 'Erkek';
        });
      },
    );
  }

  Widget _buildDevicePreviewCard() {
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
              color: const Color(0xFF1976D2).withOpacity(0.12),
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
                const Text(
                  'Demo Bileklik Kimliği',
                  style: TextStyle(
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
            tooltip: 'Yeni cihaz kimliği oluştur',
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
              ? const Color(0xFFE53935).withOpacity(0.28)
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
    final riskCount = [
      previousHeartAttack,
      heartDisease,
      hypertension,
      diabetes,
      highCholesterol,
      smoking,
    ].where((item) => item).length;

    Color color;
    String message;

    if (riskCount >= 4) {
      color = Colors.red;
      message = 'Yüksek risk profili';
    } else if (riskCount >= 2) {
      color = Colors.orange;
      message = 'Orta risk profili';
    } else if (riskCount == 1) {
      color = Colors.amber.shade700;
      message = 'Düşük/orta risk profili';
    } else {
      color = Colors.green;
      message = 'Belirgin risk faktörü seçilmedi';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withOpacity(0.25),
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
              '$message • Seçilen risk faktörü: $riskCount',
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
    return _buildModernSection(
      title: 'Yakın Bilgileri',
      child: Column(
        children: [
          _buildTextField(
            controller: _nameController,
            label: 'Ad Soyad',
            icon: Icons.person_outline,
            textInputAction: TextInputAction.next,
            validator: _validateName,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _relationController,
            label: 'Yakınlık Derecesi',
            hint: 'Örn: Dede, Anne, Baba',
            icon: Icons.family_restroom,
            textInputAction: TextInputAction.next,
            validator: _validateRelation,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _ageController,
            label: 'Yaş',
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
    return _buildModernSection(
      title: 'Bileklik Bilgileri',
      child: Column(
        children: [
          _buildDevicePreviewCard(),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _deviceIdController,
            label: 'Cihaz Kimliği',
            hint: 'Örn: KAPP-83721',
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
              label: const Text('Yeni Demo Cihaz Kimliği Oluştur'),
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
    return _buildModernSection(
      title: 'Risk Geçmişi',
      child: Column(
        children: [
          _buildRiskSummaryBox(),
          const SizedBox(height: 14),
          _buildRiskSwitch(
            title: 'Daha önce kalp krizi geçirdi',
            subtitle: 'Önceki kalp krizi öyküsü',
            icon: Icons.favorite_border,
            value: previousHeartAttack,
            onChanged: (value) {
              setState(() => previousHeartAttack = value);
            },
          ),
          _buildRiskSwitch(
            title: 'Kalp hastalığı var',
            subtitle: 'Tanı almış kalp hastalığı',
            icon: Icons.monitor_heart_outlined,
            value: heartDisease,
            onChanged: (value) {
              setState(() => heartDisease = value);
            },
          ),
          _buildRiskSwitch(
            title: 'Hipertansiyon var',
            subtitle: 'Yüksek tansiyon öyküsü',
            icon: Icons.bloodtype_outlined,
            value: hypertension,
            onChanged: (value) {
              setState(() => hypertension = value);
            },
          ),
          _buildRiskSwitch(
            title: 'Diyabet var',
            subtitle: 'Şeker hastalığı öyküsü',
            icon: Icons.medical_information_outlined,
            value: diabetes,
            onChanged: (value) {
              setState(() => diabetes = value);
            },
          ),
          _buildRiskSwitch(
            title: 'Yüksek kolesterol var',
            subtitle: 'Kolesterol yüksekliği',
            icon: Icons.health_and_safety_outlined,
            value: highCholesterol,
            onChanged: (value) {
              setState(() => highCholesterol = value);
            },
          ),
          _buildRiskSwitch(
            title: 'Sigara kullanıyor',
            subtitle: 'Sigara kullanımı risk faktörüdür',
            icon: Icons.smoking_rooms_outlined,
            value: smoking,
            onChanged: (value) {
              setState(() => smoking = value);
            },
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _medicationsController,
            label: 'Kullandığı İlaçlar',
            hint: 'Örn: Tansiyon ilacı, kan sulandırıcı...',
            icon: Icons.medication_outlined,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSaveButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 18, bottom: 24),
      child: PrimaryButton(
        text: _isSaving ? 'Kaydediliyor...' : 'Yakını ve Bilekliği Kaydet',
        onPressed: _isSaving ? null : _save,
        icon: Icons.person_add_alt_1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text('Yakın / Bileklik Ekle'),
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
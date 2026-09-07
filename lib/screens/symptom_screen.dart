import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:url_launcher/url_launcher.dart';

import '../core/localization/app_strings.dart';
import '../models/risk_input.dart';
import '../models/user_profile.dart';
import '../services/ai/ai_service_factory.dart';
import '../services/ai/fallback_ai_symptom_service.dart';
import '../services/risk_engine_service.dart';
import 'result_screen.dart';

class SymptomScreen extends StatefulWidget {
  final UserProfile profile;

  const SymptomScreen({
    super.key,
    required this.profile,
  });

  @override
  State<SymptomScreen> createState() => _SymptomScreenState();
}

class _SymptomScreenState extends State<SymptomScreen> {
  static const String _manualSource = 'Manuel seçim';
  static const String _backendSource = 'Backend AI analizi';
  static const String _fallbackSource = 'Yerel yedek analiz';

  late final _aiService = AIServiceFactory.create();
  final stt.SpeechToText _speech = stt.SpeechToText();

  final TextEditingController _freeTextController = TextEditingController();

  bool chestPain = false;
  bool painRadiation = false;
  bool shortnessOfBreath = false;
  bool coldSweating = false;
  bool nausea = false;
  bool dizziness = false;
  bool faintingFeeling = false;

  double symptomDuration = 5;
  double painSeverity = 1;

  bool _isAnalyzing = false;
  bool _isListening = false;
  bool _speechAvailable = false;

  String _aiSummary = '';
  String _analysisSource = _manualSource;
  String _speechStatus = 'Mikrofon hazırlanıyor...';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  @override
  void dispose() {
    _speech.stop();
    _freeTextController.dispose();
    super.dispose();
  }

  Future<void> _initSpeech() async {
    try {
      final available = await _speech.initialize(
        onStatus: (status) {
          if (!mounted) return;

          setState(() {
            if (status == 'listening') {
              _isListening = true;
              _speechStatus = 'Dinleniyor...';
            } else if (status == 'notListening') {
              _isListening = false;
              _speechStatus = 'Dinleme durdu';
            } else {
              _speechStatus = status;
            }
          });
        },
        onError: (error) {
          if (!mounted) return;

          final t = AppStrings.of(context);

          final readableMessage = error.errorMsg == 'error_speech_timeout'
              ? 'Ses algılanamadı. Tekrar deneyin ve butona bastıktan hemen sonra konuşun.'
              : 'Mikrofon hatası: ${error.errorMsg}';

          setState(() {
            _isListening = false;
            _speechStatus = readableMessage;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                error.errorMsg == 'error_speech_timeout'
                    ? t.noSpeechDetectedShort
                    : t.microphoneError(error.errorMsg),
              ),
            ),
          );
        },
      );

      if (!mounted) return;

      setState(() {
        _speechAvailable = available;
        _speechStatus = available
            ? 'Mikrofon hazır'
            : 'Konuşma tanıma bu cihazda kullanılamıyor';
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _speechAvailable = false;
        _speechStatus = 'Konuşma tanıma başlatılamadı';
      });
    }
  }

  Future<void> _toggleListening() async {
    final t = AppStrings.of(context);

    if (_isListening) {
      await _speech.stop();

      if (!mounted) return;

      setState(() {
        _isListening = false;
        _speechStatus = 'Dinleme durdu';
      });

      return;
    }

    if (!_speechAvailable) {
      await _initSpeech();

      if (!_speechAvailable) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.micUnavailablePermission),
          ),
        );
        return;
      }
    }

    setState(() {
      _isListening = true;
      _speechStatus = 'Dinleniyor...';
    });

    await _speech.listen(
      localeId: t.isEnglish ? 'en_US' : 'tr_TR',
      listenMode: stt.ListenMode.dictation,
      listenFor: const Duration(seconds: 45),
      pauseFor: const Duration(seconds: 8),
      partialResults: true,
      cancelOnError: false,
      onResult: (result) {
        if (!mounted) return;

        setState(() {
          _freeTextController.text = result.recognizedWords;
          _freeTextController.selection = TextSelection.fromPosition(
            TextPosition(offset: _freeTextController.text.length),
          );
          _analysisSource = _manualSource;
        });
      },
    );
  }

  void _clearSymptomText() {
    setState(() {
      _freeTextController.clear();
      _aiSummary = '';
      _analysisSource = _manualSource;
      _speechStatus = _speechAvailable ? 'Mikrofon hazır' : _speechStatus;
    });
  }

  Future<void> _call112() async {
    final t = AppStrings.of(context);
    final uri = Uri.parse('tel:112');

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.call112EmulatorError),
          ),
        );
      }
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.call112DeviceError),
        ),
      );
    }
  }

  bool _hasCriticalEmergencyPattern() {
    final strongChestPattern = chestPain &&
        (painRadiation || shortnessOfBreath || coldSweating || faintingFeeling);

    final severeSymptoms = painSeverity >= 7 || symptomDuration >= 15;
    final breathingOrFaintingPattern = shortnessOfBreath && faintingFeeling;

    return (strongChestPattern && severeSymptoms) || breathingOrFaintingPattern;
  }

  Future<bool> _showCriticalWarningDialog() async {
    final t = AppStrings.of(context);

    final result = await showDialog<bool>(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(28, 0, 0, 0),
                blurRadius: 24,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFFE53935),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.warning_rounded,
                      color: Colors.white,
                      size: 34,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        t.seriousSymptomWarningTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEBEE),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: const Color(0xFFE53935).withValues(alpha: 0.30),
                        ),
                      ),
                      child: Text(
                        t.seriousSymptomWarningMessage,
                        style: const TextStyle(
                          color: Color(0xFF8A1C1C),
                          height: 1.45,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(t.viewResult),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              Navigator.pop(context, false);
                              await _call112();
                            },
                            icon: const Icon(Icons.call),
                            label: Text(t.call112),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE53935),
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return result ?? true;
  }

  String _buildSymptomSummary() {
    final t = AppStrings.of(context);
    final List<String> symptoms = [];

    if (chestPain) symptoms.add(t.chestPainPressure);
    if (painRadiation) symptoms.add(t.radiatingPain);
    if (shortnessOfBreath) symptoms.add(t.shortnessOfBreathText);
    if (coldSweating) symptoms.add(t.coldSweatingText);
    if (nausea) symptoms.add(t.nauseaText);
    if (dizziness) symptoms.add(t.dizzinessText);
    if (faintingFeeling) symptoms.add(t.faintingFeelingText);

    if (symptoms.isEmpty) {
      return t.noSymptomSelected;
    }

    return symptoms.join(', ');
  }

  Future<void> _analyzeWithAI() async {
    final t = AppStrings.of(context);
    final text = _freeTextController.text.trim();

    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.pleaseEnterSymptomText),
        ),
      );
      return;
    }

    setState(() {
      _isAnalyzing = true;
      _aiSummary = '';
    });

    try {
      final result = await _aiService.parseSymptoms(
        symptomText: text,
        age: widget.profile.age,
        gender: widget.profile.gender,
      );

      if (!mounted) return;

      final usedFallback =
          _aiService is FallbackAISymptomService && _aiService.usedFallback;

      setState(() {
        chestPain = result.chestPain;
        painRadiation = result.painRadiation;
        shortnessOfBreath = result.shortnessOfBreath;
        coldSweating = result.coldSweating;
        nausea = result.nausea;
        dizziness = result.dizziness;
        faintingFeeling = result.faintingFeeling;
        symptomDuration =
            result.durationMinutesEstimate.clamp(0, 60).toDouble();
        painSeverity = result.painSeverityEstimate.clamp(1, 10).toDouble();
        _aiSummary = result.summary;
        _analysisSource = usedFallback ? _fallbackSource : _backendSource;
        _isAnalyzing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            usedFallback ? t.backendUnavailableFallback : t.symptomTextAnalyzed,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isAnalyzing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.analysisError(e)),
        ),
      );
    }
  }

  Future<void> _calculateRisk() async {
    if (_hasCriticalEmergencyPattern()) {
      final continueToResult = await _showCriticalWarningDialog();

      if (!continueToResult) {
        return;
      }
    }

    final evaluation = RiskEngineService.evaluate(
      RiskInput(
        profile: widget.profile,
        chestPain: chestPain,
        painRadiation: painRadiation,
        shortnessOfBreath: shortnessOfBreath,
        coldSweating: coldSweating,
        nausea: nausea,
        dizziness: dizziness,
        faintingFeeling: faintingFeeling,
        symptomDurationMinutes: symptomDuration.toInt(),
        painSeverity: painSeverity.toInt(),
        analysisSource: _analysisSource,
      ),
    );

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          riskScore: evaluation.score,
          riskLevel: evaluation.riskLevel,
          resultMessage: evaluation.resultMessage,
          actionLevel: evaluation.actionLevel,
          symptomSummary: _buildSymptomSummary(),
          emergencyPhone: widget.profile.emergencyContactPhone,
          riskReasons: evaluation.reasons,
          analysisSource: _analysisSource,
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    final t = AppStrings.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE53935), Color(0xFFD81B60)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(40, 229, 57, 53),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.emergency,
            color: Colors.white,
            size: 42,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.symptomAssessmentTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  t.symptomAssessmentSubtitle,
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

  Widget _buildEmergencyWarningCard() {
    final t = AppStrings.of(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE53935).withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: Color(0xFFE53935),
                size: 30,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  t.emergencyWarningText,
                  style: const TextStyle(
                    color: Color(0xFF8A1C1C),
                    fontSize: 14,
                    height: 1.45,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _call112,
              icon: const Icon(Icons.call),
              label: Text(t.call112),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE53935),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 52),
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

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
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
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFFE53935),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Color(0xFF1D1D1F),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _buildSpeechInputSection() {
    final t = AppStrings.of(context);
    final hasText = _freeTextController.text.trim().isNotEmpty;

    return _buildSectionCard(
      title: t.writeOrSpeak,
      icon: Icons.record_voice_over_outlined,
      child: Column(
        children: [
          TextField(
            controller: _freeTextController,
            maxLines: 4,
            onChanged: (_) {
              setState(() {
                _analysisSource = _manualSource;
              });
            },
            decoration: InputDecoration(
              labelText: t.symptomDescription,
              hintText: t.symptomInputHint,
              prefixIcon: const Icon(Icons.edit_note),
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _toggleListening,
                  icon: Icon(
                    _isListening ? Icons.stop_circle_outlined : Icons.mic,
                  ),
                  label: Text(
                    _isListening ? t.stopListening : t.speak,
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed:
                      _freeTextController.text.trim().isEmpty ? null : _clearSymptomText,
                  icon: const Icon(Icons.clear),
                  label: Text(t.clearSymptomInput),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildSpeechStatusCard(),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isAnalyzing || !hasText ? null : _analyzeWithAI,
              icon: const Icon(Icons.auto_awesome),
              label: Text(
                _isAnalyzing ? t.analyzingWithAi : t.analyzeWithAi,
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          if (_aiSummary.isNotEmpty) ...[
            const SizedBox(height: 14),
            _buildAiSummaryCard(),
          ],
          const SizedBox(height: 12),
          _buildAnalysisSourceChip(),
        ],
      ),
    );
  }

  Widget _buildSpeechStatusCard() {
    final t = AppStrings.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _isListening
            ? const Color(0xFFE8F5E9)
            : const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: _isListening
              ? Colors.green.withValues(alpha: 0.35)
              : const Color(0xFFE6E8EC),
        ),
      ),
      child: Row(
        children: [
          Icon(
            _isListening ? Icons.mic : Icons.mic_none,
            color: _isListening ? Colors.green : Colors.black54,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              t.speechStatusDisplay(_speechStatus),
              style: TextStyle(
                color: _isListening ? Colors.green : Colors.black54,
                fontWeight: FontWeight.w600,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAiSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF1976D2).withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.auto_awesome,
            color: Color(0xFF1976D2),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _aiSummary,
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

  Widget _buildAnalysisSourceChip() {
    final t = AppStrings.of(context);

    IconData icon;
    Color color;

    if (_analysisSource == _backendSource) {
      icon = Icons.cloud_done_outlined;
      color = Colors.green;
    } else if (_analysisSource == _fallbackSource) {
      icon = Icons.offline_bolt_outlined;
      color = Colors.orange;
    } else {
      icon = Icons.edit_note;
      color = Colors.blueGrey;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withValues(alpha: 0.28),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '${t.analysisSourcePrefix}: ${t.analysisSourceDisplay(_analysisSource)}',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomOptionsSection() {
    final t = AppStrings.of(context);

    final symptoms = [
      _SymptomOption(
        title: t.chestPainPressure,
        icon: Icons.favorite_border,
        value: chestPain,
        onChanged: (value) => setState(() => chestPain = value),
      ),
      _SymptomOption(
        title: t.radiatingPain,
        icon: Icons.call_made,
        value: painRadiation,
        onChanged: (value) => setState(() => painRadiation = value),
      ),
      _SymptomOption(
        title: t.shortnessOfBreathText,
        icon: Icons.air,
        value: shortnessOfBreath,
        onChanged: (value) => setState(() => shortnessOfBreath = value),
      ),
      _SymptomOption(
        title: t.coldSweatingText,
        icon: Icons.water_drop_outlined,
        value: coldSweating,
        onChanged: (value) => setState(() => coldSweating = value),
      ),
      _SymptomOption(
        title: t.nauseaText,
        icon: Icons.sick_outlined,
        value: nausea,
        onChanged: (value) => setState(() => nausea = value),
      ),
      _SymptomOption(
        title: t.dizzinessText,
        icon: Icons.blur_on,
        value: dizziness,
        onChanged: (value) => setState(() => dizziness = value),
      ),
      _SymptomOption(
        title: t.faintingFeelingText,
        icon: Icons.warning_amber_rounded,
        value: faintingFeeling,
        onChanged: (value) => setState(() => faintingFeeling = value),
      ),
    ];

    return _buildSectionCard(
      title: t.symptomOptionsTitle,
      icon: Icons.checklist_rounded,
      child: Column(
        children: symptoms.map(_buildSymptomOptionTile).toList(),
      ),
    );
  }

  Widget _buildSymptomOptionTile(_SymptomOption item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: item.value ? const Color(0xFFFFEBEE) : const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: item.value
              ? const Color(0xFFE53935).withValues(alpha: 0.28)
              : const Color(0xFFE6E8EC),
        ),
      ),
      child: SwitchListTile(
        value: item.value,
        onChanged: (value) {
          setState(() {
            _analysisSource = _manualSource;
          });
          item.onChanged(value);
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        secondary: Icon(
          item.icon,
          color: item.value ? const Color(0xFFE53935) : Colors.black45,
        ),
        title: Text(
          item.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: item.value ? const Color(0xFFE53935) : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildSeveritySection() {
    final t = AppStrings.of(context);

    return _buildSectionCard(
      title: t.severityAndDuration,
      icon: Icons.tune,
      child: Column(
        children: [
          _buildSliderCard(
            title: t.symptomDurationTitle,
            valueText: t.minutesValue(symptomDuration.toInt()),
            icon: Icons.access_time,
            color: Colors.deepPurple,
            slider: Slider(
              value: symptomDuration,
              min: 0,
              max: 60,
              divisions: 12,
              label: symptomDuration.toInt().toString(),
              onChanged: (value) {
                setState(() {
                  symptomDuration = value;
                  _analysisSource = _manualSource;
                });
              },
            ),
          ),
          const SizedBox(height: 12),
          _buildSliderCard(
            title: t.painSeverityTitle,
            valueText: t.painSeverityValue(painSeverity.toInt()),
            icon: Icons.speed,
            color: Colors.orange,
            slider: Slider(
              value: painSeverity,
              min: 1,
              max: 10,
              divisions: 9,
              label: painSeverity.toInt().toString(),
              onChanged: (value) {
                setState(() {
                  painSeverity = value;
                  _analysisSource = _manualSource;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderCard({
    required String title,
    required String valueText,
    required IconData icon,
    required Color color,
    required Widget slider,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              Text(
                valueText,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          slider,
        ],
      ),
    );
  }

  Widget _buildResultButton() {
    final t = AppStrings.of(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 18, bottom: 24),
      child: ElevatedButton.icon(
        onPressed: _calculateRisk,
        icon: const Icon(Icons.assignment_turned_in_outlined),
        label: Text(t.viewResult),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE53935),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppStrings.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: Text(t.symptomAssessmentTitle),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildHeaderCard(),
            _buildEmergencyWarningCard(),
            _buildSpeechInputSection(),
            _buildSymptomOptionsSection(),
            _buildSeveritySection(),
            _buildResultButton(),
          ],
        ),
      ),
    );
  }
}

class _SymptomOption {
  final String title;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SymptomOption({
    required this.title,
    required this.icon,
    required this.value,
    required this.onChanged,
  });
}
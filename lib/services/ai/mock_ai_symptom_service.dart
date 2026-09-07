import '../../models/ai_symptom_parse_result.dart';
import 'ai_symptom_service_base.dart';

class MockAISymptomService implements AISymptomServiceBase {
  @override
  Future<AISymptomParseResult> parseSymptoms({
    required String symptomText,
    required int age,
    required String gender,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    final text = symptomText.toLowerCase();

    final chestPain = text.contains('göğüs') ||
        text.contains('gogs') ||
        text.contains('kalp') ||
        text.contains('baskı') ||
        text.contains('sıkış');

    final painRadiation = text.contains('kol') ||
        text.contains('çene') ||
        text.contains('cene') ||
        text.contains('boyun') ||
        text.contains('sırt') ||
        text.contains('sirt');

    final shortnessOfBreath = text.contains('nefes') ||
        text.contains('daral') ||
        text.contains('nefes alam');

    final coldSweating = text.contains('ter') ||
        text.contains('soğuk ter') ||
        text.contains('soguk ter');

    final nausea = text.contains('mide bulant') ||
        text.contains('kus') ||
        text.contains('bulant');

    final dizziness = text.contains('baş dön') ||
        text.contains('bas don') ||
        text.contains('sersem');

    final faintingFeeling = text.contains('bayıl') ||
        text.contains('bayil') ||
        text.contains('göz karardı') ||
        text.contains('goz karardi');

    int durationMinutesEstimate = 5;
    int painSeverityEstimate = 4;

    if (text.contains('20 dakika') ||
        text.contains('20 dk') ||
        text.contains('yarım saat') ||
        text.contains('30 dakika')) {
      durationMinutesEstimate = 20;
    } else if (text.contains('1 saat') || text.contains('bir saat')) {
      durationMinutesEstimate = 60;
    } else if (text.contains('15 dakika') || text.contains('15 dk')) {
      durationMinutesEstimate = 15;
    }

    if (text.contains('çok şiddetli') ||
        text.contains('cok siddetli') ||
        text.contains('dayanılmaz') ||
        text.contains('dayanilmaz')) {
      painSeverityEstimate = 9;
    } else if (text.contains('şiddetli') || text.contains('siddetli')) {
      painSeverityEstimate = 7;
    } else if (text.contains('hafif')) {
      painSeverityEstimate = 3;
    }

    final detectedSymptoms = <String>[];

    if (chestPain) detectedSymptoms.add('göğüs ağrısı/baskı');
    if (painRadiation) detectedSymptoms.add('yayılan ağrı');
    if (shortnessOfBreath) detectedSymptoms.add('nefes darlığı');
    if (coldSweating) detectedSymptoms.add('soğuk terleme');
    if (nausea) detectedSymptoms.add('mide bulantısı');
    if (dizziness) detectedSymptoms.add('baş dönmesi');
    if (faintingFeeling) detectedSymptoms.add('bayılma hissi');

    final summary = detectedSymptoms.isEmpty
        ? 'Belirgin semptom çıkarılamadı.'
        : 'Metinden şu semptomlar çıkarıldı: ${detectedSymptoms.join(', ')}.';

    return AISymptomParseResult(
      chestPain: chestPain,
      painRadiation: painRadiation,
      shortnessOfBreath: shortnessOfBreath,
      coldSweating: coldSweating,
      nausea: nausea,
      dizziness: dizziness,
      faintingFeeling: faintingFeeling,
      durationMinutesEstimate: durationMinutesEstimate,
      painSeverityEstimate: painSeverityEstimate,
      summary: summary,
    );
  }
}
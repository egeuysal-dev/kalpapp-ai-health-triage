import '../models/risk_evaluation_result.dart';
import '../models/risk_input.dart';

class RiskEngineService {
  static RiskEvaluationResult evaluate(RiskInput input) {
    int score = 0;
    final List<String> reasons = [];

    if (input.chestPain) {
      score += 4;
      reasons.add('Göğüs ağrısı/baskı bildirildi.');
    }

    if (input.painRadiation) {
      score += 3;
      reasons.add('Ağrının kola, sırta, boyna veya çeneye yayılması bildirildi.');
    }

    if (input.shortnessOfBreath) {
      score += 3;
      reasons.add('Nefes darlığı bildirildi.');
    }

    if (input.coldSweating) {
      score += 2;
      reasons.add('Soğuk terleme bildirildi.');
    }

    if (input.nausea) {
      score += 1;
      reasons.add('Mide bulantısı bildirildi.');
    }

    if (input.dizziness) {
      score += 1;
      reasons.add('Baş dönmesi bildirildi.');
    }

    if (input.faintingFeeling) {
      score += 2;
      reasons.add('Bayılma hissi bildirildi.');
    }

    if (input.symptomDurationMinutes >= 30) {
      score += 3;
      reasons.add('Semptom süresi 30 dakika veya daha fazla.');
    } else if (input.symptomDurationMinutes >= 15) {
      score += 2;
      reasons.add('Semptom süresi 15 dakikadan fazla.');
    } else if (input.symptomDurationMinutes >= 5) {
      score += 1;
      reasons.add('Semptomlar birkaç dakikadır sürüyor.');
    }

    if (input.painSeverity >= 8) {
      score += 3;
      reasons.add('Ağrı şiddeti çok yüksek.');
    } else if (input.painSeverity >= 6) {
      score += 2;
      reasons.add('Ağrı şiddeti belirgin düzeyde.');
    }

    if (input.profile.age >= 65) {
      score += 2;
      reasons.add('İleri yaş ek risk oluşturuyor.');
    } else if (input.profile.age >= 50) {
      score += 1;
      reasons.add('50 yaş üzeri olmak riski artırıyor.');
    }

    if (input.profile.previousHeartAttack) {
      score += 3;
      reasons.add('Daha önce kalp krizi öyküsü var.');
    }

    if (input.profile.heartDisease) {
      score += 2;
      reasons.add('Kalp hastalığı öyküsü var.');
    }

    if (input.profile.hypertension) {
      score += 1;
      reasons.add('Hipertansiyon öyküsü var.');
    }

    if (input.profile.diabetes) {
      score += 1;
      reasons.add('Diyabet öyküsü var.');
    }

    if (input.profile.highCholesterol) {
      score += 1;
      reasons.add('Yüksek kolesterol öyküsü var.');
    }

    if (input.profile.smoking) {
      score += 1;
      reasons.add('Sigara kullanımı bildirildi.');
    }

    if (input.chestPain && input.painRadiation && input.shortnessOfBreath) {
      score += 4;
      reasons.add(
        'Göğüs ağrısı + yayılan ağrı + nefes darlığı kritik kombinasyon olarak değerlendirildi.',
      );
    }

    if (input.chestPain && input.coldSweating && input.nausea) {
      score += 2;
      reasons.add(
        'Göğüs ağrısı + soğuk terleme + mide bulantısı birlikte görüldü.',
      );
    }

    if (input.faintingFeeling && input.shortnessOfBreath) {
      score += 2;
      reasons.add(
        'Bayılma hissi ve nefes darlığı birlikte bildirildi.',
      );
    }

    String riskLevel;
    String resultMessage;
    String actionLevel;

    if (score >= 15) {
      riskLevel = 'Kritik Risk';
      resultMessage =
          'Belirtileriniz ciddi olabilir. Beklemeden 112 aranması önerilir.';
      actionLevel = 'Acil Eylem Gerekli';
    } else if (score >= 10) {
      riskLevel = 'Yüksek Risk';
      resultMessage =
          'Kalp krizi ile uyumlu olabilecek belirtiler mevcut. Acil tıbbi yardım alınması önerilir.';
      actionLevel = 'Bugün Acil Değerlendirme';
    } else if (score >= 5) {
      riskLevel = 'Orta Risk';
      resultMessage =
          'Önemli belirtiler mevcut. Kısa sürede tıbbi değerlendirme önerilir.';
      actionLevel = 'Yakın Sürede Doktor Görüşü';
    } else {
      riskLevel = 'Düşük Risk';
      resultMessage =
          'Mevcut belirtiler düşük riskli görünüyor. Şikayetler sürerse sağlık kuruluşuna başvurun.';
      actionLevel = 'Takip ve Gözlem';
    }

    return RiskEvaluationResult(
      score: score,
      riskLevel: riskLevel,
      resultMessage: resultMessage,
      actionLevel: actionLevel,
      reasons: reasons,
    );
  }
}
import express from "express";

const router = express.Router();

router.post("/parse-symptoms", async (req, res) => {
  try {
    const { symptomText, age, gender } = req.body;

    if (!symptomText || typeof symptomText !== "string") {
      return res.status(400).json({
        error: "symptomText zorunludur.",
      });
    }

    const text = symptomText.toLowerCase();

    const chestPain =
      text.includes("göğüs") ||
      text.includes("gogs") ||
      text.includes("kalp") ||
      text.includes("baskı") ||
      text.includes("sıkış");

    const painRadiation =
      text.includes("kol") ||
      text.includes("çene") ||
      text.includes("cene") ||
      text.includes("boyun") ||
      text.includes("sırt") ||
      text.includes("sirt");

    const shortnessOfBreath =
      text.includes("nefes") ||
      text.includes("daral") ||
      text.includes("nefes alam");

    const coldSweating =
      text.includes("ter") ||
      text.includes("soğuk ter") ||
      text.includes("soguk ter");

    const nausea =
      text.includes("mide bulant") ||
      text.includes("kus") ||
      text.includes("bulant");

    const dizziness =
      text.includes("baş dön") ||
      text.includes("bas don") ||
      text.includes("sersem");

    const faintingFeeling =
      text.includes("bayıl") ||
      text.includes("bayil") ||
      text.includes("göz karardı") ||
      text.includes("goz karardi");

    let durationMinutesEstimate = 5;
    let painSeverityEstimate = 4;

    if (
      text.includes("20 dakika") ||
      text.includes("20 dk") ||
      text.includes("yarım saat") ||
      text.includes("30 dakika")
    ) {
      durationMinutesEstimate = 20;
    } else if (text.includes("1 saat") || text.includes("bir saat")) {
      durationMinutesEstimate = 60;
    } else if (text.includes("15 dakika") || text.includes("15 dk")) {
      durationMinutesEstimate = 15;
    }

    if (
      text.includes("çok şiddetli") ||
      text.includes("cok siddetli") ||
      text.includes("dayanılmaz") ||
      text.includes("dayanilmaz")
    ) {
      painSeverityEstimate = 9;
    } else if (text.includes("şiddetli") || text.includes("siddetli")) {
      painSeverityEstimate = 7;
    } else if (text.includes("hafif")) {
      painSeverityEstimate = 3;
    }

    const detectedSymptoms = [];

    if (chestPain) detectedSymptoms.push("göğüs ağrısı/baskı");
    if (painRadiation) detectedSymptoms.push("yayılan ağrı");
    if (shortnessOfBreath) detectedSymptoms.push("nefes darlığı");
    if (coldSweating) detectedSymptoms.push("soğuk terleme");
    if (nausea) detectedSymptoms.push("mide bulantısı");
    if (dizziness) detectedSymptoms.push("baş dönmesi");
    if (faintingFeeling) detectedSymptoms.push("bayılma hissi");

    const summary =
      detectedSymptoms.length === 0
        ? "Belirgin semptom çıkarılamadı."
        : `Metinden şu semptomlar çıkarıldı: ${detectedSymptoms.join(", ")}.`;

    return res.json({
      chestPain,
      painRadiation,
      shortnessOfBreath,
      coldSweating,
      nausea,
      dizziness,
      faintingFeeling,
      durationMinutesEstimate,
      painSeverityEstimate,
      summary,
      source: "mock-backend",
      receivedAge: age ?? null,
      receivedGender: gender ?? null,
    });
  } catch (error) {
    console.error("parse-symptoms error:", error);

    return res.status(500).json({
      error: "Sunucu hatası oluştu.",
      details: error.message,
    });
  }
});

export default router;
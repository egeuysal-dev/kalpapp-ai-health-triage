import 'package:flutter/material.dart';
import '../core/widgets/section_card.dart';
import 'privacy_policy_screen.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const String appVersion = '1.0.0';
  static const String buildStatus = 'Geliştirme Sürümü';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uygulama Hakkında'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildHeaderCard(context),
            const SizedBox(height: 16),
            const SectionCard(
              title: 'Uygulamanın Amacı',
              child: Text(
                'KalpAPP, kalp krizi şüphesi oluşturabilecek belirtilerin kullanıcı tarafından hızlıca değerlendirilmesine yardımcı olmak amacıyla geliştirilmiştir.\n\n'
                'Kullanıcı; semptomlarını elle seçebilir, metin olarak yazabilir veya konuşarak giriş yapabilir. Uygulama bu verileri kural tabanlı risk motoru ve yapay zeka destekli semptom ayrıştırma sistemiyle değerlendirir.',
                style: TextStyle(height: 1.5),
              ),
            ),
            const SectionCard(
              title: 'Akıllı Bileklik Takibi',
              child: Text(
                'KalpAPP yalnızca bireysel semptom değerlendirme uygulaması değildir. Uygulama aynı zamanda kalp hastalığı riski taşıyan yakınların akıllı bileklik benzeri bir cihazla takip edilmesini hedefleyen bir erken uyarı platformu olarak tasarlanmıştır.\n\n'
                'Bu prototipte fiziksel bileklik yerine sanal/demo bileklik sistemi kullanılmaktadır. Kullanıcı, yakını için benzersiz bir cihaz kimliği ekleyebilir ve bu kişiye ait kalp ritmi durumlarını uygulama içinde takip edebilir.\n\n'
                'Gerçek üründe bu cihaz kimliği, fiziksel bileklikten gelen kalp ritmi ve sensör verileriyle eşleştirilecektir.',
                style: TextStyle(height: 1.5),
              ),
            ),
            const SectionCard(
              title: 'Yakın Takip Sistemi',
              child: Text(
                'Takip Ettiklerim bölümü sayesinde kullanıcı; dedesi, annesi, babası veya kalp hastalığı riski taşıyan başka bir yakını için profil oluşturabilir.\n\n'
                'Bu profilde kişinin yaşı, cinsiyeti, yakınlık derecesi, cihaz kimliği, hastalık geçmişi, kalp krizi öyküsü, hipertansiyon, diyabet, kolesterol ve kullanılan ilaçlar gibi bilgiler saklanabilir.\n\n'
                'Demo modunda düşük kalp ritmi, yüksek kalp ritmi ve kritik uyarı senaryoları simüle edilebilir.',
                style: TextStyle(height: 1.5),
              ),
            ),
            const SectionCard(
              title: 'Bileklik Uyarı Geçmişi',
              child: Text(
                'Uygulama, sanal bileklik üzerinden oluşan düşük ritim, yüksek ritim ve kritik ritim uyarılarını geçmişe kaydedebilir.\n\n'
                'Bu sayede kullanıcı sadece anlık uyarıyı değil, geçmişte oluşan bileklik olaylarını da uygulama içinden görüntüleyebilir.\n\n'
                'Gerçek üründe bu kayıtlar, fiziksel cihazdan gelen canlı ölçüm verileriyle oluşturulacaktır.',
                style: TextStyle(height: 1.5),
              ),
            ),
            const SectionCard(
              title: 'Tıbbi Uyarı',
              child: Text(
                'Bu uygulama tıbbi tanı koymaz, doktor yerine geçmez ve acil sağlık hizmetlerinin alternatifi değildir.\n\n'
                'Göğüs ağrısı, nefes darlığı, soğuk terleme, bayılma hissi veya kola/çeneye yayılan ağrı gibi ciddi belirtiler varsa uygulama sonucunu beklemeden 112 aranmalıdır.\n\n'
                'Bileklik uyarıları da kesin tanı anlamına gelmez; kritik uyarı alındığında kişinin durumu kontrol edilmeli ve ciddi belirti varsa acil yardım alınmalıdır.',
                style: TextStyle(
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SectionCard(
              title: 'Analiz Sistemi',
              child: Text(
                'KalpAPP şu anda hibrit bir analiz sistemi kullanır:\n\n'
                '• Kural tabanlı risk motoru\n'
                '• Mock backend AI semptom ayrıştırma\n'
                '• Backend erişilemezse yerel yedek analiz\n'
                '• Manuel semptom seçimi\n'
                '• Sanal bileklik kalp ritmi simülasyonu\n'
                '• Bileklik uyarı geçmişi kaydı\n\n'
                'Gerçek yapay zeka entegrasyonu, uygulamanın ana mimarisi hazır olduğu için ileride backend katmanında aktif edilebilir.',
                style: TextStyle(height: 1.5),
              ),
            ),
            const SectionCard(
              title: 'Veri ve Güvenlik',
              child: Text(
                'Uygulama; profil bilgileri, sağlık geçmişi, semptom değerlendirme sonuçları, takip edilen yakın bilgileri, sanal bileklik cihaz kimlikleri ve bileklik uyarı geçmişini Firebase altyapısı üzerinde kullanıcı hesabına bağlı olarak saklayabilir.\n\n'
                'Kullanıcı, Hesap ve Güvenlik ekranı üzerinden geçmişini, profil verilerini veya hesabını silebilir.',
                style: TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: 'Gizlilik',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gizlilik ve KVKK bilgilendirme metnini uygulama içinden görüntüleyebilirsiniz. Bileklik ve yakın takip sistemi sağlık verisi niteliğinde bilgiler içerebileceği için bu bölüm gerçek yayına geçmeden önce profesyonel hukuki danışmanlıkla güncellenmelidir.',
                    style: TextStyle(height: 1.5),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PrivacyPolicyScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.privacy_tip_outlined),
                      label: const Text('Gizlilik ve KVKK Metnini Aç'),
                    ),
                  ),
                ],
              ),
            ),
            const SectionCard(
              title: 'Proje Bilgisi',
              child: Text(
                'Bu uygulama yazılım mühendisliği projesi kapsamında geliştirilmiş olup, ileride gerçek bir sağlık destek uygulamasına dönüştürülebilecek şekilde tasarlanmaktadır.\n\n'
                'Proje; bireysel semptom değerlendirme, yapay zeka destekli semptom ayrıştırma, yakın takip sistemi, sanal bileklik demo modülü, acil durum yönlendirmesi, veri güvenliği ve sürdürülebilir yazılım mimarisi dikkate alınarak geliştirilmiştir.',
                style: TextStyle(height: 1.5),
              ),
            ),
            const SectionCard(
              title: 'Demo Modu Açıklaması',
              child: Text(
                'Bu geliştirme sürümünde bileklik verileri gerçek bir fiziksel cihazdan alınmamaktadır. Kalp ritmi ve uyarı durumları uygulama içindeki simülasyon butonlarıyla oluşturulur.\n\n'
                'Bu yaklaşım, ürün fikrini ve kullanıcı deneyimini göstermek için hazırlanmış prototip/demo mantığıdır.',
                style: TextStyle(height: 1.5),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'KalpAPP • Geliştirme Sürümü',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE53935), Color(0xFFD81B60)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(40, 229, 57, 53),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.favorite,
              color: Colors.white,
              size: 44,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'KalpAPP',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Yapay zeka ve akıllı bileklik destekli erken uyarı platformu',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.16),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              'Sürüm $appVersion • $buildStatus',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
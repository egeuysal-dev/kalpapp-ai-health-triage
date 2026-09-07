import 'package:flutter/material.dart';
import '../core/widgets/section_card.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gizlilik ve KVKK'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            SectionCard(
              title: 'Gizlilik Bilgilendirmesi',
              child: Text(
                'KalpAPP, kullanıcının kalp krizi şüphesi durumunda semptomlarını değerlendirmesine ve riskli yakınlarını takip etmesine yardımcı olmak amacıyla geliştirilmiştir.\n\n'
                'Bu uygulama tıbbi teşhis koymaz, doktor yerine geçmez ve yalnızca bilgilendirme, ön değerlendirme, demo takip ve erken uyarı amacı taşır.',
                style: TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: 'Toplanan Kullanıcı Verileri',
              child: Text(
                'Uygulama; ad soyad, yaş, cinsiyet, sağlık geçmişi, kullanılan ilaçlar, acil kişi bilgileri ve semptom değerlendirme sonuçlarını kaydedebilir.\n\n'
                'Bu veriler, kullanıcının profilini oluşturmak, değerlendirme geçmişini göstermek ve acil durumda daha hızlı yönlendirme sağlamak amacıyla kullanılır.',
                style: TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: 'Takip Edilen Yakın Verileri',
              child: Text(
                'KalpAPP içinde kullanıcı, kalp hastalığı riski taşıyan yakınlarını takip etmek için ayrı kayıtlar oluşturabilir.\n\n'
                'Bu kayıtlarda yakının adı, yakınlık derecesi, yaşı, cinsiyeti, cihaz kimliği, sağlık geçmişi, kalp krizi öyküsü, hipertansiyon, diyabet, kolesterol, sigara kullanımı ve ilaç bilgileri saklanabilir.\n\n'
                'Bu bilgiler hassas sağlık verisi niteliğinde olabilir.',
                style: TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: 'Bileklik ve Cihaz Kimliği',
              child: Text(
                'Uygulamada sanal bileklik sistemi bulunmaktadır. Kullanıcı, takip ettiği yakını için benzersiz bir cihaz kimliği ekleyebilir.\n\n'
                'Bu prototipte fiziksel bileklik bulunmadığı için cihaz verileri demo/simülasyon amacıyla oluşturulur.\n\n'
                'Gerçek üründe cihaz kimliği, fiziksel bileklikten gelen kalp ritmi ve sensör verileriyle eşleştirilebilir.',
                style: TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: 'Bileklik Uyarı Geçmişi',
              child: Text(
                'Uygulama, sanal bileklik üzerinden oluşan düşük kalp ritmi, yüksek kalp ritmi ve kritik uyarı olaylarını geçmişe kaydedebilir.\n\n'
                'Bu kayıtlar; takip edilen kişinin adı, cihaz kimliği, uyarı tipi, kalp ritmi değeri, açıklama mesajı ve tarih bilgisini içerebilir.\n\n'
                'Gerçek üründe bu veriler fiziksel cihazdan gelen ölçümlerle oluşturulacaktır.',
                style: TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: 'Sağlık Verileri',
              child: Text(
                'Kalp hastalığı geçmişi, daha önce geçirilen kalp krizi, diyabet, hipertansiyon, kolesterol, kalp ritmi değerleri ve benzeri bilgiler hassas sağlık verisi niteliğinde olabilir.\n\n'
                'Bu nedenle uygulama geliştirilirken kullanıcı verilerinin güvenli şekilde saklanması hedeflenmektedir.\n\n'
                'Gerçek yayın öncesinde KVKK ve ilgili sağlık verisi mevzuatına uygun profesyonel hukuki değerlendirme yapılmalıdır.',
                style: TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: 'Yapay Zeka Kullanımı',
              child: Text(
                'Uygulamadaki yapay zeka destekli özellikler, kullanıcının serbest metin olarak yazdığı veya konuşarak aktardığı semptomları yapılandırılmış semptom alanlarına dönüştürmek için kullanılabilir.\n\n'
                'Yapay zeka sistemi tek başına teşhis koymaz ve nihai tıbbi karar vermez. Risk değerlendirme, kural tabanlı sistem ile birlikte çalışır.',
                style: TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: 'Konuşma ile Semptom Girişi',
              child: Text(
                'Uygulama, kullanıcının yazı yazamayacağı durumları dikkate alarak konuşma ile semptom girişi özelliği sunabilir.\n\n'
                'Bu özellik cihazın mikrofon iznine ihtiyaç duyabilir. Konuşma tanıma işlemi cihazın veya kullanılan platformun konuşma tanıma altyapısına bağlı olarak çalışabilir.',
                style: TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: 'Verilerin Kullanım Amacı',
              child: Text(
                'Toplanan veriler; semptom değerlendirmesi yapmak, değerlendirme geçmişini göstermek, takip edilen yakınların durumunu izlemek, bileklik uyarılarını göstermek, demo ürün deneyimi sunmak ve kullanıcıya acil durumda daha hızlı yönlendirme sağlamak amacıyla kullanılabilir.',
                style: TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: 'Acil Durum Uyarısı',
              child: Text(
                'Göğüs ağrısı, nefes darlığı, soğuk terleme, bayılma hissi veya kola/çeneye yayılan ağrı gibi ciddi belirtiler varsa vakit kaybetmeden 112 aranmalıdır.\n\n'
                'Bileklik uyarıları da kesin tıbbi tanı anlamına gelmez. Kritik ritim uyarısı alındığında kişi kontrol edilmeli ve ciddi belirti varsa acil yardım alınmalıdır.\n\n'
                'Uygulamadaki sonuçlar kesin tıbbi tanı değildir.',
                style: TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: 'Demo ve Prototip Açıklaması',
              child: Text(
                'Bu geliştirme sürümünde bileklik verileri gerçek bir fiziksel cihazdan alınmamaktadır. Kalp ritmi ve uyarı durumları uygulama içindeki simülasyon butonlarıyla oluşturulur.\n\n'
                'Bu özellik, ürün fikrini ve kullanıcı deneyimini göstermek için hazırlanmış demo/prototip işlevdir.',
                style: TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: 'Veri Silme',
              child: Text(
                'Kullanıcı, Hesap ve Güvenlik ekranından değerlendirme geçmişini, profil verilerini veya hesabını silebilir.\n\n'
                'Bileklik uyarı geçmişi, ilgili geçmiş ekranından silinebilir.\n\n'
                'Hesap silme işlemi geri alınamaz.',
                style: TextStyle(height: 1.5),
              ),
            ),
            SectionCard(
              title: 'Not',
              child: Text(
                'Bu metin geliştirme aşaması için hazırlanmış taslak bilgilendirmedir. Uygulama gerçek kullanıma açılmadan önce hukuki danışmanlık alınarak KVKK, gizlilik politikası, açık rıza metni ve kullanım şartları profesyonel şekilde hazırlanmalıdır.\n\n'
                'Özellikle sağlık verileri ve üçüncü kişilere ait yakın takip verileri için açık rıza, veri güvenliği ve saklama politikaları ayrıca değerlendirilmelidir.',
                style: TextStyle(height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
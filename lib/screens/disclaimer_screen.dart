import 'package:flutter/material.dart';
import '../core/widgets/primary_button.dart';
import '../core/widgets/section_card.dart';
import 'profile_screen.dart';

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE53935), Color(0xFFD81B60)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(30, 229, 57, 53),
                      blurRadius: 18,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.health_and_safety_outlined,
                      color: Colors.white,
                      size: 54,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'KalpAPP’e Hoş Geldiniz',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Kalp krizi şüphesi durumunda hızlı değerlendirme ve yönlendirme için tasarlanmıştır.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: SectionCard(
                  title: 'Önemli Uyarı',
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: Color(0xFFE53935),
                            size: 28,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Lütfen devam etmeden önce okuyun',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1D1D1F),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
                      Text(
                        '• Bu uygulama yalnızca bilgilendirme amaçlıdır.\n\n'
                        '• Tıbbi teşhis koymaz ve doktor yerine geçmez.\n\n'
                        '• Yüksek risk durumlarında mutlaka 112 aranmalıdır.\n\n'
                        '• Şikayetleriniz sürüyorsa en yakın sağlık kuruluşuna başvurunuz.',
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.7,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 18),
                      Text(
                        'Devam ederek bu bilgilendirmeyi okuduğunuzu kabul etmiş olursunuz.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              PrimaryButton(
                text: 'Kabul Ediyorum ve Devam Et',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProfileScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
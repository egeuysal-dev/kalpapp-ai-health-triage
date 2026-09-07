# KalpAPP

KalpAPP is an AI-assisted mobile health awareness prototype developed to support individuals who may be at risk of heart attack and their family members.

The application allows users to enter possible heart attack symptoms manually, through text input, or by voice input. Based on the provided information, the system presents a risk score, risk level, risk reasons, and action suggestions. The project also includes a virtual wearable device scenario for monitoring family members through a smart bracelet or smartwatch concept.

## Medical Disclaimer

KalpAPP does not provide medical diagnosis and is not a replacement for doctors, hospitals, or emergency medical services.

The application is developed only as an educational prototype and health awareness support tool. In serious symptoms such as chest pain, shortness of breath, fainting, cold sweating, or pain spreading to the arm or jaw, users should contact emergency medical services immediately.

## Features

* User registration and login
* Health profile management
* Manual symptom selection
* Text-based symptom input
* Voice-based symptom input
* AI-assisted risk assessment structure
* Mock AI and local fallback analysis logic
* Risk score and risk level display
* Risk reasons and action suggestions
* Emergency guidance flow
* Assessment history
* Family monitoring module
* Virtual smart bracelet / smartwatch device ID
* Wearable alert history
* Active wearable alert scenario

## Tech Stack

* Flutter
* Dart
* Firebase Authentication
* Cloud Firestore
* Firebase configuration
* Local fallback analysis logic
* Mock AI service structure

## Project Architecture

KalpAPP is designed as a mobile-first health awareness prototype. The application collects user profile data and symptom inputs, processes them through an AI-assisted risk assessment structure, and displays the result with a risk level, score, reasons, and action guidance.

User authentication and data storage are handled with Firebase services. The wearable device concept is represented through a virtual device ID and simulated heart-rate alert data. This structure allows the project to demonstrate future smart bracelet or smartwatch integration without requiring physical hardware during the prototype phase.

## Installation

### Requirements

* Flutter SDK
* Dart SDK
* Android Studio or Visual Studio Code
* Firebase project configuration

### Clone the Repository

```bash
git clone https://github.com/your-username/kalpapp.git
cd kalpapp
```

### Install Dependencies

```bash
flutter pub get
```

### Run the Application

```bash
flutter run
```

## Firebase Setup

This project uses Firebase Authentication and Cloud Firestore.

Firebase configuration files are not shared publicly for security reasons. To run the project with your own Firebase project, create a Firebase project and add the required platform configuration files to the application.

## Project Status

KalpAPP is a working software engineering course prototype.

The current version demonstrates the main user flows, including symptom assessment, risk result generation, emergency guidance, family monitoring, and virtual wearable alert simulation. Real medical usage would require clinical validation, legal compliance, data security review, and expert medical evaluation.

## Future Development

* Real smartwatch or smart bracelet integration
* Push notification support
* Advanced AI-based symptom analysis
* Caregiver or doctor dashboard
* Clinical validation process
* KVKK/GDPR-compliant consent and data management
* Premium subscription and ad-free usage model

## Developer

Ege Uysal
Computer Engineering Student

GitHub: https://github.com/egeuysal-dev

---

# KalpAPP Türkçe Açıklama

KalpAPP, kalp krizi riski taşıyabilecek bireyler ve bu bireylerin yakınları için geliştirilen yapay zeka destekli mobil sağlık farkındalık prototipidir.

Uygulama, kullanıcının kalp krizi şüphesi oluşturabilecek semptomlarını manuel seçim, yazılı giriş veya sesli giriş yoluyla alır. Girilen bilgilere göre sistem; risk skoru, risk seviyesi, risk nedenleri ve aksiyon önerisi sunar. Projede ayrıca aile bireylerinin sanal akıllı bileklik veya akıllı saat senaryosu üzerinden takip edilmesini temsil eden bir yakın takip modülü bulunmaktadır.

## Tıbbi Uyarı

KalpAPP tıbbi tanı koymaz ve doktor, hastane veya acil sağlık hizmetlerinin yerine geçmez.

Uygulama yalnızca eğitim amaçlı bir prototip ve sağlık farkındalık destek aracı olarak geliştirilmiştir. Göğüs ağrısı, nefes darlığı, bayılma hissi, soğuk terleme veya kola/çeneye yayılan ağrı gibi ciddi belirtilerde kullanıcı doğrudan acil sağlık hizmetlerine başvurmalıdır.

## Özellikler

* Kullanıcı kayıt ve giriş sistemi
* Sağlık profili yönetimi
* Manuel semptom seçimi
* Yazılı semptom girişi
* Sesli semptom girişi
* Yapay zeka destekli risk değerlendirme yapısı
* Mock AI ve yerel yedek analiz mantığı
* Risk skoru ve risk seviyesi gösterimi
* Risk nedenleri ve aksiyon önerileri
* Acil yönlendirme akışı
* Değerlendirme geçmişi
* Yakın takip modülü
* Sanal akıllı bileklik / akıllı saat cihaz kimliği
* Giyilebilir cihaz uyarı geçmişi
* Aktif giyilebilir cihaz uyarı senaryosu

## Kullanılan Teknolojiler

* Flutter
* Dart
* Firebase Authentication
* Cloud Firestore
* Firebase yapılandırması
* Yerel yedek analiz mantığı
* Mock AI servis yapısı

## Proje Mimarisi

KalpAPP mobil öncelikli bir sağlık farkındalık prototipi olarak tasarlanmıştır. Uygulama, kullanıcı profil bilgilerini ve semptom girişlerini alır, bu verileri yapay zeka destekli risk değerlendirme yapısı üzerinden işler ve sonucu risk seviyesi, risk skoru, risk nedenleri ve aksiyon önerisi olarak kullanıcıya sunar.

Kullanıcı kimlik doğrulama ve veri saklama işlemleri Firebase servisleriyle yönetilmektedir. Giyilebilir cihaz konsepti, sanal cihaz kimliği ve simüle edilmiş kalp ritmi uyarı verileriyle temsil edilmektedir. Bu yapı, fiziksel donanım gerektirmeden gelecekteki akıllı bileklik veya akıllı saat entegrasyonu mantığını göstermeyi sağlar.

## Kurulum

### Gereksinimler

* Flutter SDK
* Dart SDK
* Android Studio veya Visual Studio Code
* Firebase proje yapılandırması

### Repoyu Klonlama

```bash
git clone https://github.com/kullaniciadi/kalpapp.git
cd kalpapp
```

### Bağımlılıkları Yükleme

```bash
flutter pub get
```

### Uygulamayı Çalıştırma

```bash
flutter run
```

## Firebase Kurulumu

Bu proje Firebase Authentication ve Cloud Firestore kullanmaktadır.

Güvenlik nedeniyle Firebase yapılandırma dosyaları herkese açık şekilde paylaşılmamıştır. Projeyi kendi Firebase hesabınızla çalıştırmak için Firebase projesi oluşturulmalı ve gerekli platform yapılandırma dosyaları uygulamaya eklenmelidir.

## Proje Durumu

KalpAPP, yazılım mühendisliği dersi kapsamında geliştirilmiş çalışan bir prototiptir.

Mevcut sürüm; semptom değerlendirme, risk sonucu üretme, acil yönlendirme, yakın takip ve sanal giyilebilir cihaz uyarı simülasyonu gibi temel kullanıcı akışlarını göstermektedir. Gerçek medikal kullanım için klinik doğrulama, hukuki uyumluluk, veri güvenliği incelemesi ve uzman tıbbi değerlendirme gereklidir.

## Gelecek Geliştirmeler

* Gerçek akıllı saat veya akıllı bileklik entegrasyonu
* Anlık bildirim desteği
* Gelişmiş yapay zeka destekli semptom analizi
* Bakım veren veya doktor paneli
* Klinik doğrulama süreci
* KVKK/GDPR uyumlu açık rıza ve veri yönetimi
* Premium abonelik ve reklamsız kullanım modeli

## Geliştirici

Ege Uysal
Bilgisayar Mühendisliği Öğrencisi

GitHub: https://github.com/egeuysal-dev

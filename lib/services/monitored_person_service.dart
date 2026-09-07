import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../models/bracelet_alert.dart';
import '../models/monitored_person.dart';

class MonitoredPersonService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static String get _uid {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('Kullanıcı giriş yapmamış');
    }

    return user.uid;
  }

  static DocumentReference<Map<String, dynamic>> get _userDoc =>
      _firestore.collection('users').doc(_uid);

  static CollectionReference<Map<String, dynamic>> get _collection =>
      _userDoc.collection('monitoredPersons');

  static CollectionReference<Map<String, dynamic>> get _alertsCollection =>
      _userDoc.collection('braceletAlerts');

  static Stream<List<MonitoredPerson>> monitoredPeopleStream() {
    return _collection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => MonitoredPerson.fromMap(
                  doc.id,
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  static Stream<List<BraceletAlert>> braceletAlertsStream() {
    return _alertsCollection
        .orderBy('createdAtServer', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => BraceletAlert.fromMap(
                  doc.id,
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  static Future<void> addPerson(MonitoredPerson person) async {
    await _collection.add({
      ...person.toMap(),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> updatePerson(MonitoredPerson person) async {
    await _collection.doc(person.id).update({
      ...person.toMap(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> deletePerson(String id) async {
    await _collection.doc(id).delete();
  }

  static Future<void> clearBraceletAlerts() async {
    final snapshot = await _alertsCollection.get();

    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  static Future<MonitoredPerson?> _getPerson(String id) async {
    final doc = await _collection.doc(id).get();

    if (!doc.exists || doc.data() == null) {
      return null;
    }

    return MonitoredPerson.fromMap(doc.id, doc.data()!);
  }

  static String _nowText() {
    return DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now());
  }

  static Future<void> _createBraceletAlert({
    required String personId,
    required String alertType,
    required int heartRate,
    required String message,
  }) async {
    final person = await _getPerson(personId);

    if (person == null) return;

    final alert = BraceletAlert(
      id: '',
      personId: person.id,
      personName: person.fullName,
      deviceId: person.deviceId,
      alertType: alertType,
      heartRate: heartRate,
      message: message,
      createdAtText: _nowText(),
    );

    await _alertsCollection.add({
      ...alert.toMap(),
      'createdAtServer': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> simulateNormal(String id) async {
    await _collection.doc(id).update({
      'heartRate': 74,
      'status': 'Normal',
      'lastMeasurement': 'Az önce',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> simulateLowHeartRate(String id) async {
    const heartRate = 46;
    const status = 'Düşük kalp ritmi uyarısı';

    await _collection.doc(id).update({
      'heartRate': heartRate,
      'status': status,
      'lastMeasurement': 'Az önce',
      'updatedAt': FieldValue.serverTimestamp(),
    });

    await _createBraceletAlert(
      personId: id,
      alertType: status,
      heartRate: heartRate,
      message:
          'Bileklik düşük kalp ritmi algıladı. Kişinin durumu kontrol edilmelidir.',
    );
  }

  static Future<void> simulateHighHeartRate(String id) async {
    const heartRate = 128;
    const status = 'Yüksek kalp ritmi uyarısı';

    await _collection.doc(id).update({
      'heartRate': heartRate,
      'status': status,
      'lastMeasurement': 'Az önce',
      'updatedAt': FieldValue.serverTimestamp(),
    });

    await _createBraceletAlert(
      personId: id,
      alertType: status,
      heartRate: heartRate,
      message:
          'Bileklik yüksek kalp ritmi algıladı. Aktivite, stres veya tıbbi durum açısından kontrol önerilir.',
    );
  }

  static Future<void> simulateCriticalAlert(String id) async {
    const heartRate = 42;
    const status = 'Kritik uyarı';

    await _collection.doc(id).update({
      'heartRate': heartRate,
      'status': status,
      'lastMeasurement': 'Az önce',
      'updatedAt': FieldValue.serverTimestamp(),
    });

    await _createBraceletAlert(
      personId: id,
      alertType: status,
      heartRate: heartRate,
      message:
          'Bileklik kritik kalp ritmi algıladı. Kişi hemen kontrol edilmeli; bilinç kaybı, göğüs ağrısı veya nefes darlığı varsa 112 aranmalıdır.',
    );
  }
}
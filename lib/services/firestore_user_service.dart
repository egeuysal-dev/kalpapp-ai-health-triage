import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_profile.dart';
import '../models/assessment_result.dart';

class FirestoreUserService {
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

  static DocumentReference<Map<String, dynamic>> get _profile =>
      _userDoc.collection('profile').doc('main');

  static CollectionReference<Map<String, dynamic>> get _assessments =>
      _userDoc.collection('assessments');

  static Future<void> saveProfile(UserProfile profile) async {
    await _userDoc.set({
      'email': _auth.currentUser?.email,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    await _profile.set({
      ...profile.toMap(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<UserProfile?> loadProfile() async {
    final doc = await _profile.get();

    if (!doc.exists) return null;

    return UserProfile.fromMap(doc.data()!);
  }

  static Stream<UserProfile?> profileStream() {
    return _profile.snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) return null;
      return UserProfile.fromMap(doc.data()!);
    });
  }

  static Future<void> saveAssessment(AssessmentResult result) async {
    await _assessments.add({
      ...result.toMap(),
      'createdAtServer': FieldValue.serverTimestamp(),
    });
  }

  static Future<List<AssessmentResult>> loadAssessments() async {
    final snapshot = await _assessments
        .orderBy('createdAtServer', descending: true)
        .get();

    return snapshot.docs
        .map((e) => AssessmentResult.fromMap(e.data()))
        .toList();
  }

  static Stream<List<AssessmentResult>> assessmentsStream() {
    return _assessments
        .orderBy('createdAtServer', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => AssessmentResult.fromMap(doc.data()))
              .toList(),
        );
  }

  static Future<void> clearAssessments() async {
    final snapshot = await _assessments.get();

    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  static Future<void> deleteProfile() async {
    await _profile.delete();
  }

  static Future<void> deleteAllUserData() async {
    await clearAssessments();

    final profileSnapshot = await _userDoc.collection('profile').get();
    for (final doc in profileSnapshot.docs) {
      await doc.reference.delete();
    }

    await _userDoc.delete();
  }
}
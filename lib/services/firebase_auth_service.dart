import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;

  static String? get currentUserEmail => _auth.currentUser?.email;

  static bool get isLoggedIn => _auth.currentUser != null;

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Future<String?> register({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return _mapError(e);
    } catch (_) {
      return 'Beklenmeyen bir hata oluştu.';
    }
  }

  static Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return _mapError(e);
    } catch (_) {
      return 'Beklenmeyen bir hata oluştu.';
    }
  }

  static Future<String?> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return _mapError(e);
    } catch (_) {
      return 'Şifre sıfırlama e-postası gönderilirken bir hata oluştu.';
    }
  }

  static Future<String?> deleteCurrentUser() async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        return 'Giriş yapmış kullanıcı bulunamadı.';
      }

      await user.delete();
      return null;
    } on FirebaseAuthException catch (e) {
      return _mapError(e);
    } catch (_) {
      return 'Hesap silinirken beklenmeyen bir hata oluştu.';
    }
  }

  static String _mapError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Bu e-posta ile zaten kayıt var.';
      case 'invalid-email':
        return 'Geçerli bir e-posta girin.';
      case 'weak-password':
        return 'Şifre çok zayıf.';
      case 'user-not-found':
        return 'Bu e-posta ile kayıtlı kullanıcı bulunamadı.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'E-posta veya şifre hatalı.';
      case 'too-many-requests':
        return 'Çok fazla deneme yapıldı. Biraz sonra tekrar deneyin.';
      case 'network-request-failed':
        return 'İnternet bağlantısı hatası.';
      case 'requires-recent-login':
        return 'Güvenlik nedeniyle hesabı silmeden önce tekrar giriş yapmanız gerekiyor.';
      default:
        return e.message ?? 'Bir hata oluştu.';
    }
  }
}
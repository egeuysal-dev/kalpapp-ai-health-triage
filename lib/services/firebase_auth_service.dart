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
    bool isEnglish = false,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return _mapError(e, isEnglish: isEnglish);
    } catch (_) {
      return isEnglish
          ? 'An unexpected error occurred.'
          : 'Beklenmeyen bir hata oluştu.';
    }
  }

  static Future<String?> login({
    required String email,
    required String password,
    bool isEnglish = false,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return _mapError(e, isEnglish: isEnglish);
    } catch (_) {
      return isEnglish
          ? 'An unexpected error occurred.'
          : 'Beklenmeyen bir hata oluştu.';
    }
  }

  static Future<String?> sendPasswordResetEmail({
    required String email,
    bool isEnglish = false,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return _mapError(e, isEnglish: isEnglish);
    } catch (_) {
      return isEnglish
          ? 'An error occurred while sending the password reset email.'
          : 'Şifre sıfırlama e-postası gönderilirken bir hata oluştu.';
    }
  }

  static Future<String?> deleteCurrentUser({
    bool isEnglish = false,
  }) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        return isEnglish
            ? 'No signed-in user was found.'
            : 'Giriş yapmış kullanıcı bulunamadı.';
      }

      await user.delete();
      return null;
    } on FirebaseAuthException catch (e) {
      return _mapError(e, isEnglish: isEnglish);
    } catch (_) {
      return isEnglish
          ? 'An unexpected error occurred while deleting the account.'
          : 'Hesap silinirken beklenmeyen bir hata oluştu.';
    }
  }

  static bool isRecentLoginRequiredMessage(String message) {
    final normalized = message.toLowerCase();

    return normalized.contains('tekrar giriş') ||
        normalized.contains('sign in again') ||
        normalized.contains('recent login');
  }

  static String _mapError(
    FirebaseAuthException e, {
    required bool isEnglish,
  }) {
    switch (e.code) {
      case 'email-already-in-use':
        return isEnglish
            ? 'An account already exists with this email address.'
            : 'Bu e-posta ile zaten kayıt var.';

      case 'invalid-email':
        return isEnglish
            ? 'Please enter a valid email address.'
            : 'Geçerli bir e-posta girin.';

      case 'weak-password':
        return isEnglish
            ? 'The password is too weak.'
            : 'Şifre çok zayıf.';

      case 'user-not-found':
        return isEnglish
            ? 'No user account was found with this email address.'
            : 'Bu e-posta ile kayıtlı kullanıcı bulunamadı.';

      case 'wrong-password':
      case 'invalid-credential':
        return isEnglish
            ? 'Email or password is incorrect.'
            : 'E-posta veya şifre hatalı.';

      case 'too-many-requests':
        return isEnglish
            ? 'Too many attempts were made. Please try again later.'
            : 'Çok fazla deneme yapıldı. Biraz sonra tekrar deneyin.';

      case 'network-request-failed':
        return isEnglish
            ? 'Network connection error.'
            : 'İnternet bağlantısı hatası.';

      case 'requires-recent-login':
        return isEnglish
            ? 'For security reasons, you need to sign in again before deleting the account.'
            : 'Güvenlik nedeniyle hesabı silmeden önce tekrar giriş yapmanız gerekiyor.';

      case 'operation-not-allowed':
        return isEnglish
            ? 'This sign-in method is not enabled.'
            : 'Bu giriş yöntemi etkin değil.';

      case 'user-disabled':
        return isEnglish
            ? 'This user account has been disabled.'
            : 'Bu kullanıcı hesabı devre dışı bırakılmış.';

      default:
        return e.message ??
            (isEnglish ? 'An error occurred.' : 'Bir hata oluştu.');
    }
  }
}
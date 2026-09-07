import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStorageService {
  static const String _usersKey = 'registered_users';
  static const String _loggedInUserKey = 'logged_in_user';

  static Future<List<Map<String, dynamic>>> _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_usersKey);

    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  static Future<void> _saveUsers(List<Map<String, dynamic>> users) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usersKey, jsonEncode(users));
  }

  static Future<bool> register({
    required String email,
    required String password,
  }) async {
    final users = await _loadUsers();

    final alreadyExists = users.any(
      (user) => (user['email'] as String).toLowerCase() == email.toLowerCase(),
    );

    if (alreadyExists) {
      return false;
    }

    users.add({
      'email': email,
      'password': password,
    });

    await _saveUsers(users);
    return true;
  }

  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    final users = await _loadUsers();

    final matched = users.any(
      (user) =>
          (user['email'] as String).toLowerCase() == email.toLowerCase() &&
          user['password'] == password,
    );

    if (!matched) return false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_loggedInUserKey, email);
    return true;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loggedInUserKey);
  }

  static Future<String?> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_loggedInUserKey);
  }

  static Future<bool> isLoggedIn() async {
    final user = await getLoggedInUser();
    return user != null && user.isNotEmpty;
  }
}
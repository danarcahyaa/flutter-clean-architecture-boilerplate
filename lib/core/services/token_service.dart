import 'package:shared_preferences/shared_preferences.dart';

/// A local storage service dedicated to managing authentication tokens.
///
/// This service acts as the source of truth for the user's current
/// authentication state in the local data layer.
class TokenService {
  final SharedPreferences _prefs;

  TokenService(this._prefs);

  /// Key used to store the authentication token in persistent storage.
  static const String _tokenKey = 'auth_token';

  /// Retrieves the stored authentication token.
  ///
  /// Returns `null` if the user is not authenticated or the token has been cleared.
  String? getToken() {
    return _prefs.getString(_tokenKey);
  }

  /// Persists a new authentication token.
  ///
  /// This should be called immediately after a successful login or
  /// token refresh operation.
  Future<void> saveToken(String token) async {
    await _prefs.setString(_tokenKey, token);
  }

  /// Removes the stored token, effectively logging the user out locally.
  Future<void> clearTokens() async {
    await _prefs.remove(_tokenKey);
  }

  /// Checks if an authentication token exists.
  ///
  /// Useful for quick route guarding during app startup (e.g., in Splash Screen).
  bool hasToken() {
    return _prefs.containsKey(_tokenKey);
  }
}
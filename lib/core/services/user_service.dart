import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/user/data/models/user_model.dart';
import '../../features/user/domain/entities/user.dart';

/// A service dedicated to managing persistent user data locally.
///
/// This service acts as a bridge between the application and [SharedPreferences],
/// providing easy methods to save, retrieve, and clear user session data.
class UserService {
  final SharedPreferences _prefs;

  /// The unique key used to store user data in the local storage.
  static const String _userKey = 'USER_DATA';

  UserService(this._prefs);

  /// Serializes and saves a [User] object to local storage.
  ///
  /// Returns the saved [User] object if successful, or `null` if the operation fails.
  /// Note: The [user] parameter must be castable to [UserModel] to access `toJson()`.
  Future<User?> saveUser(User user) async {
    // Assuming user is an instance of UserModel to access toJson()
    if (user is! UserModel) return null;

    final String userJson = jsonEncode(user.toJson());
    final result = await _prefs.setString(_userKey, userJson);

    if (result) return getUser();
    return null;
  }

  /// Retrieves the stored user data from local storage.
  ///
  /// Returns a [User] instance if the data exists, or `null` if no user
  /// data is found or the data is invalid.
  User? getUser() {
    final String? userJson = _prefs.getString(_userKey);
    if (userJson == null) return null;

    try {
      return UserModel.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  /// Removes the stored user data from local storage.
  ///
  /// Commonly used during the logout process to clear the user session.
  Future<bool> clearUser() async {
    return await _prefs.remove(_userKey);
  }
}
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {
  // Base URLs
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? 'API_BASE_URL_NOT_FOUND';
  static String get baseUrl => dotenv.env['BASE_URL'] ?? 'BASE_URL_NOT_FOUND';
  static String get mockBaseUrl => dotenv.env['MOCK_API_BASE_URL'] ?? 'MOCK_BASE_URL_NOT_FOUND';

  // Headers
  static String get contentTypeJson => 'application/json';
  static String get contentTypeMultipart => 'multipart/form-data';

  // Timeouts
  static Duration get connectionTimeout => Duration(seconds: 30);
  static Duration get receiveTimeout => Duration(seconds: 30);
}
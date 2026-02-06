
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import '../constant/api_constant.dart';
import '../errors/exceptions.dart';
import '../services/token_service.dart';
import '../utils/typedef.dart';

abstract class BaseRemoteDataSource {
  /// Get raw response as Map
  Future<DataMap> get({
    required String endpoint,
    Map<String, String>? queryParameters,
    bool requiresAuth = false,
  });

  /// Post and return raw response as Map
  Future<DataMap> post({
    required String endpoint,
    DataMap? body,
    bool requiresAuth = false,
  });

  /// Put and return raw response as Map
  Future<DataMap> put({
    required String endpoint,
    DataMap? body,
    bool requiresAuth = false,
  });

  /// Delete (no return)
  Future<void> delete({
    required String endpoint,
    DataMap? body,
    bool requiresAuth = false,
  });

  /// File upload
  Future<DataMap> upload({
    required String endpoint,
    required File file,
    String fieldName = 'file',
    DataMap? body,
    bool requiresAuth = true,
  });
}

class BaseRemoteDataSourceImpl implements BaseRemoteDataSource {
  final http.Client client;
  final TokenService tokenService;

  BaseRemoteDataSourceImpl({
    required this.client,
    required this.tokenService,
  });

  // Base URL
  String get baseUrl => AppConfig.baseUrl;

  // Default headers
  Map<String, String> get _defaultHeaders => {
    'Content-Type': ApiConstants.contentTypeJson,
    'Accept': 'application/json',
  };

  // Auth headers
  Map<String, String> _getAuthHeaders() {
    final token = tokenService.getToken();
    return {
      ..._defaultHeaders,
      'Authorization': 'Bearer $token',
    };
  }

  // GET Request - Returns raw Map
  @override
  Future<DataMap> get({
    required String endpoint,
    Map<String, String>? queryParameters,
    bool requiresAuth = false,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint')
          .replace(queryParameters: queryParameters);

      final headers = requiresAuth ? _getAuthHeaders() : _defaultHeaders;

      _logRequest('GET', uri.toString(), headers);

      final response = await client
          .get(uri, headers: headers)
          .timeout(ApiConstants.connectionTimeout);

      _logResponse(response);

      return _handleResponse(response);
    } on SocketException {
      throw NetworkException(message: 'No internet connection');
    } on http.ClientException {
      throw NetworkException(message: 'Failed to connect to server');
    }
  }

  // POST Request - Returns raw Map
  @override
  Future<DataMap> post({
    required String endpoint,
    DataMap? body,
    bool requiresAuth = false,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final headers = requiresAuth ? _getAuthHeaders() : _defaultHeaders;

      _logRequest('POST', uri.toString(), headers, body);

      final response = await client
          .post(
        uri,
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      )
          .timeout(ApiConstants.connectionTimeout);

      _logResponse(response);

      return _handleResponse(response);
    } on SocketException {
      throw NetworkException(message: 'No internet connection');
    } on http.ClientException {
      throw NetworkException(message: 'Failed to connect to server');
    }
  }

  // PUT Request - Returns raw Map
  @override
  Future<DataMap> put({
    required String endpoint,
    DataMap? body,
    bool requiresAuth = false,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final headers = requiresAuth ? _getAuthHeaders() : _defaultHeaders;

      _logRequest('PUT', uri.toString(), headers, body);

      final response = await client
          .put(
        uri,
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      )
          .timeout(ApiConstants.connectionTimeout);

      _logResponse(response);

      return _handleResponse(response);
    } on SocketException {
      throw NetworkException(message: 'No internet connection');
    } on http.ClientException {
      throw NetworkException(message: 'Failed to connect to server');
    }
  }

  // DELETE Request - No return
  @override
  Future<void> delete({
    required String endpoint,
    DataMap? body,
    bool requiresAuth = false,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final headers = requiresAuth ? _getAuthHeaders() : _defaultHeaders;

      _logRequest('DELETE', uri.toString(), headers, body);

      final response = await client
          .delete(
        uri,
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      )
          .timeout(ApiConstants.connectionTimeout);

      _logResponse(response);

      _handleDeleteResponse(response);
    } on SocketException {
      throw NetworkException(message: 'No internet connection');
    } on http.ClientException {
      throw NetworkException(message: 'Failed to connect to server');
    }
  }

  // UPLOAD file only
  @override
  Future<DataMap> upload({
    required String endpoint,
    required File file,
    String fieldName = 'file',
    DataMap? body,
    bool requiresAuth = true,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final headers = requiresAuth ? _getAuthHeaders() : _defaultHeaders;
      final request = http.MultipartRequest('POST', uri);

      request.headers.addAll(headers);

      if (body != null) {
        body.forEach((key, value) {
          request.fields[key] = value.toString();
        });
      }

      final multipartFile = await http.MultipartFile.fromPath(
        fieldName,
        file.path,
      );
      request.files.add(multipartFile);

      _logRequest('UPLOAD (MULTIPART)', uri.toString(), request.headers, body);

      final streamedResponse = await client
          .send(request)
          .timeout(ApiConstants.connectionTimeout);

      final response = await http.Response.fromStream(streamedResponse);

      _logResponse(response);

      return _handleResponse(response);
    } on SocketException {
      throw NetworkException(message: 'No internet connection');
    } on http.ClientException {
      throw NetworkException(message: 'Failed to connect to server');
    }
  }

  // Handle Response - Returns raw Map
  DataMap _handleResponse(http.Response response) {
    final message = _extractErrorMessage(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body) as DataMap;
    } else if (response.statusCode == 401) {
      throw UnauthorizedException(message: message ?? 'Unauthorized');
    }else if (response.statusCode == 403) {
      throw ForbiddenException(message: message ?? 'Forbidden');
    } else if (response.statusCode == 404) {
      throw NotFoundException(message: message ?? 'Resources not found');
    }else if(response.statusCode == 422) {
      throw UnprocessableEntityException(message: message ?? 'Unprocessable Entity');
    }else if (response.statusCode >= 500) {
      throw ServerException(
        message: 'Server error: ${response.statusCode}',
      );
    } else {
      final errorMessage = _extractErrorMessage(response.body);
      throw ServerException(
        message: errorMessage ?? 'Unknown error: ${response.statusCode}',
      );
    }
  }

  // Handle Delete Response
  void _handleDeleteResponse(http.Response response) {
    final message = _extractErrorMessage(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    } else if (response.statusCode == 401) {
      throw UnauthorizedException(message: message ?? 'Unauthorized');
    } else if (response.statusCode == 403) {
      throw ForbiddenException(message: message ?? 'Forbidden');
    } else if (response.statusCode == 404) {
      throw NotFoundException(message: message ?? 'Resource not found');
    } else if(response.statusCode == 422) {
      throw UnprocessableEntityException(message: message ?? 'Unprocessable Entity');
    } else {
      throw ServerException(
        message: 'Error: ${response.statusCode}',
      );
    }
  }

  // Extract error message from response
  String? _extractErrorMessage(String responseBody) {
    try {
      final json = jsonDecode(responseBody);
      return json['message'] ?? json['error'] ?? json['detail'];
    } catch (e) {
      return null;
    }
  }

  // Logging
  void _logRequest(
      String method,
      String url,
      DataMap headers, [
        DataMap? body,
      ]) {
    if (!AppConfig.enableLogging) return;

    print("======================================");
    print('REQUEST: $method $url');
    print('Headers: $headers');
    if (body != null) {
      print('Body: ${jsonEncode(body)}');
    }
    print("======================================");
  }

  void _logResponse(http.Response response) {
    if (!AppConfig.enableLogging) return;

    print("======================================");
    print('RESPONSE: ${response.statusCode}');
    print('Body: ${response.body}');
    print("======================================");
  }
}
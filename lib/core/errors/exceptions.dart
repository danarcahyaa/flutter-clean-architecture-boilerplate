/// Thrown when the server returns a 500-range error or a malformed response.
class ServerException implements Exception {
  final String message;
  ServerException({required this.message});
}

/// Thrown when there is an issue accessing local storage (e.g., Hive, Sqflite, or SharedPreferences).
class CacheException implements Exception {
  final String message;
  CacheException({required this.message});
}

/// Thrown when the device has no internet connectivity or the request times out.
class NetworkException implements Exception {
  final String message;
  NetworkException({required this.message});
}

/// Thrown when the server returns a 401 status code (Invalid or expired token).
class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException({required this.message});

  @override
  String toString() => message;
}

/// Thrown when the server returns a 403 status code (Authenticated but lacks permission).
class ForbiddenException implements Exception {
  final String message;
  ForbiddenException({required this.message});

  @override
  String toString() => message;
}

/// Thrown when the server returns a 404 status code (Resource not found).
class NotFoundException implements Exception {
  final String message;
  NotFoundException({required this.message});

  @override
  String toString() => message;
}

/// Thrown when the server returns a 422 status code (Validation errors from the API).
class UnprocessableEntityException implements Exception {
  final String message;
  UnprocessableEntityException({required this.message});

  @override
  String toString() => message;
}
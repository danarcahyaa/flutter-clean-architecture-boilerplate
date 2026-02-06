import 'package:equatable/equatable.dart';

/// An abstract base class for all domain-layer errors.
///
/// Failures are returned by Repositories to the UseCases and UI,
/// providing a standardized way to handle errors without throwing exceptions.
abstract class Failure extends Equatable {
  /// A human-readable error message.
  final String message;

  /// The associated error code (e.g., HTTP status codes like 404, 500).
  final int statusCode;

  const Failure({required this.message, required this.statusCode});

  @override
  List<Object> get props => [message, statusCode];
}

/// Represented when the remote server returns an error.
class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.statusCode});
}

/// Represented when an error occurs during local storage operations.
class CacheFailure extends Failure {
  const CacheFailure({required super.message, required super.statusCode});
}

/// Represented when there is a connectivity issue or a timeout.
class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, required super.statusCode});
}
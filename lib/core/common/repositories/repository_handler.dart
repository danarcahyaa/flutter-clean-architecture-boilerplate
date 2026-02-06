import 'package:dartz/dartz.dart';
import '../../errors/exceptions.dart';
import '../../errors/failure.dart';
import '../../network/network_info.dart';
import '../../utils/typedef.dart';

/// A mixin utility designed to standardize error handling in the Data Layer.
///
/// This handler acts as a bridge between the **Data Source** (which throws [Exception]s)
/// and the **Domain Layer** (yang mengharapkan [Failure]s).
/// It encapsulates the boilerplate `try-catch` logic and network connectivity checks.
mixin RepositoryHandler {

  /// Executes a remote data call and maps potential exceptions to a [ResultFuture].
  ///
  /// Parameters:
  /// * [networkInfo]: Dependency to check the current internet connection.
  /// * [action]: A closure containing the asynchronous call to the Data Source.
  ///
  /// Returns:
  /// * [Right] with data of type [T] on success.
  /// * [Left] with a specific [Failure] subclass on error.
  ResultFuture<T> managedExecute<T>(
      NetworkInfo networkInfo,
      Future<T> Function() action,
      ) async {
    // Pre-execution check: Internet Connectivity
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure(
        message: "No internet connection",
        statusCode: 503,
      ));
    }

    try {
      // Execute the primary action
      final result = await action();
      return Right(result);
    }

    //  Exception Mapping (Translating Data Layer errors to Domain Failures)
    on NotFoundException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: 404,
      ));
    }
    on UnauthorizedException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: 401,
      ));
    }
    on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
        statusCode: 500,
      ));
    }

    //  Catch-all: For unexpected runtime errors
    catch (e) {
      return Left(ServerFailure(
        message: "Unexpected error: ${e.toString()}",
        statusCode: 500,
      ));
    }
  }
}
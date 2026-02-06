import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_boilerplate/core/utils/typedef.dart';
import '../../errors/failure.dart';

/// The abstract interface for all application business logic (UseCases).
///
/// [Type] is the expected success return type.
/// [Params] represents the necessary input data to execute the task.
abstract class UseCase<Type, Params> {
  /// Executes the business logic and returns an [Either] type.
  ///
  /// The [call] method allows the class instance to be invoked like a function.
  ResultFuture<Type> call(Params params);
}

/// A parameter placeholder for UseCases that require no input data.
class NoParams {}

/// A standard parameter object for paginated requests.
///
/// Bundles [currentPage] and [limit] to keep UseCase signatures clean.
class PaginationParams {
  /// The target page index to fetch.
  final int currentPage;

  /// The number of items to return per page.
  final int limit;

  PaginationParams({required this.currentPage, required this.limit});
}
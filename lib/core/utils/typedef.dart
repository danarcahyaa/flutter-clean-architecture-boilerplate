import 'package:dartz/dartz.dart';
import '../common/models/pagination_model.dart';
import '../common/models/response_model.dart';
import '../errors/failure.dart';

/// Represents a [Future] that resolves to a [ResponseModel] containing type [T].
///
/// Typically used in **Remote Data Sources** to represent raw API responses
/// before they are converted into functional [Either] types.
typedef ResponseFuture<T> = Future<ResponseModel<T>>;

/// A [Future] that resolves to an [Either] type, representing a functional result.
///
/// The **Left** side returns a [Failure], and the **Right** side returns
/// the success data of type [T]. This is the standard return type for **Repository** /// and **UseCase** layers in Clean Architecture.
typedef ResultFuture<T> = Future<Either<Failure, T>>;

/// A synchronous version of [ResultFuture].
///
/// Returns an [Either] immediately without a [Future]. Useful for local
/// storage operations or logic that doesn't require asynchronous waiting.
typedef Result<T> = Either<Failure, T>;

/// A specialized [ResultFuture] that returns no data on success.
///
/// Use this for operations like "Logout", "Delete", or "Update" where the
/// only concern is whether the operation succeeded or failed.
typedef ResultFutureVoid = ResultFuture<void>;

/// A synchronous version of [ResultFutureVoid].
typedef ResultVoid = Result<void>;

/// A shorthand for the standard JSON structure in Dart.
typedef DataMap = Map<String, dynamic>;

/// Represents a [ResponseModel] where the result payload is specifically
/// a [PaginationModel] of type [T].
typedef PaginationResponseModel<T> = ResponseModel<PaginationModel<T>>;

/// A [Future] wrapper for [PaginationResponseModel].
///
/// Used in **Remote Data Sources** when fetching paginated lists from an API.
typedef PaginationResponseFuture<T> = Future<ResponseModel<PaginationModel<T>>>;

/// A [Future] that resolves to an [Either] containing a [PaginationModel].
///
/// Used in **Repositories** and **UseCases** to provide the UI with both the
/// data list and the pagination metadata (like current page and last page).
typedef PaginationResultFuture<T> = Future<Either<Failure, PaginationModel<T>>>;
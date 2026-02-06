import 'package:flutter_clean_architecture_boilerplate/core/common/usecases/usecase.dart';
import 'package:flutter_clean_architecture_boilerplate/features/user/domain/repositories/user_repository.dart';

import '../../../../core/utils/typedef.dart';
import '../entities/user.dart';

/// [GetOneUserUseCase] is responsible for retrieving a single [User] entity
/// by its unique identifier.
///
/// This use case is typically used when navigating to a user profile detail
/// page or fetching specific user data for administrative purposes.
///
/// Returns a [ResultFuture] containing the [User] if found,
/// or a [Failure] if the user does not exist or a server error occurs.
class GetOneUserUseCase implements UseCase<User, GetOneUserParams> {
  final UserRepository _userRepository;

  /// Dependency injection via constructor to ensure the [UserRepository]
  /// implementation is provided at runtime.
  GetOneUserUseCase(this._userRepository);

  /// Triggers the retrieval process for a specific user.
  ///
  /// Takes [GetOneUserParams] containing the [id] of the user to be fetched.
  @override
  ResultFuture<User> call(GetOneUserParams params) async {
    return await _userRepository.getOne(params.id);
  }
}

/// [GetOneUserParams] encapsulates the input data required to fetch
/// a specific user.
///
/// Using a parameter class even for a single [id] maintains consistency
/// with the [UseCase] contract and allows for easy extension
/// (e.g., adding 'includePrivateData' or 'cacheStrategy' flags).
class GetOneUserParams {
  /// The unique identifier of the [User].
  final String id;

  /// Creates a [GetOneUserParams] with the mandatory user [id].
  GetOneUserParams({required this.id});
}
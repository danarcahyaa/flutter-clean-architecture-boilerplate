import 'package:flutter_clean_architecture_boilerplate/features/user/domain/repositories/user_repository.dart';
import '../../../../core/common/usecases/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/user.dart';

/// [CreateUserUseCase] is a domain layer component responsible for
/// persisting a new [User] entity into the system.
///
/// This class encapsulates the business logic for user creation and
/// delegates the data persistence to the [UserRepository].
///
/// Returns a [ResultFuture] which yields the created [User] object upon
/// success, or a [Failure] if the process encounters an error.
class CreateUserUseCase implements UseCase<User, CreateUserParams> {
  final UserRepository _userRepository;

  /// Standard constructor to inject the [UserRepository] dependency.
  CreateUserUseCase(this._userRepository);

  /// Executes the user creation process.
  ///
  /// Requires [CreateUserParams] which contains the [User] entity to be saved.
  @override
  ResultFuture<User> call(CreateUserParams params) async {
    return await _userRepository.create(params.user);
  }
}

/// [CreateUserParams] wraps the necessary arguments for [CreateUserUseCase].
///
/// Using a parameter class ensures that the [UseCase] contract remains
/// consistent even if more arguments (like media uploads or preferences)
/// are added in the future.
class CreateUserParams {
  /// The [User] entity instance to be created.
  final User user;

  /// Creates a [CreateUserParams] instance with the required [user].
  CreateUserParams({required this.user});
}
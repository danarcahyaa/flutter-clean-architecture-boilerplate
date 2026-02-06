import 'package:flutter_clean_architecture_boilerplate/core/common/usecases/usecase.dart';
import 'package:flutter_clean_architecture_boilerplate/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_boilerplate/features/user/domain/repositories/user_repository.dart';

import '../entities/user.dart';

/// [GetAllUserUseCase] is responsible for retrieving a list of all users
/// from the [UserRepository].
///
/// This use case follows the Clean Architecture pattern, acting as a
/// bridge between the presentation layer and the data layer.
///
/// Returns a [ResultFuture] containing a list of [User] entities on success,
/// or a [Failure] on error.
class GetAllUserUseCase implements UseCase<List<User>, NoParams> {
  final UserRepository _userRepository;

  /// Default constructor requiring a [UserRepository] instance.
  GetAllUserUseCase(this._userRepository);

  /// Executes the use case to fetch all users.
  ///
  /// Takes [NoParams] as this operation doesn't require any input arguments.
  @override
  ResultFuture<List<User>> call(NoParams params) async {
    return await _userRepository.getAll();
  }
}
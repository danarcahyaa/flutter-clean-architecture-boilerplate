import 'package:flutter/cupertino.dart';

import '../../../../core/common/enums/enum.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/create_user_usecase.dart';

/// [CreateUserProvider] manages the state and logic for creating a new user.
///
/// This provider serves as the interface between the UI (typically a form)
/// and the [CreateUserUseCase]. It tracks the lifecycle of the creation
/// request, from the initial trigger to success or failure.
class CreateUserProvider extends ChangeNotifier {
  final CreateUserUseCase _createUserUseCase;

  /// Constructor to inject the required [CreateUserUseCase].
  CreateUserProvider(this._createUserUseCase);

  /// Current operational status of the provider.
  ProviderStatus _status = ProviderStatus.initial;
  ProviderStatus get status => _status;

  /// Stores error details if the [status] transitions to [ProviderStatus.error].
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// The resulting [User] entity returned by the server after successful creation.
  User? _user;
  User? get user => _user;

  /// Initiates the user creation process.
  ///
  /// It accepts a [User] entity, wraps it into [CreateUserParams] internally,
  /// and executes the use case.
  ///
  /// During execution, [_status] is set to [ProviderStatus.loading].
  /// On success, it stores the created user and sets [_status] to [ProviderStatus.success].
  /// On failure, it captures the error message and sets [_status] to [ProviderStatus.error].
  Future<void> createUser(User user) async {
    _status = ProviderStatus.loading;
    notifyListeners();

    final result = await _createUserUseCase(CreateUserParams(user: user));
    result.fold(
          (failure) {
        _status = ProviderStatus.error;
        _errorMessage = failure.message;
      },
          (result) {
        _status = ProviderStatus.success;
        _user = result;
        _errorMessage = null;
      },
    );

    notifyListeners();
  }
}
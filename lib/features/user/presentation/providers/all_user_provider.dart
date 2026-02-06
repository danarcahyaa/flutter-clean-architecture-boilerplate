import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture_boilerplate/core/common/enums/enum.dart';
import 'package:flutter_clean_architecture_boilerplate/features/user/domain/usecases/get_all_user_usecase.dart';

import '../../../../core/common/usecases/usecase.dart';
import '../../domain/entities/user.dart';

/// [AllUserProvider] manages the state for retrieving all users in the UI layer.
///
/// It coordinates with [GetAllUserUseCase] to fetch data and notifies
/// listeners about state changes such as loading, success, and error.
///
/// The state management follows the [ProviderStatus] enum to provide a
/// reactive experience for the user interface.
class AllUserProvider extends ChangeNotifier {
  final GetAllUserUseCase _allUserUseCase;

  /// Initializes the provider and immediately triggers the user fetch process.
  AllUserProvider(this._allUserUseCase) {
    _getAllUser();
  }

  /// Holds the current operational status of the provider.
  ProviderStatus _status = ProviderStatus.initial;
  ProviderStatus get status => _status;

  /// Contains the error message if the [status] is [ProviderStatus.error].
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Stores the list of retrieved [User] entities upon [ProviderStatus.success].
  List<User> _users = [];
  List<User> get users => _users;

  /// Fetches all users from the domain layer.
  ///
  /// Updates [_status] to loading before execution, then handles
  /// the [result] using a fold pattern to update either [_errorMessage]
  /// or [_users] based on the outcome.
  Future<void> _getAllUser() async {
    _status = ProviderStatus.loading;
    notifyListeners();

    final result = await _allUserUseCase(NoParams());

    result.fold(
          (failure) {
        _status = ProviderStatus.error;
        _errorMessage = failure.message;
      },
          (result) {
        _status = ProviderStatus.success;
        _users = result;
        _errorMessage = null;
      },
    );

    notifyListeners();
  }
}
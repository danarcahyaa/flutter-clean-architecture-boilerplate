import 'package:flutter/cupertino.dart';
import '../../../../core/common/enums/enum.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_one_user_usecase.dart';

/// [GetOneUserProvider] manages the state for retrieving a single [User] entity.
///
/// This provider is specifically designed for "Detail View" scenarios where
/// specific information about one user is required based on their unique ID.
/// It encapsulates the loading, success, and error states using [ProviderStatus].
class GetOneUserProvider extends ChangeNotifier {
  final GetOneUserUseCase _getOneUserUseCase;

  /// Constructor to inject the [GetOneUserUseCase] dependency.
  GetOneUserProvider(this._getOneUserUseCase);

  /// The current state of the data fetching operation.
  ProviderStatus _status = ProviderStatus.initial;
  ProviderStatus get status => _status;

  /// Stores the error message when [status] is [ProviderStatus.error].
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// The retrieved [User] object, available after a successful [getOneUser] call.
  User? _user;
  User? get user => _user;

  /// Fetches a single user from the domain layer using the provided [id].
  ///
  /// This method updates the [_status] to loading, executes the use case,
  /// and then uses the fold pattern to handle the resulting [Either] type.
  /// On success, it populates [_user]; on failure, it sets [_errorMessage].
  Future<void> getOneUser(String id) async {
    _status = ProviderStatus.loading;
    notifyListeners();

    final result = await _getOneUserUseCase(GetOneUserParams(id: id));

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
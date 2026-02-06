import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture_boilerplate/core/constant/app_constant.dart';

import '../../../../core/common/enums/enum.dart';
import '../../../../core/common/usecases/usecase.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_all_user_paginated_usecase.dart';

/// [AllPaginatedUserProvider] manages the state for paginated user lists.
///
/// It handles complex UI states including initial loading, refreshing,
/// and incremental data fetching (load more) while maintaining
/// pagination metadata like [currentPage] and [hasMoreData].
class AllPaginatedUserProvider extends ChangeNotifier {
  final GetAllUserPaginatedUseCase _allUserPaginatedUseCase;

  /// Constructor requires [GetAllUserPaginatedUseCase] to perform data fetching.
  AllPaginatedUserProvider(this._allUserPaginatedUseCase);

  /// Represents the current high-level status of the provider.
  ProviderStatus _status = ProviderStatus.initial;
  ProviderStatus get status => _status;

  /// Holds the error message if a failure occurs during data fetching.
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// The accumulated list of users fetched across all pages.
  List<User> _users = [];
  List<User> get users => _users;

  /// Internal tracking for pagination state.
  int _currentPage = 1;
  bool _hasMoreData = true;
  bool _isLoadingMore = false;
  final int _limit = AppConstants.limitPaginatedData;

  /// Returns true if there are more pages available to fetch.
  bool get hasMoreData => _hasMoreData;

  /// Returns true while a [loadMore] operation is in progress.
  bool get isLoadingMore => _isLoadingMore;

  /// Current active page index.
  int get currentPage => _currentPage;

  /// Maximum items per page fetch request.
  int get limit => _limit;

  /// Fetches the initial page of users or refreshes the existing list.
  ///
  /// If [refresh] is true, resets pagination state and clears existing [_users].
  Future<void> get({bool refresh = false}) async {
    if(refresh) {
      _currentPage = 1;
      _hasMoreData = true;
      _users = [];
    }

    _status = ProviderStatus.loading;
    notifyListeners();

    final result = await _allUserPaginatedUseCase(
      PaginationParams(currentPage: _currentPage, limit: _limit),
    );

    result.fold(
            (failure) {
          _status = ProviderStatus.error;
          _errorMessage = failure.message;
        },
            (result) {
          _status = ProviderStatus.success;
          _users = result.data;
          _hasMoreData = _currentPage < result.lastPage;
        }
    );
    notifyListeners();
  }

  /// Fetches the next page of users and appends them to the current list.
  ///
  /// Prevents execution if a load is already in progress, if there's no more data,
  /// or if the initial fetch hasn't completed.
  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMoreData || _status == ProviderStatus.loading) {
      return;
    }

    _isLoadingMore = true;
    _status = ProviderStatus.loadMore;
    notifyListeners();

    _currentPage++;

    final result = await _allUserPaginatedUseCase(
      PaginationParams(currentPage: _currentPage, limit: 10),
    );

    result.fold(
          (failure) {
        _currentPage--; // Rollback page on failure
        _isLoadingMore = false;
        _status = ProviderStatus.success;
        notifyListeners();
      },
          (paginationModel) {
        _users.addAll(paginationModel.data);
        _hasMoreData = _currentPage < paginationModel.lastPage;
        _isLoadingMore = false;
        _status = ProviderStatus.success;
        notifyListeners();
      },
    );
  }

  /// Resets the provider to its initial state.
  void reset() {
    _status = ProviderStatus.initial;
    _users = [];
    _errorMessage = null;
    _currentPage = 1;
    _hasMoreData = true;
    _isLoadingMore = false;
    notifyListeners();
  }
}
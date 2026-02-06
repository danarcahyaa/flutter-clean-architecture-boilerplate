import 'package:flutter_clean_architecture_boilerplate/core/common/models/pagination_model.dart';
import 'package:flutter_clean_architecture_boilerplate/core/common/usecases/usecase.dart';
import 'package:flutter_clean_architecture_boilerplate/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_boilerplate/features/user/domain/repositories/user_repository.dart';

import '../entities/user.dart';

/// [GetAllUserPaginatedUseCase] handles the retrieval of [User] entities
/// in a paginated format.
///
/// This use case is essential for optimizing performance when dealing with
/// large datasets, allowing the UI to load data in chunks (pages) rather
/// than fetching all records at once.
///
/// Returns a [PaginationResultFuture] which contains a [PaginationModel]
/// holding the list of [User] and metadata (total pages, current page, etc.).
class GetAllUserPaginatedUseCase implements UseCase<PaginationModel<User>, PaginationParams> {
  final UserRepository _userRepository;

  /// Default constructor to inject the [UserRepository] dependency.
  GetAllUserPaginatedUseCase(this._userRepository);

  /// Executes the paginated fetch request.
  ///
  /// Requires [PaginationParams] to specify which page to retrieve
  /// and the maximum number of items per page.
  @override
  PaginationResultFuture<User> call(PaginationParams params) async  {
    return await _userRepository.getAllPaginated(params.currentPage, params.limit);
  }
}
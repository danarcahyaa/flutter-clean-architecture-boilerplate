import 'package:flutter_clean_architecture_boilerplate/features/user/domain/entities/user.dart';

import '../../../../core/utils/typedef.dart';

abstract class UserRepository {
  /// Fetches all users from the remote server.
  ResultFuture<List<User>> getAll();

  /// Fetches a single user detail by their unique [id].
  ResultFuture<User> getOne(String id);

  /// Sends a request to create a new user record.
  ResultFuture<User> create(User user);

  /// Fetches users with pagination support using [page] and [limit] parameters.
  PaginationResultFuture<User> getAllPaginated(int page, int limit);
}


import 'package:flutter_clean_architecture_boilerplate/core/common/models/pagination_model.dart';
import 'package:flutter_clean_architecture_boilerplate/core/common/models/response_model.dart';
import 'package:flutter_clean_architecture_boilerplate/core/network/base_remote_datasource.dart';
import 'package:flutter_clean_architecture_boilerplate/features/user/data/models/user_model.dart';
import '../../../../core/utils/typedef.dart';

/// [UserRemoteDatasource] contract for handling remote user-related data operations.
abstract class UserRemoteDatasource {
  /// Fetches all users from the remote server.
  ResponseFuture<List<UserModel>> getAll();

  /// Fetches a single user detail by their unique [id].
  ResponseFuture<UserModel> getOne(String id);

  /// Sends a request to create a new user record.
  ResponseFuture<UserModel> create(UserModel user);

  /// Fetches users with pagination support using [page] and [limit] parameters.
  PaginationResponseFuture<UserModel> getAllPaginated(int page, int limit);
}

/// Implementation of [UserRemoteDatasource] that interacts with the API
/// via [BaseRemoteDataSourceImpl].
///
/// This class handles HTTP requests and maps the raw JSON responses
/// into Data Models.
class UserRemoteDatasourceImpl extends BaseRemoteDataSourceImpl implements UserRemoteDatasource {
  UserRemoteDatasourceImpl({required super.client, required super.tokenService});

  /// Retrieves all users.
  ///
  /// Performs a [GET] request to the `/users` endpoint.
  /// Requires authentication.
  @override
  ResponseFuture<List<UserModel>> getAll() async {
    final response = await get(endpoint: '/users', requiresAuth: true);

    return ResponseModel.fromJson(response, (result) {
      return (result as List)
          .map((item) => UserModel.fromJson(item as DataMap))
          .toList();
    });
  }

  /// Retrieves a specific user by [id].
  ///
  /// Performs a [GET] request to the `/users/$id` endpoint.
  /// Requires authentication.
  @override
  ResponseFuture<UserModel> getOne(String id) async {
    final response = await get(endpoint: '/users/$id', requiresAuth: true);

    return ResponseModel.fromJson(response, (result) {
      return UserModel.fromJson(result as DataMap);
    });
  }

  /// Creates a new user.
  ///
  /// Performs a [POST] request to the `/users` endpoint with [user] data.
  /// Requires authentication.
  @override
  ResponseFuture<UserModel> create(UserModel user) async {
    final response = await post(
      endpoint: '/users',
      body: user.toJson(),
      requiresAuth: true,
    );

    return ResponseModel.fromJson(response, (result) {
      return UserModel.fromJson(result as DataMap);
    });
  }

  /// Retrieves a paginated list of users.
  ///
  /// [page] indicates the current page number.
  /// [limit] indicates the number of items per page.
  /// Performs a [GET] request with query parameters.
  /// Requires authentication.
  @override
  PaginationResponseFuture<UserModel> getAllPaginated(int page, int limit) async {
    final response = await get(
      endpoint: '/users',
      queryParameters: {
        'page': page.toString(),
        'limit': limit.toString(),
      },
      requiresAuth: true,
    );

    return PaginationResponseModel.fromJson(response, (result) {
      return PaginationModel.fromJson(result as DataMap, (data) {
        return UserModel.fromJson(data as DataMap);
      });
    });
  }
}
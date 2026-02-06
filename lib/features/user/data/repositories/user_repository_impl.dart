import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_boilerplate/core/network/network_info.dart';
import 'package:flutter_clean_architecture_boilerplate/features/user/data/models/user_model.dart';
import 'package:flutter_clean_architecture_boilerplate/features/user/domain/entities/user.dart';
import 'package:flutter_clean_architecture_boilerplate/features/user/domain/repositories/user_repository.dart';
import '../../../../core/common/repositories/repository_handler.dart';
import '../../../../core/utils/typedef.dart';
import '../datasource/user_remote_datasource.dart';

/// Implementation of [UserRepository] using [RepositoryHandler] mixin.
///
/// This class orchestrates the data flow between [UserRemoteDatasource]
/// and the Domain Layer, ensuring exceptions are mapped to Failures.
class UserRepositoryImpl with RepositoryHandler implements UserRepository {
  const UserRepositoryImpl({
    required UserRemoteDatasource remoteDatasource,
    required NetworkInfo networkInfo,
  })  : _remoteDatasource = remoteDatasource,
        _networkInfo = networkInfo;

  final UserRemoteDatasource _remoteDatasource;
  final NetworkInfo _networkInfo;

  @override
  ResultFuture<List<User>> getAll() async {
    return managedExecute(_networkInfo, () async {
      final response = await _remoteDatasource.getAll();
      return response.result != null ? response.result! : [];
    });
  }

  @override
  ResultFuture<User> getOne(String id) async {
    return managedExecute(_networkInfo, () async {
      final response = await _remoteDatasource.getOne(id);
      return response.result!;
    });
  }

  @override
  ResultFuture<User> create(User user) async {
    return managedExecute(_networkInfo, () async {
      final userModel = UserModel.fromEntity(user);
      final response = await _remoteDatasource.create(userModel);
      return response.result!;
    });
  }

  @override
  PaginationResultFuture<User> getAllPaginated(int page, int limit) async {
    return managedExecute(_networkInfo, () async {
      final response = await _remoteDatasource.getAllPaginated(page, limit);
      return response.result!;
    });
  }
}
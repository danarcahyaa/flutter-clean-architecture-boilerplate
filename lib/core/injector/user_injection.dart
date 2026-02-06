import 'package:get_it/get_it.dart';
import 'package:flutter_clean_architecture_boilerplate/core/network/network_info.dart';
import 'package:flutter_clean_architecture_boilerplate/features/user/data/datasource/user_remote_datasource.dart';
import 'package:flutter_clean_architecture_boilerplate/features/user/domain/repositories/user_repository.dart';
import 'package:flutter_clean_architecture_boilerplate/features/user/domain/usecases/create_user_usecase.dart';
import 'package:flutter_clean_architecture_boilerplate/features/user/domain/usecases/get_all_user_paginated_usecase.dart';
import 'package:flutter_clean_architecture_boilerplate/features/user/domain/usecases/get_all_user_usecase.dart';
import 'package:flutter_clean_architecture_boilerplate/features/user/domain/usecases/get_one_user_usecase.dart';
import 'package:flutter_clean_architecture_boilerplate/features/user/presentation/providers/all_paginated_user_provider.dart';
import 'package:flutter_clean_architecture_boilerplate/features/user/presentation/providers/all_user_provider.dart';
import 'package:flutter_clean_architecture_boilerplate/features/user/presentation/providers/create_user_provider.dart';
import 'package:flutter_clean_architecture_boilerplate/features/user/presentation/providers/get_one_user_provider.dart';
import '../../features/user/data/repositories/user_repository_impl.dart';

/// [UserInjection] is responsible for initializing and registering all
/// dependencies related to the User feature.
///
/// It follows the Dependency Injection pattern using [GetIt], ensuring
/// that DataSources, Repositories, UseCases, and Providers are correctly
/// wired according to Clean Architecture principles.
class UserInjection {
  /// Registers all dependencies for the User module into the provided [GetIt] instance.
  ///
  /// This method organizes registrations into four distinct layers:
  /// 1. **DataSources**: Remote or Local data providers.
  /// 2. **Repositories**: Implementations that coordinate between data sources.
  /// 3. **Use Cases**: Specific business logic units.
  /// 4. **Providers**: State management classes for the UI layer.
  static Future<void> init(GetIt sl) async {
    // DataSources
    //
    // Registered as LazySingleton to ensure only one instance is created
    // when first requested.
    sl.registerLazySingleton<UserRemoteDatasource>(
          () => UserRemoteDatasourceImpl(
        client: sl(),
        tokenService: sl(),
      ),
    );

    //  Repositories
    //
    // Binds the UserRepository interface to its concrete implementation.
    sl.registerLazySingleton<UserRepository>(
          () => UserRepositoryImpl(
        networkInfo: sl<NetworkInfo>(),
        remoteDatasource: sl<UserRemoteDatasource>(),
      ),
    );

    // Use Cases
    //
    // Encapsulates business logic and injects the necessary repository.
    sl.registerLazySingleton<GetAllUserUseCase>(
            () => GetAllUserUseCase(sl<UserRepository>())
    );
    sl.registerLazySingleton<GetAllUserPaginatedUseCase>(
            () => GetAllUserPaginatedUseCase(sl<UserRepository>())
    );
    sl.registerLazySingleton<GetOneUserUseCase>(
            () => GetOneUserUseCase(sl<UserRepository>())
    );
    sl.registerLazySingleton<CreateUserUseCase>(
            () => CreateUserUseCase(sl<UserRepository>())
    );

    // Providers
    //
    // Registered as Factory to ensure a fresh instance is created every time
    // it is requested by a new screen or widget.
    sl.registerFactory(
            () => AllUserProvider(sl<GetAllUserUseCase>())
    );
    sl.registerFactory(
            () => AllPaginatedUserProvider(sl<GetAllUserPaginatedUseCase>())
    );
    sl.registerFactory(
            () => GetOneUserProvider(sl<GetOneUserUseCase>())
    );
    sl.registerFactory(
            () => CreateUserProvider(sl<CreateUserUseCase>())
    );
  }
}
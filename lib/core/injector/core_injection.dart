import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/base_remote_datasource.dart';
import '../network/network_info.dart';
import '../services/token_service.dart';
import '../services/user_service.dart';
import '../themes/theme_provider.dart';

class CoreInjection {
  static Future<void> init(GetIt sl) async {
    // External Dependencies
    sl.registerLazySingleton(() => http.Client());
    sl.registerLazySingleton(() => InternetConnectionChecker.instance);

    // Services
    sl.registerLazySingleton(() => UserService(sl<SharedPreferences>()));

    // Network
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

    // Base Remote DataSource
    sl.registerLazySingleton<BaseRemoteDataSource>(
          () => BaseRemoteDataSourceImpl(
        client: sl<http.Client>(),
        tokenService: sl<TokenService>(),
      ),
    );

    // Providers
    sl.registerLazySingleton(() => ThemeProvider(sl()));
    // sl.registerFactory(() => NavigationProvider());
  }
}
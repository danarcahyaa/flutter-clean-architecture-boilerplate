import 'package:flutter_clean_architecture_boilerplate/core/injector/user_injection.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core_injection.dart';

/// Global Service Locator instance.
final sl = GetIt.instance;

/// Main initialization function for Dependency Injection.
///
/// This method sets up shared external dependencies and delegates
/// feature-specific registrations to individual injection modules.
Future<void> init() async {

  // --- External Dependencies ---
  // Registered as a LazySingleton to be reused across the app.
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // --- Feature Modules Initialization ---
  // We use static methods from dedicated injection classes to keep this
  // file clean and avoid a "God File" with hundreds of registrations.
  await CoreInjection.init(sl);
  await UserInjection.init(sl);

}

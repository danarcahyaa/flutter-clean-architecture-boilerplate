import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_boilerplate/features/user/presentation/providers/all_user_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'core/routes/app_router.dart';
import 'core/themes/app_theme.dart';
import 'core/themes/theme_provider.dart';
import 'core/injector/injection_container.dart' as di;

/// The entry point of the application.
///
/// This function initializes essential services including:
/// * [WidgetsFlutterBinding]: Ensures Flutter services are ready.
/// * [dotenv]: Loads configuration from the `.env` file.
/// * [di.init]: Sets up the Dependency Injection container (Service Locator).
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables for API keys and base URLs.
  await dotenv.load(fileName: ".env");

  // Initialize Service Locator (GetIt).
  await di.init();

  runApp(const MyApp());
}

/// The root widget of the application.
///
/// It sets up the global [MultiProvider] for state management and
/// configures the [MaterialApp] with theming and routing logic.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// Global Providers
        /// [ThemeProvider] is injected via Service Locator [sl].
        ChangeNotifierProvider(
          create: (_) => di.sl<ThemeProvider>(),
        ),

        ChangeNotifierProvider(
          create: (_) => di.sl<AllUserProvider>(),
        )
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp.router(
            title: 'My App',
            debugShowCheckedModeBanner: false,

            /// Theming Configuration
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,

            /// Navigation Configuration
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
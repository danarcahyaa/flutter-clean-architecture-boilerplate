import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_boilerplate/core/routes/route_names.dart';
import 'package:flutter_clean_architecture_boilerplate/features/home/presentation/pages/home_page.dart';
import 'package:flutter_clean_architecture_boilerplate/features/search/presentation/pages/search_page.dart';
import 'package:flutter_clean_architecture_boilerplate/features/user/presentation/pages/profile_page.dart';
import 'package:go_router/go_router.dart';

// Import Pages
import '../../features/splash/presentation/page/splash_page.dart';
import '../common/widgets/main_wrapper.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHome = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorSearch = GlobalKey<NavigatorState>(debugLabel: 'shellSearch');
final _shellNavigatorProfile = GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      /// PUBLIC ROUTES
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),

      /// PROTECTED ROUTES (WITH BOTTOM BAR)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(navigationShell: navigationShell);
        },
        branches: [
          /// Home Page Feature
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHome,
            routes: [
              GoRoute(
                path: RouteNames.home,
                builder: (context, state) => const HomePage(),
                routes: [
                  /// Handle nested routes if needed here...

                ],
              ),
            ],
          ),

          /// Search Page Feature
          StatefulShellBranch(
            navigatorKey: _shellNavigatorSearch,
            routes: [
              GoRoute(
                path: RouteNames.search,
                builder: (context, state) => const SearchPage(),
                routes: [
                  /// Handle nested routes if needed here...

                ],
              ),
            ],
          ),

          /// Profile Page Feature
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfile,
            routes: [
              GoRoute(
                path: RouteNames.profile,
                builder: (context, state) => const ProfilePage(),
                routes: [
                  /// Handle nested routes if needed here...

                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
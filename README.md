# Flutter Clean Architecture Boilerplate

A Flutter boilerplate project implementing Clean Architecture principles with Go Router for navigation and Provider for state management.

## Table of Contents

- [Architecture Overview](#architecture-overview)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Customization](#customization)
- [Creating New Features](#creating-new-features)

## Architecture Overview

This boilerplate follows Clean Architecture principles, separating the codebase into distinct layers:

- **Presentation Layer**: UI components, pages, widgets, and state management (Provider)
- **Domain Layer**: Business logic, entities, and use cases
- **Data Layer**: Data sources (local/remote), repositories, and models

**State Management**: Provider  
**Navigation**: Go Router

## Project Structure

### Core Module

The `core` folder contains shared utilities, configurations, and base classes used throughout the application.

#### 1. **core/commons**

Contains shared components organized into subdirectories:

- **enums**: Application-wide enumerations
- **models**: Base models for API responses
  - `pagination_model.dart`: Standard pagination format
  - `response_model.dart`: Base format for API responses
- **repositories**: Repository utilities
  - `repository_handler.dart`: Handles API responses to avoid redundancy
- **usecases**: Base use case implementation
  - `usecase.dart`: Base class for all use cases
- **widgets**: Reusable app UI components
  - Custom text fields, email fields, and other common widgets

#### 2. **core/config**

- `app_config.dart`: Application configuration settings
  - Toggle mock data usage
  - Enable/disable logging
  - Environment-specific configurations

#### 3. **core/constant**

Stores constant variables used throughout the app:

- Image paths
- Page indices
- String constants
- Other static values

#### 4. **core/errors**

Error handling infrastructure:

- `exception.dart`: Custom exception classes
- `failures.dart`: Failure classes for error handling

#### 5. **core/injector**

Dependency injection setup:

- Manages service locator configuration
- Registers dependencies for the entire application

#### 6. **core/network**

Network layer infrastructure:

- `base_remote_datasource.dart`: Base class for remote data sources
- `network_info.dart`: Network connectivity checker
  - Monitors internet connection status
  - Provides utilities for checking network availability before making API calls

#### 7. **core/routes**

Navigation management:

- `app_router.dart`: Go Router configuration and route management
- `route_names.dart`: Centralized route name constants

#### 8. **core/services**

Application services:

- `user_service.dart`: Manages user using SharedPreferences
- Other service classes for specific functionalities (e.g., token service for managing user token)

#### 9. **core/themes**

UI theming system:

- `app_colors.dart`: Application color palette
- `app_fonts.dart`: Typography definitions
- `app_theme.dart`: Theme configuration
- `theme_provider.dart`: Provider for theme state management

#### 10. **core/utils**

Helper utilities and functions:

- Formatting helpers
- Validation utilities
- Extension methods
- Other helper code

### Features Module

The `features` folder contains all feature modules, each implementing Clean Architecture layers.

Each feature follows this structure:

#### **data/** - Data Layer

- **data/datasources/**
  - `local/`: Local data sources (database, cache, SharedPreferences)
  - `remote/`: Remote data sources (API calls, network requests)

- **data/repositories/**: Concrete implementations of repository abstract class

- **data/models/**: Data models that map to domain entities
  - Includes JSON serialization/deserialization
  - Converts between API responses and domain entities

#### **domain/** - Domain Layer

- **domain/entities/**: Business objects (pure Dart classes)
  - Contains core business models
  - No dependencies on external frameworks

- **domain/repositories/**: Abstract repository abstract class
  - Defines contracts for data operations
  - Implemented by data layer repositories

- **domain/usecases/**: Business logic use cases
  - Single responsibility principle
  - Orchestrates data flow between layers

#### **presentation/** - Presentation Layer

- **presentation/pages/**: UI pages/screens

- **presentation/providers/**: State management with Provider
  - Manages UI state
  - Handles user interactions
  - Communicates with use cases

- **presentation/widgets/**: Feature-specific reusable widgets

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Flutter FVM
- Dart SDK
- IDE (VS Code, Android Studio, or IntelliJ IDEA)

### Installation

1. Clone the repository
```bash
git clone <repository-url>
cd flutter_clean_architecture_boilerplate
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the application
```bash
flutter run
```

## Customization

### Changing App Colors

Modify the color palette in `core/themes/app_colors.dart`:

```dart
/// Change this colors based at your needs.
static const Color primary = Color(0xFF6200EE);
static const Color primaryDark = Color(0xFF3700B3);
static const Color primaryLight = Color(0xFFBB86FC);
```

### Adding New Bottom Navigation Tabs

To add a new feature page to the bottom navigation:

1. Go to `core/common/widgets/main_wrapper.dart`
2. Add a new `NavigationDestination`:
```dart
NavigationDestination(
  icon: Icon(Icons.your_icon),
  label: 'Your Label',
)
```
3. Adjust the label and icon as needed

### App Router Configuration

The `app_router.dart` manages all navigation routes:

```dart
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
```

## Creating New Features

Follow these steps to create a new feature following Clean Architecture principles:

### Step 1: Create Entity

Create your business entity in `domain/entities/`:

```dart
// features/your_feature/domain/entities/your_entity.dart
class YourEntity {
  final String id;
  final String name;
  
  YourEntity({
    required this.id,
    required this.name,
  });
}
```

### Step 2: Create Model from Entity

Create the data model in `data/models/`:

```dart
// features/your_feature/data/models/your_model.dart
import '../../domain/entities/your_entity.dart';

class YourModel extends YourEntity {
  YourModel({
    required super.id,
    required super.name,
  });
  
  factory YourModel.fromJson(Map<String, dynamic> json) {
    return YourModel(
      id: json['id'],
      name: json['name'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
```

### Step 3: Define Data Source

Create data source interfaces and implementations:

**Remote Data Source:**
```dart
// features/your_feature/data/datasources/remote/your_remote_datasource.dart
abstract class YourRemoteDataSource {
  ResponseFuture<YourModel> getData();
}

class YourRemoteDataSourceImpl implements YourRemoteDataSource {
  @override
  ResponseFuture<YourModel> getData() async {
    // Implement API call
  }
}
```

**Local Data Source (if needed):**
```dart
// features/your_feature/data/datasources/local/your_local_datasource.dart
abstract class YourLocalDataSource {
  Future<YourModel> getCachedData();
}
```

### Step 4: Define Repository

**Abstract Repository (Domain Layer):**
```dart
// features/your_feature/domain/repositories/your_repository.dart
abstract class YourRepository {
  ResultFuture<YourEntity> getData();
}
```

**Repository Implementation (Data Layer):**
```dart
// features/your_feature/data/repositories/your_repository_impl.dart
class YourRepositoryImpl implements YourRepository {
  final YourRemoteDataSource remoteDataSource;
  
  YourRepositoryImpl({required this.remoteDataSource});
  
  @override
  ResultFuture<YourEntity> getData() async {
    // Implement repository logic
  }
}
```

### Step 5: Create Use Case

```dart
// features/your_feature/domain/usecases/get_your_data.dart
class GetYourData extends UseCase<YourEntity, NoParams> {
  final YourRepository repository;
  
  GetYourData(this.repository);
  
  @override
  ResultFuture<YourEntity> call(NoParams params) {
    return repository.getData();
  }
}
```

### Step 6: Create Provider

```dart
// features/your_feature/presentation/providers/your_provider.dart
class YourProvider extends ChangeNotifier {
  final GetYourData getYourData;
  
  YourProvider({required this.getYourData});
  
  YourEntity? _data;
  YourEntity? get data => _data;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();
    
    final result = await getYourData(NoParams());
    result.fold(
      (failure) {
        // Handle error
      },
      (data) {
        _data = data;
      },
    );
    
    _isLoading = false;
    notifyListeners();
  }
}
```

### Step 7: Create Feature Injector

```dart
// features/your_feature/your_feature_injector.dart
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initYourFeature() async {
  // Data sources
  sl.registerLazySingleton<YourRemoteDataSource>(
    () => YourRemoteDataSourceImpl(),
  );
  
  // Repository
  sl.registerLazySingleton<YourRepository>(
    () => YourRepositoryImpl(remoteDataSource: sl()),
  );
  
  // Use cases
  sl.registerLazySingleton(() => GetYourData(sl()));
  
  // Providers
  sl.registerFactory(() => YourProvider(getYourData: sl()));
}
```

### Step 8: Register Provider in main.dart

Add your provider to the MultiProvider in `main.dart`:

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => sl<YourProvider>()),
    // ... other providers
  ],
  child: MyApp(),
)
```

## Project Benefits

- ✅ **Separation of Concerns**: Clear distinction between layers
- ✅ **Testability**: Easy to unit test each layer independently
- ✅ **Scalability**: Add new features without affecting existing code
- ✅ **Maintainability**: Well-organized code structure
- ✅ **Reusability**: Shared components and utilities
- ✅ **Type Safety**: Strong typing with Dart

## License

This project is licensed under the MIT License.

## ⭐ Show Your Support
If this boilerplate helped you build better Flutter apps, please give it a star! ⭐

It helps others discover this project and motivates continued development and maintenance.

**Found a bug?** Open an issue.  
**Have a feature request?** We'd love to hear it!

**Happy Coding! 🚀**

import '../constant/api_constant.dart';

/// Centralized configuration manager for the application environment.
///
/// This class determines global behaviors such as data sourcing (mock vs. live)
/// and debugging features like console logging.
class AppConfig {
  /// Toggle this to [true] to use local mock data instead of calling live APIs.
  /// Useful for UI development when the backend is not yet ready.
  static const bool useMockData = false;

  /// Determines whether network and state logs should be printed to the console.
  /// Should be set to [false] in production for better performance and security.
  static const bool enableLogging = false;

  /// Returns the appropriate base URL based on the [useMockData] flag.
  ///
  /// It dynamically switches between [ApiConstants.mockBaseUrl] and
  /// [ApiConstants.apiBaseUrl] to streamline the development workflow.
  static String get baseUrl {
    return useMockData
        ? ApiConstant.mockBaseUrl
        : ApiConstant.apiBaseUrl;
  }
}
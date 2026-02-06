/// A centralized collection of all route path constants for the application.
///
/// Using defined constants prevents hardcoded string errors and simplifies
/// navigation logic across the UI layer.
class RouteNames {
  /// The initial route displayed when the app launches.
  static const String splash = '/';

  /// The entry point for user authentication.
  static const String login = '/login';

  // --- Protected Routes ---
  // These routes typically require an authenticated session to access.

  /// The main dashboard or landing screen after a successful login.
  static const String home = '/home';
  static const String search = '/search';
  static const String profile = '/profile';
}
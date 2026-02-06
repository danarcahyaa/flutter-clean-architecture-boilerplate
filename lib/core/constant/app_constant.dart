/// A centralized repository for all global constant values used across the application.
/// 
/// Consolidating values here ensures consistency and makes global changes 
/// (like UI indices or animation durations) easier to manage in one place.
class AppConstants {

  /// The index of the Home page within the main navigation bar or PageView.
  /// 
  /// Usually used in conjunction with a `BottomNavigationBar` to set the 
  /// initial or active tab.
  static int get homePageIndex => 0;

  static int get limitPaginatedData => 10;
}
/// Represents the various states of a data provider or state manager.
///
/// This enum is typically used in the UI layer to determine which widget
/// to display (e.g., a loading spinner, an error message, or the actual data).
enum ProviderStatus {
  /// The default state before any action has been initiated.
  initial,

  /// Indicates that an initial data fetch is currently in progress.
  loading,

  /// Indicates that additional data is being fetched (e.g., infinite scrolling).
  /// This allows the UI to maintain the current list while showing a
  /// small loader at the bottom.
  loadMore,

  /// Indicates that the operation failed.
  /// The [Failure] object should usually be checked alongside this status.
  error,

  /// Indicates that the operation completed successfully and data is ready.
  success
}
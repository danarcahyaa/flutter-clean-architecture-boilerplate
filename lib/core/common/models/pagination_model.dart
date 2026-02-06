import '../../utils/typedef.dart';

/// A generic model representing a paginated response.
///
/// This class encapsulates the pagination metadata (current and last page)
/// and the actual list of data of type [T].
///
/// ### Example Usage:
/// ```dart
/// final pagination = PaginationModel<User>.fromJson(
///   jsonMap,
///   (item) => User.fromJson(item as DataMap)
/// );
/// ```
class PaginationModel<T> {
  /// The index of the current page, defaults to 1 if not provided.
  final int currentPage;

  /// The list of items of type [T] contained in the current page.
  final List<T> data;

  /// The total number of pages available, defaults to 1 if not provided.
  final int lastPage;

  PaginationModel({
    required this.currentPage,
    required this.data,
    required this.lastPage,
  });

  /// Creates a [PaginationModel] from a JSON map.
  ///
  /// The [fromJsonT] function is used to map each item in the 'data' list
  /// from JSON into an instance of [T].
  factory PaginationModel.fromJson(
      DataMap json,
      T Function(Object? json) fromJsonT,
      ) {
    return PaginationModel<T>(
      currentPage: json['current_page'] ?? 1,
      data: (json['data'] as List).map((item) => fromJsonT(item)).toList(),
      lastPage: json['last_page'] ?? 1,
    );
  }
}
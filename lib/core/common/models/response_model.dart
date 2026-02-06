import '../../utils/typedef.dart';

/// A generic wrapper for API responses.
///
/// This model is used to standardize the response format from the API,
/// containing a [message] and a generic [result] of type [T].
///
/// ### Example Usage:
/// ```dart
/// final response = ResponseModel<BookModel>.fromJson(
///   responseAPI,
///   (result) => BookModel.fromJson(result as DataMap),
/// );
/// ```
class ResponseModel<T> {
  /// The status message or description returned by the API.
  final String message;

  /// The actual data payload of type [T]. Can be null if the response
  /// contains no data.
  final T? result;

  ResponseModel({
    required this.message,
    required this.result,
  });

  /// Creates a [ResponseModel] from a [DataMap].
  ///
  /// The [fromJsonT] function is a callback that handles the conversion
  /// of the 'result' field into an instance of [T].
  factory ResponseModel.fromJson(
      DataMap json,
      T Function(Object? json) fromJsonT,
      ) {
    return ResponseModel<T>(
      message: json['message'] as String,
      result: json['result'] != null ? fromJsonT(json['result']) : null,
    );
  }

  /// Converts the [ResponseModel] instance back into a [DataMap].
  ///
  /// If provided, [toJsonT] is used to convert the [result] of type [T]
  /// back into its JSON-compatible format.
  DataMap toJson(Object? Function(T)? toJsonT) {
    return {
      'message': message,
      'result': result != null && toJsonT != null
          ? toJsonT(result as T)
          : result,
    };
  }
}
/// Represents the core User entity in the domain layer.
///
/// This class defines the fundamental data structure for a user that is used
/// across the business logic and UI layers. It is agnostic of data sources
/// (API or Database) to ensure the domain remains pure and testable.
class User {
  /// The unique identifier for the user.
  final int id;

  /// The full name of the user.
  final String name;

  /// The primary email address of the user.
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });
}
import 'package:flutter_clean_architecture_boilerplate/core/utils/typedef.dart';
import '../../domain/entities/user.dart';

/// Data transfer object (DTO) for the [User] entity.
///
/// This class handles the mapping between the remote API response (JSON)
/// and the domain-level [User] entity. It extends [User] to ensure
/// compatibility with business logic layers.
class UserModel extends User {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  /// Creates a [UserModel] instance from a [DataMap].
  ///
  /// This factory is typically used in the **Remote Data Source** to parse
  /// raw responses from the server.
  factory UserModel.fromJson(DataMap json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  /// Converts the [User] entity into [UserModel]
  ///
  /// Useful for sending an entity to the **Remote Data Source**
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
    );
  }

  /// Converts the [UserModel] instance into a [DataMap].
  ///
  /// Useful for sending user data back to the server in the body of
  /// a POST, PUT, or PATCH request.
  DataMap toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

}
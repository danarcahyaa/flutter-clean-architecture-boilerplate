import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';

/// A utility class to display standardized snackbars across the application.
///
/// Using this helper ensures that success and error messages look the same
/// regardless of which screen triggers them, adhering to the app's design system.
class AppSnackBar {

  /// Displays a red snackbar for error messages.
  ///
  /// The [message] should be a human-readable explanation of what went wrong.
  /// Defaults to a 5-second duration to give users enough time to read the error.
  static void error(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.error,
        duration: const Duration(seconds: 5),
        behavior: SnackBarBehavior.floating, // Recommended for modern UI
      ),
    );
  }

  /// Displays a green snackbar for success messages.
  ///
  /// Typically used after successful operations like saving data,
  /// logging in, or deleting an item.
  static void success(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
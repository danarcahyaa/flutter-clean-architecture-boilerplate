import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';

/// A customized [IconButton] that enforces the application's visual style.
///
/// This widget wraps the standard Material [IconButton] to provide consistent
/// splash and highlight colors, ensuring that all icon interactions across
/// the app feel uniform.
class AppIconButton extends StatelessWidget {
  /// The callback function invoked when the button is tapped.
  final VoidCallback onPressed;

  /// The icon to be displayed inside the button.
  final IconData icon;

  /// The color of the icon. Defaults to [AppColors.textSecondary].
  final Color color;

  /// The size of the icon in logical pixels.
  final double size;

  const AppIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.color = AppColors.textSecondary,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: color,
        size: size,
      ),
      // Custom feedback colors based on the app's secondary text color.
      splashColor: AppColors.textSecondary.withOpacity(0.2),
      highlightColor: AppColors.textSecondary.withOpacity(0.1),
      onPressed: onPressed,
    );
  }
}
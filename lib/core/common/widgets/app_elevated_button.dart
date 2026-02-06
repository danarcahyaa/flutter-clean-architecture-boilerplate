import 'package:flutter/material.dart';
import '../../../core/themes/app_colors.dart';
import '../../../core/themes/app_fonts.dart';

/// A custom branded [ElevatedButton] used throughout the application.
///
/// This widget standardizes the look and feel of buttons, supporting:
/// * **Loading State**: Displays a [CircularProgressIndicator] when [isLoading] is true.
/// * **Disabling Logic**: Automatically handles the disabled state based on [enabled],
///   [isLoading], or [onPressed] being null.
/// * **Flexible Width**: Can take a specific [width] or default to [double.infinity].
class AppElevatedButton extends StatelessWidget {
  /// The label text displayed on the button.
  final String text;

  /// The callback function to be executed when the button is pressed.
  /// If null, the button will be disabled.
  final VoidCallback? onPressed;

  /// If set to true, replaces the text with a [CircularProgressIndicator].
  /// While loading, the button is automatically disabled to prevent multiple taps.
  final bool isLoading;

  /// Controls whether the button is interactive. Defaults to true.
  final bool enabled;

  /// The width of the button. If null, it fills the parent's width.
  final double? width;

  /// The height of the button. Defaults to 45.
  final double height;

  const AppElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.width,
    this.height = 45,
  });

  @override
  Widget build(BuildContext context) {
    // A button is considered disabled if:
    // 1. Manually set to disabled.
    // 2. Currently in a loading state.
    // 3. No onPressed callback is provided.
    final bool isButtonDisabled = !enabled || isLoading || onPressed == null;

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isButtonDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
          disabledForegroundColor: Colors.white.withOpacity(0.7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : Text(
          text,
          style: AppFonts.bodyMedium.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
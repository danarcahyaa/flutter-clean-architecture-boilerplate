import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_fonts.dart';

/// A highly customizable [TextFormField] wrapper designed for consistency.
///
/// Key features include:
/// * **Password Toggle**: Integrated visibility switch for sensitive fields.
/// * **Theming**: Automatically adjusts based on Light/Dark mode.
/// * **Layout**: Includes an optional top-aligned label separate from the hint.
/// * **Border Management**: Specialized border states for focus, error, and disabled.
class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final TextInputType? keyboardType;

  /// Whether to hide the text (e.g., for passwords).
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;

  /// If true and [obscureText] is true, adds an eye icon to toggle visibility.
  final bool showPasswordToggle;
  final EdgeInsets? contentPadding;

  const AppTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
    this.inputFormatters,
    this.showPasswordToggle = false,
    this.contentPadding,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: AppFonts.bodyMedium.copyWith(
              color: widget.enabled
                  ? (isDark ? Colors.white : AppColors.textPrimary)
                  : theme.disabledColor,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          cursorColor: theme.textTheme.bodyLarge?.color,
          obscureText: _obscureText,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          // Ensures password fields don't accidentally support multiple lines
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          maxLength: widget.maxLength,
          focusNode: widget.focusNode,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatters,
          style: AppFonts.bodyMedium.copyWith(
            color: widget.enabled
                ? theme.textTheme.bodyLarge?.color
                : theme.disabledColor,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            helperText: widget.helperText,
            errorText: widget.errorText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.showPasswordToggle && widget.obscureText
                ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: theme.hintColor,
              ),
              onPressed: () => setState(() => _obscureText = !_obscureText),
            )
                : widget.suffixIcon,
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            filled: true,
            fillColor: widget.enabled
                ? (isDark
                ? AppColors.surface.withOpacity(0.05)
                : AppColors.surfaceDark.withOpacity(0.05))
                : theme.disabledColor.withOpacity(0.1),
            border: _buildBorder(theme.dividerColor),
            enabledBorder: _buildBorder(theme.dividerColor.withOpacity(0.2)),
            focusedBorder: _buildBorder(
                isDark
                    ? AppColors.primary.withOpacity(0.7)
                    : AppColors.backgroundDark.withOpacity(0.7),
                width: 1.5),
            errorBorder: _buildBorder(theme.colorScheme.error),
            focusedErrorBorder: _buildBorder(theme.colorScheme.error, width: 2),
          ),
          validator: widget.validator,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          onFieldSubmitted: widget.onSubmitted,
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
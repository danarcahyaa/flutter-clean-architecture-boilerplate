import 'package:flutter/material.dart';
import '../../../core/common/widgets/app_text_field.dart';

/// A specialized input field for passwords.
///
/// This widget pre-configures [AppTextField] for security-sensitive input by:
/// * **Obscurity**: Enabling [obscureText] by default.
/// * **Visibility Toggle**: Enabling [showPasswordToggle] to allow users to peek at their input.
/// * **Validation**: Enforcing a minimum length of 6 characters as a default security measure.
/// * **Iconography**: Using a lock icon to visually signify a secure field.
class PasswordTextField extends StatelessWidget {
  final TextEditingController? controller;

  /// The label displayed above the field. Defaults to 'Password'.
  final String? labelText;

  /// Custom validator logic. If null, checks for non-empty and minimum 6 characters.
  final String? Function(String?)? validator;

  final void Function(String)? onChanged;

  const PasswordTextField({
    super.key,
    this.controller,
    this.labelText,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      labelText: labelText ?? 'Password',
      hintText: 'Enter your password',
      obscureText: true,
      showPasswordToggle: true,
      prefixIcon: const Icon(Icons.lock_outline),
      // Typically used for the last field in a form to trigger submission.
      textInputAction: TextInputAction.done,
      validator: validator ??
              (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
      onChanged: onChanged,
    );
  }
}
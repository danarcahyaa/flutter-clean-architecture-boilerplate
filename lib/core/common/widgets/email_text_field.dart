import 'package:flutter/material.dart';
import '../../../core/common/widgets/app_text_field.dart';

/// A specialized input field for email addresses.
///
/// This widget is a wrapper around [AppTextField] that pre-configures:
/// * **Keyboard Type**: Set to [TextInputType.emailAddress] for optimized input.
/// * **Prefix Icon**: Includes a standard email icon.
/// * **Validation**: Provides a default email format validator if none is supplied.
class EmailTextField extends StatelessWidget {
  final TextEditingController? controller;

  /// Whether the input is disabled. Defaults to false.
  final bool disable;

  /// Custom validator logic. If null, uses the default email regex/check.
  final String? Function(String?)? validator;

  final void Function(String)? onChanged;

  const EmailTextField({
    super.key,
    this.controller,
    this.validator,
    this.disable = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      enabled: !disable,
      controller: controller,
      labelText: 'Email',
      hintText: 'Enter your email',
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.email_outlined),
      // Combines external validation with a default fallback.
      validator: validator ??
              (value) {
            if (value == null || value.isEmpty) {
              return 'Email is required';
            }
            // Basic check, could be replaced with a more robust RegEx.
            if (!value.contains('@')) {
              return 'Enter a valid email';
            }
            return null;
          },
      onChanged: onChanged,
    );
  }
}
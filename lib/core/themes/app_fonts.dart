import 'package:flutter/material.dart';

class AppFonts {
  // Font Families
  static const String montserrat = 'Montserrat';
  static const String poppins = 'Poppins';

  // Primary font
  static const String primaryFont = montserrat;
  static const String secondaryFont = poppins;

  // Font Weights
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;


  // Display Styles (Extra Large Headings)
  static const TextStyle displayLarge = TextStyle(
    fontSize: 57,
    fontWeight: bold,
    fontFamily: poppins,
    letterSpacing: -0.25,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 45,
    fontWeight: bold,
    fontFamily: poppins,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 36,
    fontWeight: semiBold,
    fontFamily: poppins,
  );

  // Headline Styles
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: bold,
    fontFamily: poppins,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: semiBold,
    fontFamily: poppins,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: semiBold,
    fontFamily: poppins,
  );

  // Title Styles
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: semiBold,
    fontFamily: poppins,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: medium,
    fontFamily: poppins,
    letterSpacing: 0.15,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: medium,
    fontFamily: poppins,
    letterSpacing: 0.1,
  );


  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: regular,
    fontFamily: poppins,
    letterSpacing: 0.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: regular,
    fontFamily: poppins,
    letterSpacing: 0.25,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: regular,
    fontFamily: poppins,
    letterSpacing: 0.4,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: medium,
    fontFamily: poppins,
    letterSpacing: 0.1,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: medium,
    fontFamily: poppins,
    letterSpacing: 0.5,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: medium,
    fontFamily: poppins,
    letterSpacing: 0.5,
  );


  // Button Text
  static const TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: semiBold,
    fontFamily: poppins,
    letterSpacing: 1.25,
  );

  static const TextStyle buttonLarge = TextStyle(
    fontSize: 16,
    fontWeight: semiBold,
    fontFamily: poppins,
    letterSpacing: 1.25,
  );

  // Caption
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: regular,
    fontFamily: poppins,
    letterSpacing: 0.4,
  );

  // Overline
  static const TextStyle overline = TextStyle(
    fontSize: 10,
    fontWeight: medium,
    fontFamily: poppins,
    letterSpacing: 1.5,
  );

  // For navigation/tab bars
  static const TextStyle navigation = TextStyle(
    fontSize: 12,
    fontWeight: medium,
    fontFamily: poppins,
    letterSpacing: 0.5,
  );

  // For cards titles
  static const TextStyle cardTitle = TextStyle(
    fontSize: 18,
    fontWeight: semiBold,
    fontFamily: poppins,
  );

  // For cards subtitles
  static const TextStyle cardSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: regular,
    fontFamily: poppins,
    letterSpacing: 0.25,
  );

  // For input fields
  static const TextStyle input = TextStyle(
    fontSize: 16,
    fontWeight: regular,
    fontFamily: poppins,
    letterSpacing: 0.15,
  );

  static const TextStyle inputLabel = TextStyle(
    fontSize: 12,
    fontWeight: regular,
    fontFamily: poppins,
    letterSpacing: 0.4,
  );

  // For chips/tags
  static const TextStyle chip = TextStyle(
    fontSize: 12,
    fontWeight: medium,
    fontFamily: poppins,
    letterSpacing: 0.5,
  );


  /// Creates a text style with custom color
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// Creates a text style with custom font size
  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }

  /// Creates a text style with custom font weight
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }

  /// Creates a bold version of the style
  static TextStyle toBold(TextStyle style) {
    return style.copyWith(fontWeight: bold);
  }

  /// Creates an italic version of the style
  static TextStyle toItalic(TextStyle style) {
    return style.copyWith(fontStyle: FontStyle.italic);
  }
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final Color primaryColor;
  final Color primaryDark;

  AppTheme({
    this.primaryColor = const Color(0xFF3366FF),
    this.primaryDark = const Color(0xFF0033CC),
  });

  ThemeData _buildTheme(ColorScheme colorScheme) {
    return ThemeData(
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      fontFamily: GoogleFonts.mulish().fontFamily,
      textTheme: GoogleFonts.mulishTextTheme().apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
    );
  }

  ThemeData get lightTheme {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      primary: primaryColor,
      seedColor: primaryColor,
      brightness: Brightness.light,
    );
    return _buildTheme(colorScheme);
  }

  ThemeData get darkTheme {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      primary: primaryDark,
      seedColor: primaryDark,
      brightness: Brightness.dark,
    );
    return _buildTheme(colorScheme);
  }

  AppTheme copyWith({
    Color? primaryColor,
    Color? primaryDark,
  }) =>
      AppTheme(
        primaryColor: primaryColor ?? this.primaryColor,
        primaryDark: primaryDark ?? this.primaryDark,
      );
}

extension CustomColorScheme on ColorScheme {
  Color get primaryLightest => const Color(0xFFE6F0FF);
  Color get primaryLighter => const Color(0xFF99B3FF);
  Color get primaryDarker => const Color(0xFF002699);
  Color get primaryDarkest => const Color(0xFF001A66);
}

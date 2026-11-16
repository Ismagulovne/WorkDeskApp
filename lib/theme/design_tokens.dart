import 'package:flutter/material.dart';

class WorkTimeColors {
  static const Color primary = Color(0xFF1976D2);
  static const Color secondary = Color(0xFF26C6DA);
  static const Color accent = Color(0xFFFFB300);
  
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFF212121);
  static const Color onSurface = Color(0xFF212121);
}

class WorkTimeSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 48;
}

class WorkTimeRadius {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double full = 100;
}

class WorkTimeTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: WorkTimeColors.primary,
        secondary: WorkTimeColors.secondary,
        tertiary: WorkTimeColors.accent,
        surface: WorkTimeColors.surface,
        background: WorkTimeColors.background,
        error: WorkTimeColors.error,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: WorkTimeColors.primary,
        foregroundColor: Colors.white,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: WorkTimeColors.secondary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: WorkTimeSpacing.lg,
          vertical: WorkTimeSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(WorkTimeRadius.md),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(WorkTimeRadius.md),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: WorkTimeColors.primary,
        secondary: WorkTimeColors.secondary,
        tertiary: WorkTimeColors.accent,
        surface: const Color(0xFF1E1E1E),
        background: const Color(0xFF121212),
        error: WorkTimeColors.error,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
      ),
    );
  }
}

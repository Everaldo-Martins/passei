import 'package:flutter/material.dart';

class AppThemes {
  // Cores base
  static const Color lightGray = Color.fromRGBO(104, 105, 105, 1);
  static const Color darkBlue = Color.fromRGBO(17, 26, 34, 1);
  static const Color accentBlue = Color.fromRGBO(0, 155, 255, 1);
  static const Color mediumBlue = Color.fromRGBO(30, 42, 58, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color lightBackground = Color.fromRGBO(238, 238, 238, 1);
  static const Color darkText = Color.fromRGBO(44, 44, 44, 1);
  static const Color lightText = Color.fromRGBO(236, 240, 241, 1);

  static const Color approved = Color(0xFF00FF55);
  static const Color makefinal = Color(0xFFFF9500);
  static const Color failed = Color(0xFFFF0000);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: accentBlue,
        onPrimary: white,
        primaryContainer: accentBlue.withValues(alpha: 0.03),
        onPrimaryContainer: darkText,
        secondary: accentBlue,
        onSecondary: white,
        secondaryContainer: accentBlue.withValues(alpha: 0.01),
        onSecondaryContainer: darkBlue,
        surface: white,
        onSurface: darkText,
        surfaceContainerHighest: lightGray.withValues(alpha: 0.05),
        error: accentBlue,
        onError: white,
        errorContainer: accentBlue.withValues(alpha: 0.03),
        onErrorContainer: accentBlue,
        outline: lightGray,
        outlineVariant: lightGray.withValues(alpha: 0.05),
        shadow: darkText.withValues(alpha: 0.01),
        inverseSurface: darkText,
        onInverseSurface: white,
        inversePrimary: accentBlue,
        scrim: Colors.black,
      ),
      // AppBar
      appBarTheme: const AppBarTheme(
        elevation: 1,
        centerTitle: true,
        toolbarHeight: 60,
        scrolledUnderElevation: 2,
        backgroundColor: lightBackground,
        foregroundColor: accentBlue,
        surfaceTintColor: lightBackground,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: darkText,
        ),
        iconTheme: IconThemeData(color: darkText, size: 24),
      ),
      // Scaffold
      scaffoldBackgroundColor: lightBackground,
      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 2, color: accentBlue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            width: 2,
            color: accentBlue.withValues(alpha: 0.7),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 2, color: accentBlue),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 2, color: accentBlue),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 2, color: accentBlue),
        ),
        filled: true,
        fillColor: white,
        focusColor: accentBlue,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: TextStyle(color: accentBlue),
        hintStyle: TextStyle(color: lightGray),
        errorStyle: TextStyle(color: accentBlue),
      ),
      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentBlue,
          foregroundColor: white,
          minimumSize: Size(double.infinity, 55),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          color: darkText,
          letterSpacing: -0.25,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w400,
          color: darkText,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          color: darkText,
          letterSpacing: 0.5,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w400,
          color: darkText,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w400,
          color: darkText,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: darkText,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: darkText,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: darkText,
          letterSpacing: 0.1,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: darkText,
          letterSpacing: 0.1,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: darkText,
          letterSpacing: 0.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: darkText,
          letterSpacing: 0.25,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: lightGray,
          letterSpacing: 0.4,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: accentBlue,
          letterSpacing: 0.1,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: accentBlue,
          letterSpacing: 0.5,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: accentBlue,
          letterSpacing: 0.5,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accentBlue,
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: accentBlue,
          side: BorderSide(width: 2, color: accentBlue),
          minimumSize: Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      // Cards
      cardTheme: CardTheme(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: white,
        surfaceTintColor: lightBackground,
        margin: EdgeInsets.all(8),
      ),
      // Icons
      iconTheme: IconThemeData(color: accentBlue, size: 24),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: accentBlue,
          backgroundColor: Colors.transparent,
          hoverColor: accentBlue.withValues(alpha: 0.1),
          focusColor: accentBlue.withValues(alpha: 0.2),
        ),
      ),
      // SnackBar
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: accentBlue,
        contentTextStyle: TextStyle(color: white),
        actionTextColor: white,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: accentBlue,
        onPrimary: darkBlue,
        primaryContainer: accentBlue.withValues(alpha: 0.03),
        onPrimaryContainer: accentBlue,
        secondary: accentBlue,
        onSecondary: lightText,
        secondaryContainer: accentBlue.withValues(alpha: 0.02),
        onSecondaryContainer: lightText,
        surface: darkBlue,
        onSurface: lightText,
        surfaceContainerHighest: lightText.withValues(alpha: 0.05),
        error: accentBlue,
        onError: darkBlue,
        errorContainer: accentBlue.withValues(alpha: 0.02),
        onErrorContainer: lightText,
        outline: lightGray,
        outlineVariant: lightGray.withValues(alpha: 0.03),
        shadow: Colors.black.withValues(alpha: 0.04),
        inverseSurface: lightText,
        onInverseSurface: darkBlue,
        inversePrimary: accentBlue,
        scrim: Colors.black,
      ),
      // AppBar
      appBarTheme: const AppBarTheme(
        elevation: 1,
        centerTitle: true,
        scrolledUnderElevation: 2,
        backgroundColor: mediumBlue,
        foregroundColor: lightText,
        surfaceTintColor: darkBlue,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: lightText,
        ),
        iconTheme: IconThemeData(color: lightText, size: 24),
      ),
      // Scaffold
      scaffoldBackgroundColor: darkBlue,
      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 2, color: lightText),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            width: 2,
            color: accentBlue.withValues(alpha: 0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 2, color: accentBlue),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 2, color: accentBlue),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 2, color: accentBlue),
        ),
        filled: true,
        fillColor: mediumBlue,
        focusColor: accentBlue,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: TextStyle(
          color: accentBlue,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        hintStyle: TextStyle(color: lightText),
        errorStyle: TextStyle(color: lightText),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentBlue,
          foregroundColor: lightText,
          minimumSize: Size(double.infinity, 55),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          color: lightText,
          letterSpacing: -0.25,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w400,
          color: lightText,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          color: lightText,
          letterSpacing: 0.5,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w400,
          color: lightText,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w400,
          color: lightText,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: lightText,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: lightText,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: lightText,
          letterSpacing: 0.1,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: lightText,
          letterSpacing: 0.1,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: lightText,
          letterSpacing: 0.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: lightText,
          letterSpacing: 0.25,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: lightGray,
          letterSpacing: 0.4,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: accentBlue,
          letterSpacing: 0.1,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: accentBlue,
          letterSpacing: 0.5,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: accentBlue,
          letterSpacing: 0.5,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: lightText,
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: accentBlue,
          side: BorderSide(width: 2, color: accentBlue),
          minimumSize: Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      // Cards
      cardTheme: CardTheme(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: mediumBlue,
        surfaceTintColor: darkBlue,
        margin: EdgeInsets.all(8),
      ),
      // Icons
      iconTheme: IconThemeData(color: accentBlue, size: 24),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: accentBlue,
          backgroundColor: Colors.transparent,
          hoverColor: accentBlue.withValues(alpha: 0.1),
          focusColor: accentBlue.withValues(alpha: 0.2),
        ),
      ),
      // SnackBar
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: mediumBlue,
        contentTextStyle: TextStyle(color: lightText),
        actionTextColor: accentBlue,
      ),
    );
  }
}

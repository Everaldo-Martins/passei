import 'package:flutter/material.dart';

class AppThemes {
  // Cores base
  static const Color lightGray = Color.fromRGBO(128, 123, 130, 1);
  static const Color darkBurgundy = Color.fromRGBO(98, 22, 47, 1);
  static const Color vibrantMagenta = Color.fromRGBO(202, 103, 142, 1);
  static const Color darkGray = Color.fromRGBO(43, 40, 44, 1);
  static const Color darkPurple = Color.fromRGBO(150, 48, 90, 1);
  static const Color mediumGray = Color.fromRGBO(66, 62, 68, 1);
  static const Color whitePink = Color.fromRGBO(255, 220, 252, 1);
  static const Color oldWhite = Color.fromRGBO(245, 245, 245, 1);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: darkPurple,
        onPrimary: oldWhite,
        primaryContainer: vibrantMagenta.withValues(alpha: 0.03),
        onPrimaryContainer: darkGray,
        secondary: vibrantMagenta,
        onSecondary: oldWhite,
        secondaryContainer: vibrantMagenta.withValues(alpha: 0.01),
        onSecondaryContainer: darkBurgundy,
        surface: oldWhite,
        onSurface: darkGray,
        surfaceContainerHighest: mediumGray.withValues(alpha: 0.05),
        error: darkBurgundy,
        onError: oldWhite,
        errorContainer: darkBurgundy.withValues(alpha: 0.03),
        onErrorContainer: darkBurgundy,
        outline: lightGray,
        outlineVariant: lightGray.withValues(alpha: 0.05),
        shadow: darkGray.withValues(alpha: 0.01),
        inverseSurface: darkGray,
        onInverseSurface: oldWhite,
        inversePrimary: vibrantMagenta,
        scrim: Colors.black,
      ),
      // AppBar
      appBarTheme: const AppBarTheme(
        elevation: 1,
        centerTitle: true,
        toolbarHeight: 60,
        scrolledUnderElevation: 2,
        backgroundColor: darkPurple,
        foregroundColor: oldWhite,
        surfaceTintColor: whitePink,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: oldWhite,
        ),
        iconTheme: IconThemeData(color: oldWhite, size: 24),
      ),
      // Scaffold
      scaffoldBackgroundColor: whitePink,
      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 2, color: darkPurple),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            width: 2,
            color: darkPurple.withValues(alpha: 0.7),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 2, color: darkPurple),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 2, color: darkBurgundy),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 2, color: darkBurgundy),
        ),
        filled: true,
        fillColor: oldWhite,
        focusColor: darkPurple,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: TextStyle(color: darkPurple),
        hintStyle: TextStyle(color: lightGray),
        errorStyle: TextStyle(color: darkBurgundy),
      ),
      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkPurple,
          foregroundColor: oldWhite,
          minimumSize: Size(double.infinity, 55),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: darkPurple,
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: darkPurple,
          side: BorderSide(width: 2, color: darkPurple),
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
        color: oldWhite,
        surfaceTintColor: whitePink,
        margin: EdgeInsets.all(8),
      ),
      // Icons
      iconTheme: IconThemeData(color: darkPurple, size: 24),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: darkPurple,
          backgroundColor: Colors.transparent,
          hoverColor: darkPurple.withValues(alpha: 0.1),
          focusColor: darkPurple.withValues(alpha: 0.2),
        ),
      ),
      // SnackBar
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: darkPurple,
        contentTextStyle: TextStyle(color: oldWhite),
        actionTextColor: vibrantMagenta,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: vibrantMagenta,
        onPrimary: darkGray,
        primaryContainer: darkPurple.withValues(alpha: 0.03),
        onPrimaryContainer: vibrantMagenta,
        secondary: darkPurple,
        onSecondary: oldWhite,
        secondaryContainer: darkPurple.withValues(alpha: 0.02),
        onSecondaryContainer: oldWhite,
        surface: darkGray,
        onSurface: oldWhite,
        surfaceContainerHighest: oldWhite.withValues(alpha: 0.05),
        error: vibrantMagenta,
        onError: darkGray,
        errorContainer: vibrantMagenta.withValues(alpha: 0.02),
        onErrorContainer: oldWhite,
        outline: lightGray,
        outlineVariant: lightGray.withValues(alpha: 0.03),
        shadow: Colors.black.withValues(alpha: 0.04),
        inverseSurface: oldWhite,
        onInverseSurface: darkGray,
        inversePrimary: darkPurple,
        scrim: Colors.black,
      ),
      // AppBar
      appBarTheme: const AppBarTheme(
        elevation: 1,
        centerTitle: true,
        scrolledUnderElevation: 2,
        backgroundColor: darkPurple,
        foregroundColor: oldWhite,
        surfaceTintColor: darkGray,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: oldWhite,
        ),
        iconTheme: IconThemeData(color: oldWhite, size: 24),
      ),
      // Scaffold
      scaffoldBackgroundColor: darkGray,
      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 2, color: oldWhite),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            width: 2,
            color: vibrantMagenta.withValues(alpha: 0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 2, color: vibrantMagenta),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 2, color: vibrantMagenta),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(width: 2, color: vibrantMagenta),
        ),
        filled: true,
        fillColor: mediumGray,
        focusColor: darkPurple,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: TextStyle(
          color: vibrantMagenta,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        hintStyle: TextStyle(color: oldWhite),
        errorStyle: TextStyle(color: oldWhite),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkBurgundy,
          foregroundColor: oldWhite,
          minimumSize: Size(double.infinity, 55),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: oldWhite,
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: vibrantMagenta,
          side: BorderSide(width: 2, color: vibrantMagenta),
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
        color: mediumGray,
        surfaceTintColor: darkGray,
        margin: EdgeInsets.all(8),
      ),
      // Icons
      iconTheme: IconThemeData(color: vibrantMagenta, size: 24),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: vibrantMagenta,
          backgroundColor: Colors.transparent,
          hoverColor: vibrantMagenta.withValues(alpha: 0.1),
          focusColor: vibrantMagenta.withValues(alpha: 0.2),
        ),
      ),
      // SnackBar
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: darkPurple,
        contentTextStyle: TextStyle(color: oldWhite),
        actionTextColor: vibrantMagenta,
      ),
    );
  }
}

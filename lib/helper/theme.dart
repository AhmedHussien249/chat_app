// app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static const Color _seedColor = Color(0xFF2b475e);

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(seedColor: _seedColor);
    return ThemeData(
      // fontFamily: 'Pacifico',
      colorScheme: colorScheme,
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
      ),
    );
  }
}

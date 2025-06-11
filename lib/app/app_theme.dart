import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightThemeData {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: AppColors.themColor,
      ),
      textTheme: _textTheme,
      inputDecorationTheme: _inputDecorationTheme,
      elevatedButtonTheme: _elevatedButtonThemeData,
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
        titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        bodySmall: TextStyle(fontSize: 13, color: Colors.grey),
        bodyMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,),
        labelSmall: TextStyle(fontSize: 11, color: Colors.black),

    );
  }

  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      border: OutlineInputBorder(borderSide: _getBorder(AppColors.themColor)),
      enabledBorder: OutlineInputBorder(
        borderSide: _getBorder(AppColors.themColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: _getBorder(AppColors.themColor),
      ),
      errorBorder: OutlineInputBorder(borderSide: _getBorder(Colors.red)),


      contentPadding: EdgeInsets.all(10),
      hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
    );
  }

  static BorderSide _getBorder(Color color) {
    return BorderSide(color: color, width: 2);
  }

  static ElevatedButtonThemeData get _elevatedButtonThemeData {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        fixedSize: Size.fromWidth(double.maxFinite),
        backgroundColor: AppColors.themColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.all(12),
        textStyle: TextStyle(
            fontSize: 18, letterSpacing: 1, fontWeight: FontWeight.w600),
      ),
    );
  }
}

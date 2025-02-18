import 'package:flutter/material.dart';
import 'colors/app_colors.dart';
import 'colors/app_colors_constant.dart';
import 'spacing/spacing.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
      fontFamily: 'Poppins',
      primaryColor: AppColorsConstant.primary,
      scaffoldBackgroundColor: AppColorsConstant.scaffoldBackground,
      dividerColor: AppColorsConstant.borderColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColorsConstant.scaffoldBackground,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: AppColorsConstant.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: AppColorsConstant.textPrimary),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
            fontSize: 20,
            color: AppColorsConstant.textPrimary,
            fontWeight: FontWeight.w600),
        titleMedium: TextStyle(
            fontSize: 14,
            color: AppColorsConstant.textPrimary,
            fontWeight: FontWeight.w500),
      ),
      extensions: [
        const AppColors(),
        const AppSpacing(),
      ],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: CircleBorder(),
          backgroundColor: AppColorsConstant.primary,
          hoverColor: AppColorsConstant.borderColor,
          foregroundColor: AppColorsConstant.borderColor,
          elevation: 6,
          iconSize: 42));
}

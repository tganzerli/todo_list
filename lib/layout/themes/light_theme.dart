import 'package:flutter/material.dart';
import 'colors/app_colors.dart';
import 'colors/app_colors_constant.dart';
import 'spacing/spacing.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    primaryColor: AppColorsConstant.primary,
    scaffoldBackgroundColor: AppColorsConstant.scaffoldBackground,
    dividerColor: AppColorsConstant.borderColor,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppColorsConstant.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: AppColorsConstant.textPrimary),
    ),
    extensions: [
      const AppColors(),
      const AppSpacing(),
    ],
  );
}

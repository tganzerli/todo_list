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
      foregroundColor: AppColorsConstant.scaffoldBackground,
      scrolledUnderElevation: 0,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppColorsConstant.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: AppColorsConstant.textPrimary),
    ),
    textTheme: TextTheme(
      displayMedium: TextStyle(
          fontSize: 24,
          color: AppColorsConstant.primary,
          fontWeight: FontWeight.w400),
      titleLarge: TextStyle(
          fontSize: 20,
          color: AppColorsConstant.textPrimary,
          fontWeight: FontWeight.w600),
      titleMedium: TextStyle(
          fontSize: 14,
          color: AppColorsConstant.textPrimary,
          fontWeight: FontWeight.w500),
      titleSmall: TextStyle(
          fontSize: 11,
          color: AppColorsConstant.textSecondary,
          fontWeight: FontWeight.w400),
      labelLarge: TextStyle(
          fontSize: 15,
          color: AppColorsConstant.textPrimary,
          fontWeight: FontWeight.w600),
      labelMedium: TextStyle(
          fontSize: 11,
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
        iconSize: 42),
    cardTheme: CardTheme(
      color: AppColorsConstant.cardBackground,
      shadowColor: AppColorsConstant.borderColor.withValues(alpha: 0.5),
      elevation: 0.1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing().spacingSM),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColorsConstant.secondary,
      selectedColor: AppColorsConstant.primary,
      disabledColor: AppColorsConstant.secondary,
      surfaceTintColor: AppColorsConstant.cardBackground,
      shadowColor: AppColorsConstant.cardBackground,
      showCheckmark: false,
      iconTheme: IconThemeData(color: AppColorsConstant.cardBackground),
      padding: EdgeInsets.all(AppSpacing().spacingXS),
      labelStyle: TextStyle(
          fontSize: 11,
          color: AppColorsConstant.cardBackground,
          fontWeight: FontWeight.w500),
      secondaryLabelStyle: TextStyle(
          fontSize: 11,
          color: AppColorsConstant.primary,
          fontWeight: FontWeight.w500),
    ),
  );
}

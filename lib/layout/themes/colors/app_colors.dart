import 'package:flutter/material.dart';

import 'app_colors_constant.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color primary;
  final Color secondary;
  final Color scaffoldBackground;
  final Color cardBackground;
  final Color textPrimary;
  final Color textSecondary;
  final Color borderColor;
  final Color iconColor;
  final Color bluePrimary;
  final Color blueSecondary;
  final Color orangePrimary;
  final Color orangeSecondary;

  const AppColors({
    this.primary = AppColorsConstant.primary,
    this.secondary = AppColorsConstant.secondary,
    this.scaffoldBackground = AppColorsConstant.scaffoldBackground,
    this.cardBackground = AppColorsConstant.cardBackground,
    this.textPrimary = AppColorsConstant.textPrimary,
    this.textSecondary = AppColorsConstant.textSecondary,
    this.borderColor = AppColorsConstant.borderColor,
    this.iconColor = AppColorsConstant.iconColor,
    this.bluePrimary = AppColorsConstant.bluePrimary,
    this.blueSecondary = AppColorsConstant.blueSecondary,
    this.orangePrimary = AppColorsConstant.orangePrimary,
    this.orangeSecondary = AppColorsConstant.orangeSecondary,
  });

  static AppColors of(BuildContext context) {
    return Theme.of(context).extension<AppColors>()!;
  }

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primary,
    Color? secondary,
    Color? scaffoldBackground,
    Color? cardBackground,
    Color? textPrimary,
    Color? textSecondary,
    Color? borderColor,
    Color? iconColor,
    Color? bluePrimary,
    Color? blueSecondary,
    Color? orangePrimary,
    Color? orangeSecondary,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      scaffoldBackground: scaffoldBackground ?? this.scaffoldBackground,
      cardBackground: cardBackground ?? this.cardBackground,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      borderColor: borderColor ?? this.borderColor,
      iconColor: iconColor ?? this.iconColor,
      bluePrimary: bluePrimary ?? this.bluePrimary,
      blueSecondary: blueSecondary ?? this.blueSecondary,
      orangePrimary: orangePrimary ?? this.orangePrimary,
      orangeSecondary: orangeSecondary ?? this.orangeSecondary,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
      covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      scaffoldBackground:
          Color.lerp(scaffoldBackground, other.scaffoldBackground, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      bluePrimary: Color.lerp(bluePrimary, other.bluePrimary, t)!,
      blueSecondary: Color.lerp(blueSecondary, other.blueSecondary, t)!,
      orangePrimary: Color.lerp(orangePrimary, other.orangePrimary, t)!,
      orangeSecondary: Color.lerp(orangeSecondary, other.orangeSecondary, t)!,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo_list/layout/themes/colors/app_colors_constant.dart';

enum SmallButtomType {
  primary(AppColorsConstant.primary, AppColorsConstant.cardBackground),
  secondary(AppColorsConstant.secondary, AppColorsConstant.primary),
  blue(AppColorsConstant.blueSecondary, AppColorsConstant.bluePrimary),
  orange(AppColorsConstant.orangeSecondary, AppColorsConstant.orangePrimary),
  ;

  final Color backgroundColor;

  final Color textColor;

  const SmallButtomType(this.backgroundColor, this.textColor);

  Color background() => backgroundColor;
  Color text() => textColor;
}

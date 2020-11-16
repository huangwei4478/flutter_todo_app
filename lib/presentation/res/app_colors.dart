import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: avoid_classes_with_only_static_members
class AppColors {
  static Color errorColor = HexColor('#F27777');
  static Color errorColorDark = errorColor;

  static Color primaryColor = HexColor('#17E9E1');
  static Color primaryColorDark = primaryColor;

  static Color accentColor = HexColor('#17E9E1');
  static Color accentColorDark = accentColor;

  static Color textColor = HexColor('#17224D');
  static Color textColorDark = textColor;

  static Color textSubColor = HexColor('#17224D');
  static Color textSubColorDark = textSubColor;

  static Color scaffoldBackgroundColor = HexColor('#f5fafa');
  static Color scaffoldBackgroundColorDark = scaffoldBackgroundColor;

  static Color toggleableActiveColor = HexColor('#17224D');
  static Color toggleableActiveColorDark = toggleableActiveColor;

  static Color disabledColor = toggleableActiveColor;
  static Color disabledColorDark = disabledColor;
}

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: avoid_classes_with_only_static_members
class AppColors {
  static Color errorColor = HexColor('0xF27777');
  static Color errorColorDark = errorColor;

  static Color primaryColor = HexColor('0x535C5F');
  static Color primaryColorDark = primaryColor;

  static Color accentColor = HexColor('0xF27777');
  static Color accentColorDark = accentColor;

  static Color textColor = HexColor('0x535C5F');
  static Color textColorDark = textColor;

  static Color textSubColor = HexColor('0xDDDADB');
  static Color textSubColorDark = textSubColor;

  static Color scaffoldBackgroundColor = HexColor('0xDDDAD8');
  static Color scaffoldBackgroundColorDark = scaffoldBackgroundColor;

  static Color toggleableActiveColor = HexColor('0x73939C');
  static Color toggleableActiveColorDark = toggleableActiveColor;

  static Color disabledColor = toggleableActiveColor;
  static Color disabledColorDark = disabledColor;
}

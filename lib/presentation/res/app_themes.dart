import 'package:flutter/material.dart';
import 'package:flutter_todo_app/presentation/res/app_colors.dart';
import 'package:flutter_todo_app/presentation/res/dimens.dart';

class AppTheme {
  static ThemeData getTheme({bool isDarkMode = false}) {
    return ThemeData(
      primaryColor:
          isDarkMode ? AppColors.primaryColorDark : AppColors.primaryColor,
      accentColor:
          isDarkMode ? AppColors.accentColorDark : AppColors.accentColor,
      scaffoldBackgroundColor: isDarkMode
          ? AppColors.scaffoldBackgroundColorDark
          : AppColors.scaffoldBackgroundColor,
      errorColor: isDarkMode ? AppColors.errorColorDark : AppColors.errorColor,
      toggleableActiveColor: isDarkMode
          ? AppColors.toggleableActiveColorDark
          : AppColors.toggleableActiveColor,
      disabledColor: AppColors.disabledColorDark,
      appBarTheme: AppBarTheme(
        elevation: 0.5,
        color: isDarkMode
            ? AppColors.scaffoldBackgroundColorDark
            : AppColors.scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color:
              isDarkMode ? AppColors.primaryColorDark : AppColors.primaryColor,
        ),
        textTheme: TextTheme(
          // app title
          headline6: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Dimens.fontSize20,
            fontFamily: 'Medium',
            color: isDarkMode ? AppColors.textColorDark : AppColors.textColor,
          ),
        ),
      ),
      textTheme: TextTheme(
        headline5: TextStyle(
          color: isDarkMode ? AppColors.textColorDark : AppColors.textColor,
        ),
        headline6: TextStyle(
          color: isDarkMode ? AppColors.textColorDark : AppColors.textColor,
        ),
        bodyText1: TextStyle(
          color: isDarkMode ? AppColors.textColorDark : AppColors.textColor,
        ),
        bodyText2: TextStyle(
          color: isDarkMode ? AppColors.textColorDark : AppColors.textColor,
        ),
        subtitle1: TextStyle(
          color: isDarkMode ? AppColors.textColorDark : AppColors.textColor,
        ),
        subtitle2: TextStyle(
          color:
              isDarkMode ? AppColors.textSubColorDark : AppColors.textSubColor,
        ),
      ),
    );
  }
}

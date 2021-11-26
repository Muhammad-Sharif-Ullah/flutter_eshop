import 'package:flutter/material.dart';
import 'package:flutter_eshop/theme/app_colors.dart';
import 'package:flutter_eshop/theme/app_text_style.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.light(),
    scaffoldBackgroundColor: AppColors.backgroundLight,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: AppColors.primary,
      ),
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: AppColors.backgroundLight,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      
      headline1: AppTextStyle.headline1,
      headline2: AppTextStyle.headline2,
      headline3: AppTextStyle.headline3,
      caption: AppTextStyle.caption,
      bodyText1: AppTextStyle.bodyText1,
      bodyText2: AppTextStyle.bodyText2,
      subtitle1: AppTextStyle.subtitle1,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      elevation: 10,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(primary: AppColors.primary),
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.dark(),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: AppColors.backgroundDark,
      elevation: 0,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: AppColors.primary,
      ),
    ),
    textTheme: const TextTheme(
      headline1: AppTextStyle.headline1,
      headline2: AppTextStyle.headline2,
      headline3: AppTextStyle.headline3,
      caption: AppTextStyle.caption,
      bodyText1: AppTextStyle.bodyText1,
      bodyText2: AppTextStyle.bodyText2,
      subtitle1: AppTextStyle.subtitle1,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.backgroundDark),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.blackDark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(primary: AppColors.primary)),
  );
}

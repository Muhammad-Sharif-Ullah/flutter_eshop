import 'package:flutter/material.dart';
import 'package:flutter_eshop/theme/app_colors.dart';

class AppTheme{
  static final lightTheme = ThemeData.light().copyWith(
    primaryColor: AppColors.primary,
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
      headline1: TextStyle(
          color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
      headline2: TextStyle(
          color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
      headline3: TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
      caption: TextStyle(
        color: Colors.black,
        fontSize: 14,
        letterSpacing: -.15,
        fontWeight: FontWeight.w600,
      ),
      bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 11,
      ),
      bodyText2: TextStyle(
          color: Colors.black,
          fontSize: 14,
          letterSpacing: 2,
          wordSpacing: 2,
          fontWeight: FontWeight.w400),
      subtitle1: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
      subtitle2: TextStyle(color: Colors.black, fontSize: 16),
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
        style: ElevatedButton.styleFrom(primary: AppColors.primary)),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    primaryColor: AppColors.primary,
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
      headline1: TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
      headline2: TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
      headline3: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
      caption: TextStyle(
          color: Colors.white,
          fontSize: 14,
          letterSpacing: -.15,
          fontWeight: FontWeight.w600),
      bodyText1: TextStyle(
        color: Colors.white,
        fontSize: 11,
      ),
      bodyText2: TextStyle(
          color: Colors.white,
          fontSize: 14,
          letterSpacing: 2,
          wordSpacing: 2,
          fontWeight: FontWeight.w400),
      subtitle1: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
      subtitle2: TextStyle(color: Colors.white, fontSize: 16),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.backgroundDark),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor:  AppColors.blackDark,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(primary: AppColors.primary)),
  );
}



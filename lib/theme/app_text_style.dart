import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_eshop/theme/fonts_names.dart';

class AppTextStyle {
  //HeadLine 1
  static const TextStyle headline1 = TextStyle(
    fontSize: 30,
    // fontWeight: FontWeight.bold,
    fontFamily: FontsName.bold,
  );
  //HeadLine 2
  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
  //HeadLine 3
  static const TextStyle headline3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  // caption
  static const TextStyle caption = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  // bodyText1
  static const TextStyle bodyText1 = TextStyle(
    fontSize: 11,
  );
  // bodyText2
  static const TextStyle bodyText2 = TextStyle(
    fontSize: 14,
    letterSpacing: 2,
    wordSpacing: 2,
    fontWeight: FontWeight.w400,
  );
  // subtitle1
  static const TextStyle subtitle1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  // subtitle2
  static const TextStyle subtitle2 = TextStyle(
    fontSize: 16,
  );

  AppTextStyle._();
}

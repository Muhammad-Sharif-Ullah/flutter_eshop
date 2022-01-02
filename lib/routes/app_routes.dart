part of 'app_pages.dart';

abstract class AppRoutes {
  AppRoutes._();
  static const home = _Paths.home;
  static const login = _Paths.logIn;
  static const signup = _Paths.signup;
  static const forgotPassword = _Paths.forgotPassword;
  static const settings = _Paths.settings;
  static const productDetails = _Paths.productDetails;
  static const test = _Paths.test;
}

abstract class _Paths {
  static const String home = "/";
  static const String logIn = "login";
  static const String signup = "signup";
  static const String forgotPassword = "forgotPassword";
  static const String settings = "/settings";
  static const String productDetails = "/product_details";
  static const String test = "/test";
}

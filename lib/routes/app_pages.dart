import 'package:flutter_eshop/pages/forgot_pass_view.dart';
import 'package:flutter_eshop/pages/home.dart';
import 'package:flutter_eshop/pages/login.dart';
import 'package:flutter_eshop/pages/signup_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const String initalRoutes = AppRoutes.home;
  static final routes = {
    AppRoutes.home: (context) => const Home(),
    AppRoutes.login: (context) => const LoginView(),
    AppRoutes.signup: (context) => const SignUpView(),
    AppRoutes.forgotPassword: (context) => const ForgotPassView(),
  };
}

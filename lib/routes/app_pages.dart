import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_eshop/pages/forgot_pass_view.dart';
import 'package:flutter_eshop/pages/home_page.dart';
import 'package:flutter_eshop/pages/login_page.dart';
import 'package:flutter_eshop/pages/nav_views/settings_view.dart';
import 'package:flutter_eshop/pages/signup_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static final String initalRoutes = FirebaseAuth.instance.currentUser == null
      ? AppRoutes.login
      : AppRoutes.home;
  static final routes = {
    AppRoutes.home: (context) => const HomePage(),
    AppRoutes.login: (context) => const LoginPage(),
    AppRoutes.signup: (context) => const SignUpPage(),
    AppRoutes.forgotPassword: (context) => const ForgotPassPage(),
    AppRoutes.settings: (context) => const SettingsView(),
  };
}

import 'package:flutter_eshop/pages/forgot_pass_view.dart';
import 'package:flutter_eshop/pages/home_page.dart';
import 'package:flutter_eshop/pages/login_page.dart';
import 'package:flutter_eshop/pages/nav_views/settings_view.dart';
import 'package:flutter_eshop/pages/signup_page.dart';
import 'package:flutter_eshop/provider/auth_provider.dart';
import 'package:provider/provider.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const String initalRoutes = AppRoutes.login;
  static final routes = {
    AppRoutes.home: (context) => const HomePage(),
    AppRoutes.login: (context) => ChangeNotifierProvider<AuthoProvider>(
          create: (context) => AuthoProvider(),
          child: const LoginPage(),
        ),
    AppRoutes.signup: (context) => ChangeNotifierProvider<AuthoProvider>(
          create: (context) => AuthoProvider(),
          child: const SignUpPage(),
        ),
    AppRoutes.forgotPassword: (context) => ChangeNotifierProvider<AuthoProvider>(
          create: (context) => AuthoProvider(),
          child: const LoginPage(),
        ),
    AppRoutes.settings: (context) => const SettingsView(),
  };
}

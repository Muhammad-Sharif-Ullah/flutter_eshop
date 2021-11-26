import 'package:flutter_eshop/pages/home.dart';
import 'package:flutter_eshop/pages/login.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const String initalRoutes = AppRoutes.login;
  static final routes = {
    AppRoutes.home: (context) => const Home(),
    AppRoutes.login: (context) => const LoginView(),
  };
}

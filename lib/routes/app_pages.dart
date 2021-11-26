import 'package:flutter_eshop/pages/home.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const String initalRoutes = AppRoutes.home;
  static final routes = {
    AppRoutes.home: (context) => const Home(),
  };
}

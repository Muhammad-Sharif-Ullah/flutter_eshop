import 'package:flutter/material.dart';
import 'package:flutter_eshop/routes/app_pages.dart';
import 'package:flutter_eshop/theme/app_theme.dart';

void main() {
  runApp(const FlutterEshop());
}

class FlutterEshop extends StatelessWidget {
  const FlutterEshop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppPages.initalRoutes,
      debugShowCheckedModeBanner: false,
      routes: AppPages.routes,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}

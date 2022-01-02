import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eshop/provider/account_provider.dart';
import 'package:flutter_eshop/provider/auth_provider.dart';
import 'package:flutter_eshop/provider/bottom_navigation_provider.dart';
import 'package:flutter_eshop/provider/product_details_provider.dart';
import 'package:flutter_eshop/routes/app_pages.dart';
import 'package:flutter_eshop/theme/app_theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FlutterEshop());
}

class FlutterEshop extends StatelessWidget {
  const FlutterEshop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider()),
        ChangeNotifierProvider<AccountProvider>(
            create: (context) => AccountProvider()),
        ChangeNotifierProvider<BottomNavigationProvider>(
            create: (context) => BottomNavigationProvider()),
        ChangeNotifierProvider<ProductDetailsProvider>(
            create: (context) => ProductDetailsProvider()),
      ],
      child: MaterialApp(
        initialRoute: AppPages.initalRoutes,
        debugShowCheckedModeBanner: false,
        routes: AppPages.routes,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
      ),
    );
  }
}

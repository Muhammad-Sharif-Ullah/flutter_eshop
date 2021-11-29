import 'package:flutter/material.dart';
import 'package:flutter_eshop/provider/auth_provider.dart';
import 'package:flutter_eshop/routes/app_pages.dart';
import 'package:flutter_eshop/theme/app_theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FlutterEshop());
}

class FlutterEshop extends StatelessWidget {
  const FlutterEshop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (context)=> AuthProvider()),
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

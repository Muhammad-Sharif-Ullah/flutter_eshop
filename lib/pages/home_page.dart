import 'package:flutter/material.dart';
import 'package:flutter_eshop/provider/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /**
     * Here Wrap with BottomNavigationProvider
     * In each view change from BottomNavigationProvider
     */
    return ChangeNotifierProvider<BottomNavigationProvider>(
      create: (BuildContext context) => BottomNavigationProvider(),
      child: Consumer<BottomNavigationProvider>(
          builder: (context, bnProvider, child) {
        return bnProvider.currentView;
      }),
    );
  }
}

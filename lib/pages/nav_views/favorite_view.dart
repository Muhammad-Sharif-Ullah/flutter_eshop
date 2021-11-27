import 'package:flutter/material.dart';
import 'package:flutter_eshop/widget/bottom_nav_widget.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBody: true,
      bottomNavigationBar: CustomBottomNavigator(),
    
      body: SafeArea(child: Center(child: Text("Favorite View"))),
    );
  }
}

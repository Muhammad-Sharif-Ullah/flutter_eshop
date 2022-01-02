import 'package:flutter/cupertino.dart';
import 'package:flutter_eshop/pages/nav_views/category_view.dart';
import 'package:flutter_eshop/pages/nav_views/favorite_view.dart';
import 'package:flutter_eshop/pages/nav_views/home_view.dart';
import 'package:flutter_eshop/pages/nav_views/profile_view.dart';
import 'package:flutter_eshop/pages/nav_views/beg_view.dart';

class BottomNavigationProvider with ChangeNotifier {
  int _currentIndex = 0;

  Widget get currentView => _widgetView[_currentIndex];

  final List<Widget> _widgetView = const [
    HomeView(),
    BegView(),
    FavoriteView(),
    CategoryView(),
    ProfleView(),
  ];

  int get currentTab => _currentIndex;

  currentTabChange(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_eshop/theme/app_colors.dart';
import 'package:flutter_eshop/theme/nab_icon_icons.dart';
import 'package:flutter_eshop/widget/bottom_icon_widget.dart';

class CustomBottomNavigator extends StatelessWidget {
  const CustomBottomNavigator({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      child: BottomNavigationBar(
        currentIndex: 0,
        backgroundColor: isDarkMode ? AppColors.blackDark : Colors.grey[200],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(NabIcon.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Category",
          ),
          BottomNavigationBarItem(
            icon: BottomIconWidget(
              currentIndex: 0,
              pageIndex: 2,
              icon: NabIcon.shoppingBag,
              value: 4,
            ),
            label: "Beg",
          ),
          BottomNavigationBarItem(
            icon: BottomIconWidget(
              currentIndex: 0,
              pageIndex: 2,
              icon: NabIcon.heart,
              value: 2,
            ),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Icon(NabIcon.profile),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

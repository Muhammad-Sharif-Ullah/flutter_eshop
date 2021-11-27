import 'package:flutter/material.dart';
import 'package:flutter_eshop/theme/app_colors.dart';

class BottomIconWidget extends StatelessWidget {
  const BottomIconWidget({
    Key? key,
    required this.currentIndex,
    required this.pageIndex,
    required this.icon,
    required this.value,
  }) : super(key: key);
  final int currentIndex;
  final int pageIndex;
  final IconData icon;
  final int value;
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 50,
          // height: 30,
          child: Icon(icon),
        ),
        if (value != 0)
          Positioned(
            right: 1,
            top: -2,
            child: Container(
              height: 18,
              width: 18,
              padding: const EdgeInsets.all(2),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentIndex == pageIndex
                    ? AppColors.primary
                    : AppColors.primary,
                border: Border.all(
                    width: 2,
                    color: isDarkMode ? AppColors.blackDark : Colors.white),
              ),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Text(value.toString(),
                    style: textTheme.caption?.copyWith(color: Colors.white)),
              ),
            ),
          ),
      ],
    );
  }
}

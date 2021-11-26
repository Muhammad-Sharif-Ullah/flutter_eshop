import 'package:flutter/material.dart';
import 'package:flutter_eshop/theme/app_colors.dart';

class InputBoxWidget extends StatelessWidget {
  const InputBoxWidget({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.blackDark : Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            color: const Color(0xFF000000).withOpacity(0.2),
            blurRadius: 2,
            // spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: child,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_eshop/theme/app_colors.dart';
import 'package:flutter_eshop/theme/app_constant.dart';

class GoogleAuthButton extends StatelessWidget {
  const GoogleAuthButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Image.asset(AppConstant.google),
        fillColor: Colors.white,
        onPressed: onPressed,
        elevation: 4,
        focusElevation: 4,
        splashColor: AppColors.primary,
      ),
    );
  }
}

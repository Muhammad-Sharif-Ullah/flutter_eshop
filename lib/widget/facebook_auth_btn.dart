import 'package:flutter/material.dart';
import 'package:flutter_eshop/theme/app_colors.dart';
import 'package:flutter_eshop/theme/app_constant.dart';

class FaceBookAuthButton extends StatelessWidget {
  const FaceBookAuthButton({
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
        child: Image.asset(AppConstant.facebook),
        onPressed: onPressed,
        fillColor: Colors.white,
        elevation: 4,
        focusElevation: 4,
        splashColor: AppColors.primary,
      ),
    );
  }
}

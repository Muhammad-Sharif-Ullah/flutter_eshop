import 'package:flutter/material.dart';
import 'package:flutter_eshop/theme/app_colors.dart';
import 'package:flutter_eshop/theme/fonts_names.dart';

class PasswordField extends StatefulWidget {
  const PasswordField(
      {Key? key,
      required this.label,
      required this.hintText,
      required this.passCNT,
      required this.validator})
      : super(key: key);

  final String label;
  final String hintText;
  final TextEditingController passCNT;
  final String? Function(String?)? validator;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isVisibilityOn = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passCNT,
      validator: widget.validator,
      // keyboardType: TextInputType.visiblePassword,
      obscureText: isVisibilityOn,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: widget.label,
        labelStyle: const TextStyle(color: Colors.grey),
        hintText: widget.hintText,
        errorStyle: const TextStyle(
          fontSize: 10,
          fontFamily: FontsName.regular,
        ),
        suffixIcon: IconButton(
          // icon: const Icon(Icons.visibility, color: AppColors.primary),
          icon: isVisibilityOn
              ? const Icon(Icons.visibility, color: AppColors.primary)
              : const Icon(Icons.visibility_off, color: AppColors.primary),
          onPressed: () {
            setState(() {
              isVisibilityOn = !isVisibilityOn;
            });
          },
        ),
      ),
    );
  }
}

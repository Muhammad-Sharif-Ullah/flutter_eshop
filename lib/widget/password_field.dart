
import 'package:flutter/material.dart';
import 'package:flutter_eshop/theme/app_colors.dart';

class PasswordField extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: passCNT,
      validator: validator,
      // keyboardType: TextInputType.visiblePassword,
      // obscureText: controller.visibility.value,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        hintText: hintText,
        suffixIcon: IconButton(
          icon: const Icon(Icons.visibility, color: AppColors.primary),
          // icon: controller.visibility.value
          //     ? Icon(Icons.visibility, color: AppColors.primary)
          //     : Icon(Icons.visibility_off, color: AppColors.primary),
          onPressed: () {
            // print('calling');
            // print(controller.visibility.value);
            // controller.visibility.toggle();
            // print(controller.visibility.value);
          },
        ),
      ),
    );
  }
}

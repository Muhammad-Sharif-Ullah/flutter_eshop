import 'package:flutter/material.dart';
import 'package:flutter_eshop/theme/app_constant.dart';
import 'package:flutter_eshop/utils/validator.dart';
import 'package:flutter_eshop/widget/big_splash_button.dart';
import 'package:flutter_eshop/widget/input_container_widget.dart';
import 'package:flutter_eshop/widget/text_input.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({Key? key}) : super(key: key);

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final TextEditingController _email = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    // final double height = size.height;
    final TextTheme textTheme = Theme.of(context).textTheme;
    // final bool isDarkMode =
    //     MediaQuery.of(context).platformBrightness == Brightness.dark;

    Widget requestToResetPass() {
      return BigSplashButton(
        width: width,
        height: 48,
        text: "SEND",
        onPressed: () {
          // print(_formKey.currentState!.validate());
          // if (_formKey.currentState!.validate())
          //   controller.resetPass(_email.text.trim());
        },
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                Text(
                  "Forgot password",
                  style: textTheme.headline1,
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      'Enter your email address. You will receive a link to create a new password via email',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(height: 20),
                    InputBoxWidget(
                      child: TextInputField(
                        controller: _email,
                        validator: (value) => Validator.emailValidate(value),
                        label: "Email",
                        hintText: "your@email.com",
                        inputType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(height: 32),
                    requestToResetPass(),
                    const SizedBox(height: 16),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

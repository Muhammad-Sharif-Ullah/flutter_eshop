import 'package:flutter/material.dart';
import 'package:flutter_eshop/theme/app_constant.dart';
import 'package:flutter_eshop/utils/validator.dart';
import 'package:flutter_eshop/widget/facebook_auth_btn.dart';
import 'package:flutter_eshop/widget/google_auth_btn.dart';
import 'package:flutter_eshop/widget/input_container_widget.dart';
import 'package:flutter_eshop/widget/password_field.dart';
import 'package:flutter_eshop/widget/textInput.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // final double width = size.width;
    final double height = size.height;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: () async {
        // controller.visibility.value = true;
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                height: height,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstant.kPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    Text(
                      "Login",
                      style: textTheme.headline1,
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Column(
                      children: [
                        InputBoxWidget(
                          child: TextInputField(
                            controller: _email,
                            validator: (value) =>
                                Validator.emailValidate(value),
                            label: "Email",
                            hintText: "your@email.com",
                            inputType: TextInputType.emailAddress,
                          ),
                        ),
                        const SizedBox(height: 10),
                        InputBoxWidget(
                          child: PasswordField(
                            passCNT: _password,
                            validator: (value) => Validator.passValidate(value),
                            label: "Password",
                            hintText: "Password",
                          ),
                        ),
                        // const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            child: Text("Forgot Password",
                                style: textTheme.subtitle1),
                            // onPressed: () => Get.to(() => ForgotPassView()),
                            onPressed: () {},
                          ),
                        ),

                        const SizedBox(height: 32),
                        // buildLoginButton(context),
                        // const SizedBox(height: 16),
                        Center(
                          child: TextButton(
                            child: Text("Don't have a account?",
                                style: textTheme.subtitle1),
                            // onPressed: () => Get.to(() => SignUpView()),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Column(
                      children: [
                        Center(
                          child: Text(
                            'Or login with social account',
                            style: textTheme.subtitle1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GoogleAuthButton(onPressed: () {}),
                            const SizedBox(width: 16),
                            FaceBookAuthButton(onPressed: () {}),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

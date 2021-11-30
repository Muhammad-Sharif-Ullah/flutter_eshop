import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_eshop/provider/auth_provider.dart';
import 'package:flutter_eshop/routes/app_pages.dart';
import 'package:flutter_eshop/theme/app_colors.dart';
import 'package:flutter_eshop/theme/app_constant.dart';
import 'package:flutter_eshop/utils/validator.dart';
import 'package:flutter_eshop/widget/facebook_auth_btn.dart';
import 'package:flutter_eshop/widget/google_auth_btn.dart';
import 'package:flutter_eshop/widget/input_container_widget.dart';
import 'package:flutter_eshop/widget/password_field.dart';
import 'package:flutter_eshop/widget/text_input.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _email = TextEditingController();

  final TextEditingController _name = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return WillPopScope(
      onWillPop: () async {
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
                    SizedBox(height: height * .01),

                    Text(
                      "Sign Up",
                      style: textTheme.headline1,
                    ),
                    const Spacer(
                      flex: 1,
                    ),

                    // const SizedBox(height: 20),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 3,
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.blackDark),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100000),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100000),
                            child: context.watch<AuthProvider>().imagePicked !=
                                    ''
                                ? Image.file(
                                    File(
                                      context.watch<AuthProvider>().imagePicked,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : buildNoImageWidget(isDarkMode),
                            onTap: () => _choseImage(context),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),

                    Column(
                      children: [
                        InputBoxWidget(
                          child: TextInputField(
                            label: "Name",
                            validator: (value) => Validator.nameValidate(value),
                            hintText: "Your Name",
                            controller: _name,
                            inputType: TextInputType.name,
                          ),
                        ),
                        SizedBox(height: height * .01),

                        InputBoxWidget(
                          child: TextInputField(
                            validator: (value) =>
                                Validator.emailValidate(value),
                            controller: _email,
                            label: "Email",
                            hintText: "your@email.com",
                            inputType: TextInputType.emailAddress,
                          ),
                        ),
                        SizedBox(height: height * .01),

                        InputBoxWidget(
                          child: PasswordField(
                            passCNT: _password,
                            validator: (value) => Validator.passValidate(value),
                            label: "Password",
                            hintText: "Password",
                          ),
                        ),

                        SizedBox(height: height * .01),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            child: Text("Already have an account?",
                                style: textTheme.subtitle1),
                            onPressed: () =>
                                Navigator.pushNamed(context, AppRoutes.login),
                          ),
                        ),

                        // Obx(() => controller.isRequesting.value
                        //     ? CircularProgressIndicator()
                        // : buildSignUpButton(context)),
                        Consumer<AuthProvider>(
                          builder: (context, authP, child) => authP.isRequesting
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10.0,
                                  ),
                                  child: SizedBox(
                                    height: height * .005,
                                    child: const LinearProgressIndicator(),
                                  ),
                                )
                              : buildSignUpButton(
                                  context, width, textTheme, _formKey),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Center(
                          child: Text(
                            'Or sing up with social account',
                            style: textTheme.subtitle1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GoogleAuthButton(onPressed: () {
                              // print('Check');
                              // print(FirebaseAuth.instance.currentUser);
                            }),
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

  Icon buildNoImageWidget(bool isDarkMode) => Icon(Icons.person_outlined,
      size: 40, color: isDarkMode ? AppColors.white : AppColors.blackDark);

  MaterialButton buildSignUpButton(BuildContext context, double width,
      TextTheme textTheme, GlobalKey<FormState> formKey) {
    return MaterialButton(
      height: 48,
      minWidth: width,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      color: AppColors.primary,
      child: Text('Sing Up',
          style: textTheme.subtitle1?.copyWith(color: Colors.white)),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          print.call("Validation Completet");
          context.read<AuthProvider>().getSingUp(_name.text.trim(),
              _email.text.trim(), _password.text.trim(), context);
        } else {
          print.call("Validation Completet");
        }
      },
    );
  }

  Future<dynamic> _choseImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              context.read<AuthProvider>().getImage(true, context);
            },
            icon: const Icon(
              Icons.photo_album,
              color: Colors.white,
            ),
            label: const Text('Gallery', style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton.icon(
            onPressed: () {
              context.read<AuthProvider>().getImage(false, context);
            },
            icon: const Icon(Icons.camera, color: Colors.white),
            label: const Text(
              'Camera',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

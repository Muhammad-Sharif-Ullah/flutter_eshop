import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eshop/routes/app_pages.dart';
import 'package:flutter_eshop/services/firebase_auth.dart';
import 'package:flutter_eshop/utils/show_snackbar.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  String imagePicked = '';
  bool isRequesting = false;

  void requesting() {
    isRequesting = !isRequesting;
    notifyListeners();
  }

  Future<void> getImage(bool isGallery, BuildContext context) async {
    if (isGallery) {
      imagePicked =
          (await _picker.pickImage(source: ImageSource.gallery))!.path;
    } else {
      imagePicked = (await _picker.pickImage(source: ImageSource.camera))!.path;
    }
    notifyListeners();
    Navigator.pop(context);
    print.call(imagePicked);
  }

  getLogin(String email, String pass, BuildContext context) async {
    requesting();
    await FireBaseAuth.login(email, pass).then((authResponse) {
      if (authResponse.isSuccess) {
        requesting();
        print.call(authResponse.message);
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } else {
        requesting();
        showSnack(context, authResponse.message, Colors.redAccent);
      }
    }).catchError((error) {
      requesting();
      showSnack(context, error.message, Colors.redAccent);
    });
  }

  getSingUp(
      String userName, String email, String pass, BuildContext context) async {
    requesting();
    await FireBaseAuth.signUp(
            email, pass, userName, File(imagePicked))
        .then((authResponse) {
      if (authResponse.isSuccess) {
        requesting();
        print.call(authResponse.message);
      } else {
        requesting();
        showSnack(context, authResponse.message, Colors.redAccent);
      }
    }).catchError((error) {
      requesting();
      showSnack(context, error.message, Colors.redAccent);
    });
  }
}

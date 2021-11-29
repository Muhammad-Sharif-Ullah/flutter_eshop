import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  getLogin() async {}

  getSinUp(
      String userName, String email, String pass, BuildContext context) async {}
}

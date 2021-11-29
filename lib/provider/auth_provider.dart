
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  String imagePicked = '';
  bool isRequesting = false;

  void requesting() => isRequesting = !isRequesting;

  getImage(bool isGallery, BuildContext context) async {
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
}

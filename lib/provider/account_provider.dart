import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_eshop/routes/app_pages.dart';

class AccountProvider with ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => firebaseAuth.currentUser;
  bool get isLogin => FirebaseAuth.instance.currentUser == null ? false : true;

  logOut(BuildContext context) async {
    await firebaseAuth.signOut();
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }
}

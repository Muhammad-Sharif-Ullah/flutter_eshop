import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_eshop/model/auth_response_model.dart';

import 'firebase_collection.dart';
import 'firebase_storage.dart';

class FireBaseAuth {
  static final FirebaseAuth _authInstance = FirebaseAuth.instance;
  static final FirebaseFirestore _fireStoreInstance =
      FirebaseFirestore.instance;
  static final User? user = _authInstance.currentUser;

  ///Login with email and password
  ///if not exist throw errors
  static Future<bool> login(
      String email, String pass, bool isRequesting) async {
    isRequesting = !isRequesting;
    return await _authInstance
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((UserCredential value) {
      isRequesting = !isRequesting;
      print.call(value.user);
      return true;
    }).onError((FirebaseAuthException error, stackTrace) {
      print.call('ON ERROR');
      isRequesting = !isRequesting;
      // errorSnackBar("Could not sing in", error.code);
      return false;
    }).catchError((onError) {
      print.call('Catch ERROR');
      isRequesting = !isRequesting;
      // errorSnackBar("Could not sing in", onError.toString());
      return false;
    });
  }

  ///SIGN UP with email, password image, and name;
  /// 1st. check email is exist
  ///      if not:
  ///           1. update user -> displayName and user-> updatePhotoURL
  ///           2. save user Credential in to "users" collections
  ///           3. save image in the firebase storage
  ///       else:
  ///           show the relevant issure
  static Future<AuthResponseModel> signUp(String email, String password,
      String name, bool isRequesting, File avatar) async {
    isRequesting = !isRequesting;
    return await _authInstance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((UserCredential value) {
      print.call(value.user);
      // isRequesting = !isRequesting;
      storeUserData(value.user!, name, avatar);
      return AuthResponseModel(true, "Successfully SignUp");
    }).onError((FirebaseAuthException error, stackTrace) {
      // isRequesting = !isRequesting;
      // errorSnackBar("Could not sing up", error.code);
      // return false;
      return AuthResponseModel(false, error.code);
    }).catchError((error) {
      // isRequesting = !isRequesting;
      // errorSnackBar("Could not sing up", error.toString());
      // return false;
      return AuthResponseModel(false, error.code);
    });
  }

  /// Store the User info
  ///  1. update user -> displayName and user-> updatePhotoURL
  ///  2. save user Credential in to "users" collections
  ///  3. save image in the firebase storage
  static storeUserData(User user, String name, File file) async {
    /// save user-> displayName
    user.updateDisplayName(name);

    /// save image to firebase storage
    final ref = await FireBaseStorage.saveAvatar(file, user);
    String? url;
    if (ref != null) {
      /// get Downloadable link
      url = await FireBaseStorage.getAvatar(ref.fullPath);

      ///Save user-> updatePhotoURL
      if (url != null) user.updatePhotoURL(url);
    }

    ///Save user Info into "users" collections
    FireBaseCollection.saveUserData(name, url, user);

    // Creating Beg, Orders, Favorite, Address, Reviews Collection
    // FireBaseCollection.creatingUserCollection(user.uid);
  }

  /// Return True if use is loged in
  static bool isLogedIn() {
    if (_authInstance.currentUser == null) return false;
    return true;
  }

  /// Get current user name
  static Future<String> getUserName() async {
    String uid = user!.uid;
    final info = await _fireStoreInstance.collection('users').doc(uid).get();
    return info['name'];
  }

  /// Logout
  static logOut() async {
    await _authInstance.signOut();
  }

  ///Get current user
  static User? getCurrentUser() {
    return _authInstance.currentUser;
  }

  static Future<Map<String, dynamic>> resetPassword(String email) async {
    return _authInstance.sendPasswordResetEmail(email: email).then((value) {
      return <String, dynamic>{"status": true, "message": "success"};
    }).onError((FirebaseAuthException error, stackTrace) =>
        <String, dynamic>{'status': false, "message": error.code.toString()});
  }

  FireBaseAuth();
}

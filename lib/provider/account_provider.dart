import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_eshop/model/beg_model.dart';
import 'package:flutter_eshop/model/product_mode.dart';
import 'package:flutter_eshop/routes/app_pages.dart';
import 'package:flutter_eshop/services/firebase_collection.dart';

class AccountProvider with ChangeNotifier {
  AccountProvider() {
    getFavoritesIds();
    getBegStream();
  }

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  List<String> favoriteIds = [];
  List<BegModel> begs = [];
  bool isListView = false;

  User? get currentUser => firebaseAuth.currentUser;
  bool get isLogin => FirebaseAuth.instance.currentUser == null ? false : true;

  logOut(BuildContext context) async {
    await firebaseAuth.signOut();
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  toggleListView() {
    isListView = !isListView;
    notifyListeners();
  }

  getFavoritesIds() {
    FireBaseCollection.favoritesIdAsStream(currentUser!.uid).listen((event) {
      favoriteIds = event;
      notifyListeners();
    });
  }

  removeFromFavorite(String id) => FireBaseCollection.removeFromFavorite(id);
  addInFavorite(String id) => FireBaseCollection.addToMyFavorites(id);
  addOrRemoveFavorite(String id) {
    if (favoriteIds.contains(id)) {
      removeFromFavorite(id);
    } else {
      addInFavorite(id);
    }
  }

  Future<List<ProductModel>> favoritesList() async {
    return await fireStore
        .collection('products')
        // .where("id", arrayContains: favoriteIds)
        .get()
        .then((value) {
      List<ProductModel> favList = [];
      for (var e in value.docs) {
        if (favoriteIds.contains(e.id)) {
          favList.add(ProductModel.fromJson(e.data()));
        }
      }
      print.call("Chekcing ----favoirte--${favList.length}");
      return favList;
    });
  }

  getBegStream() {
    FireBaseCollection.getBegAsStream(currentUser!.uid).listen((event) {
      begs = event;
      print.call("-----checking begs---${event.length}");
      notifyListeners();
    });
  }

  deleteItemFromBeg(String prodId) async {
    await FireBaseCollection.deleteItemFromBeg(prodId, currentUser!.uid);
  }

  updatePriceAndQuantity(int quantity, String prodId, String price) async {
    await FireBaseCollection.changeQuantity(quantity, prodId, price);
  }

  getOriginalPrice(String prodId) {
    return FireBaseCollection.priceAsStream(prodId);
  }

  Stream<int> getOriginalQuantity(String prodId) {
    return FireBaseCollection.quantityAsStream(prodId);
  }
}

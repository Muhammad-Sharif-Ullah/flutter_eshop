import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_eshop/model/auth_response_model.dart';
import 'package:flutter_eshop/model/beg_model.dart';
import 'package:image_picker/image_picker.dart';

import 'firebase_storage.dart';

class FireBaseCollection {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;
  static const String beg = 'beg';
  static const String favorites = 'favorites';
  static const String products = 'products';
  static const String users = 'users';
  static const String address = 'address';
  static const String reviews = 'reviews';
  static const String orders = 'orders';
  static const String shipping = 'shipping_address';

  static saveUserData(String name, String? url, User user) async {
    await _instance.collection(users).doc(user.uid).set({
      'name': name,
      'email': user.email,
      'uid': user.uid,
      'avatar': url,
    }).onError((FirebaseException error, stackTrace) {
      print.call(error.code);
      print.call(" ------------------------");
      // return errorSnackBar("Could not sing up", error.code.toString());
    }).catchError((error) {
      print.call(" ------------------------");

      print.call(error.code);
      // return errorSnackBar("Could not sing up", error.toString());
    });
  }

  static Future<FirebaseResponseModel> addToBeg(
      {required Map<String, dynamic> begMap}) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    ///Checking if the beg items is already exists
    ///in the firebase collection then no need to create new one.
    return await _instance
        .collection("$users/$uid/$beg")
        .doc(begMap['id'])
        .set(begMap)
        .then((value) => FirebaseResponseModel(true, "Success"))
        .onError((FirebaseException error, stackTrace) {
      print.call(error.code);
      return FirebaseResponseModel(true, error.message.toString());
    }).catchError((error) {
      print.call(error);
      return FirebaseResponseModel(true, error.message.toString());
    });
  }

  static Stream<List<BegModel>> getBegAsStream(String uid) {
    return _instance.collection('users/$uid/beg').snapshots().map((begs) {
      return begs.docs.map((beg) => BegModel.fromJson(beg.data())).toList();
    });
  }

  static deleteItemFromBeg(String prodId, String uid) async {
    return await _instance.doc('users/$uid/beg/$prodId').delete();
  }

  static Stream<List<String>> favoritesIdAsStream(String uid) {
    return _instance
        .doc('users/$uid/favorites/favorites_list')
        .snapshots()
        .map((ids) {
      final List<String> data = [];
      for (var e in ids.data()!['product_id']) {
        data.add(e);
      }
      return data;
    });
  }

  static addToMyFavorites(String prodId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await _instance
        .doc("$users/$uid/")
        .collection(favorites)
        .doc("favorites_list")
        .get()
        .then((doc) async {
      if (doc.exists == true) {
        List<String> previousList = [...doc.get('product_id')];

        if (!previousList.contains(prodId)) {
          previousList.add(prodId);
          _instance
              .doc("$users/$uid/$favorites/favorites_list")
              .update({"product_id": previousList});
        }
      } else {
        print.call(doc.exists);
        await _instance
            .collection("$users/$uid/$favorites")
            .doc('favorites_list')
            .set({
          "product_id": [prodId],
        });
      }
    });
  }

  static removeFromFavorite(String prodID) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await _instance
        .doc("$users/$uid/")
        .collection(favorites)
        .doc("favorites_list")
        .get()
        .then((doc) async {
      List<String> previousList = [...doc.get('product_id')];
      previousList.remove(prodID);
      await _instance
          .doc("$users/$uid/$favorites/favorites_list")
          .update({"product_id": previousList});
    });
  }

  static Future<dynamic> getProductData(String prodID, String filed) async {
    final data = await _instance
        .collection(products)
        .doc(prodID)
        .get()
        .then((value) => (value[filed]));
    return data;
  }

  static changeQuantity(int value, String prodId, String price) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    print.call("Checking : $prodId");
    await _instance
        .doc("$users/$uid/beg/$prodId")
        .update({"quantity": value, "price": price})
        .then((value) => print.call("Success"))
        .onError((error, stackTrace) => print.call("$error"));
  }

  static Stream<double> priceAsStream(String prodId) {
    return _instance
        .collection('products')
        .doc(prodId)
        .snapshots()
        .map((items) {
      return double.parse(items['old_price']);
    });
  }

  static Stream<int> quantityAsStream(String prodId) {
    return _instance
        .collection('products')
        .doc(prodId)
        .snapshots()
        .map((items) {
      return items['quantity'];
    });
  }

  static Future<List<Map<String, dynamic>>> fetchRelatedProduct(
      String category) async {
    return await _instance
        .collection(products)
        .where('category', isEqualTo: category)
        .get()
        .then((value) {
      return value.docs.map((e) {
        return e.data();
      }).toList(); //toList()
    });
  }

  /// First Uploads all the reviews images.
  /// Then save the reviews in products-> reviews doc.
  /// Then save the product ID in users-> reviews -> productList -> product_id's array.
  /// Errors : 100-mean files not upload successfully
  /// 101 - mean Failed to save reviews in products-> reviews
  /// 102 - mean Failed to save product ID in users-> reviews
  /// 103 - failed to save new product id in previous id's list
  /// 104 - failed to create product-id list in users doc
  /// 105 - failed to search users->uid->reviews->product_list->
  static Future<bool> addComment(Map<String, dynamic> comments) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String prodId = comments['product_Id'];
    int rating = comments['rate'];
    List<File> files = [];
    for (XFile image in comments['images']) {
      files.add(File(image.path));
    }
    final List<String> imageUrls =
        await FireBaseStorage.uploadFilesAndGetUrls(files, uid);
    comments['images'] = imageUrls;

    /// Save review in product doc
    return await _instance
        .collection("$products/$prodId/$reviews")
        .doc(uid)
        .set(comments)
        .then(
      (value) async {
        /// Update the rating in Product DOC
        updateRatingInProdDOC(prodId, uid, rating);

        /// Save the reviews id to user reviews DOC
        _saveTheReviewInUserDoc(uid, prodId);

        /// Successfully add the reviews on products doc
        print.call('Successfully add the reviews on products doc');
        return true;
      },
    ).onError((FirebaseException error, stackTrace) {
      print.call("[E-CODE- 101] ${error.code}");
      return false;
    });
  }

  /// First check is the reviews id list already exists or not
  /// If Exists grave the old id list and insert the new product id
  /// otherwise create new array list in users->uid->reviews->product_list->product-id
  /// Errors : 103 - failed to save new product id in previous id's list
  /// 104 - failed to create product-id list in users doc
  /// 105 - failed to search users->uid->reviews->product_list->
  static Future<bool> _saveTheReviewInUserDoc(String uid, String prodId) async {
    return await _instance
        .collection("$users/$uid/$reviews")
        .doc('product_list')
        .get()
        .then((value) async {
      if (value.exists == true) {
        List<String> previousList = [...value.get('product_id')];
        if (!previousList.contains(prodId)) {
          previousList.add(prodId);
          await _instance
              .doc("$users/$uid/$reviews/product_list")
              .update({"product_id": previousList})
              .then((value) => true)
              .onError((FirebaseException error, stackTrace) {
                print.call("[E-CODE- 103] ${error.code}");
                return false;
              });
        }
      } else {
        await _instance
            .collection("$users/$uid/$reviews")
            .doc('product_list')
            .set({
              'product_id': [prodId],
            })
            .then((value) => true)
            .onError((FirebaseException error, stackTrace) {
              print.call("[E-CODE- 104] ${error.code}");
              return false;
            });
      }
      return true;
    }).onError((FirebaseException error, stackTrace) {
      print.call("[E-CODE- 105] ${error.code}");
      return false;
    });
  }

  ///This function only invoke when a user
  ///like a comment of comment
  static likeAComment(String uid, String prodId) async {
    String url = "$products/$prodId/$reviews";
    await _instance.collection(url).doc(uid).get().then((value) async {
      List<String> reviewLiked = value.data()!['reviewLiked'].cast<String>();
      if (reviewLiked.contains(uid)) {
        reviewLiked.remove(uid);
      } else {
        reviewLiked.add(uid);
      }
      await _instance
          .doc("$url/$uid/")
          .update({"reviewLiked": reviewLiked}).then((value) {
        print.call("[INFO] Like Update Complete");
      }).onError((FirebaseException error, stackTrace) {
        print.call("[ERROR] Like Not Update ${error.code}");
      });
      print.call(reviewLiked.length);
    });
  }

  static updateRatingInProdDOC(String prodID, String uid, int rate) async {
    await _instance.collection(products).doc(prodID).get().then((value) async {
      Map<String, int> rating = value.get('rating').cast<String, int>();
      if (rating.containsKey(uid)) {
        rating.update(uid, (value) => rate);
      } else {
        rating[uid] = rate;
      }
      _instance.collection(products).doc(prodID).update({
        "rating": rating,
      }).onError((FirebaseException error, stackTrace) {
        print.call(error.message);
      });
    }).onError((FirebaseException error, stackTrace) {
      print.call(error.message);
    });
  }

  //? Adding New shipping address in user DOC
  //? Name , Address, City, Zip Code

  static Future<bool> addingShippingAddress(
      Map<String, dynamic> addressMap) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return _instance
        .collection("$users/$uid/$address")
        .doc('${addressMap['id']}')
        .set(addressMap)
        .then((value) => true)
        .onError((FirebaseException error, stackTrace) {
      print.call(error.code);
      return false;
    }).catchError((error) {
      print.call(error);
      return false;
    });
  }

  // static Future<bool> deleteShoppingAddress() {
  //   String uid = FirebaseAuth.instance.currentUser!.uid;
  // }

  static Future<bool> makeActiveAddress(
      String activeID, String toBeAactiveID, bool currentState) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    if (activeID == toBeAactiveID) activeID = '';
    print.call("AC: $activeID, BEA:  $toBeAactiveID");

    if (activeID.isNotEmpty) {
      return await _instance
          .collection("$users/$uid/$address")
          .doc(activeID)
          .update({"is_active": false})
          .then((value) async {
            return await _instance
                .collection("$users/$uid/$address")
                .doc(toBeAactiveID)
                .update({"is_active": !currentState})
                .then((value) => true)
                .onError((FirebaseException error, stackTrace) => false)
                .catchError((error) => false);
          })
          .onError((error, stackTrace) => false)
          .catchError((error) => false);
    } else {
      return await _instance
          .collection("$users/$uid/$address")
          .doc(toBeAactiveID)
          .update({"is_active": !currentState})
          .then((value) async => true)
          .onError((error, stackTrace) => false)
          .catchError((error) => false);
    }
  }

  FireBaseCollection._();
}

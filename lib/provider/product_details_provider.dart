import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_eshop/model/auth_response_model.dart';
import 'package:flutter_eshop/model/beg_model.dart';
import 'package:flutter_eshop/model/product_mode.dart';
import 'package:flutter_eshop/services/firebase_collection.dart';
import 'package:flutter_eshop/theme/app_colors.dart';
import 'package:flutter_eshop/utils/show_snackbar.dart';

class ProductDetailsProvider with ChangeNotifier {
  late ProductModel product;
  late String colorSelected;
  late String sizeSelected;
  List<ProductModel> relatedProd = [];
  // ProductDetailsProvider() {}
  defineProvider(
      {required ProductModel prod,
      required String color,
      required String size}) async {
    product = prod;
    colorSelected = color;
    sizeSelected = size;
    relatedProd = await getRelatedProduct();
  }

  changeColor(String color) {
    colorSelected = color;
    notifyListeners();
  }

  changeSize(String size) {
    sizeSelected = size;
    notifyListeners();
  }

  Future<List<ProductModel>> getRelatedProduct() async {
    String query = product.category!;
    List<ProductModel> relatedProducts = [];

    await FireBaseCollection.fetchRelatedProduct(query).then((prods) {
      for (Map<String, dynamic> prod in prods) {
        if (prod['id'] != product.id) {
          relatedProducts.add(ProductModel.fromJson(prod));
        }
      }
    });
    print.call("-------${relatedProd.length}");
    return relatedProducts;
  }

  addToBag(BuildContext context) async {
    await FireBaseCollection.addToBeg(
      begMap: BegModel.productToBeg(product, colorSelected, sizeSelected, 1),
    )
        .then(
          (value) => showSnack(context, value.message, AppColors.success),
        )
        .onError(
          (FirebaseResponseModel error, stackTrace) =>
              showSnack(context, error.message, Colors.redAccent),
        );
  }
}

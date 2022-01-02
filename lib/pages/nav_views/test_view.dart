import 'package:flutter/material.dart';
import 'package:flutter_eshop/model/product_mode.dart';
import 'package:flutter_eshop/provider/product_details_provider.dart';
import 'package:provider/provider.dart';

class TestView extends StatelessWidget {
  final ProductModel product;
  const TestView({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductDetailsProvider>(
      create: (BuildContext context) => ProductDetailsProvider(),
      builder: (context, child) {
        return Scaffold(
          body: Center(
              child:
                  Text(context.read<ProductDetailsProvider>().product.brand!)),
        );
      },
    );
  }
}

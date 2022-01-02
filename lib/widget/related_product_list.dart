import 'package:flutter/material.dart';
import 'package:flutter_eshop/model/product_mode.dart';
import 'package:flutter_eshop/provider/product_details_provider.dart';
import 'package:flutter_eshop/widget/related_product_cart.dart';
import 'package:provider/provider.dart';

class RelatedProductList extends StatelessWidget {
  const RelatedProductList({
    Key? key,
    required this.isDarkMode,
    required this.textTheme,
  }) : super(key: key);

  final bool isDarkMode;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: context.watch<ProductDetailsProvider>().relatedProd.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 305,
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
      ),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, int index) {
        final ProductModel product =
            context.read<ProductDetailsProvider>().relatedProd[index];
        return InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(10),
          child: RelatedProductCard(
              isDarkMode: isDarkMode, textTheme: textTheme, product: product),
        );
      },
    );
  }
}

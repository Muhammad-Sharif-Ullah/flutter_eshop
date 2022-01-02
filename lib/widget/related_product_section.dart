import 'package:flutter/material.dart';
import 'package:flutter_eshop/model/product_mode.dart';
import 'package:flutter_eshop/provider/product_details_provider.dart';
import 'package:flutter_eshop/theme/app_constant.dart';
import 'package:flutter_eshop/widget/related_product_list.dart';
import 'package:provider/provider.dart';

class RelatedProductSection extends StatelessWidget {
  const RelatedProductSection({
    Key? key,
    required this.textTheme,
    required this.prodWatchProvider,
    required this.isDarkMode,
  }) : super(key: key);

  final TextTheme textTheme;
  final ProductDetailsProvider prodWatchProvider;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
        future: context.read<ProductDetailsProvider>().getRelatedProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: const [
                  Text('Falied To Load Related Product'),
                  SizedBox(height: 5),
                ],
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: const [
                  Text('Fatching Related Product'),
                  SizedBox(height: 5),
                  LinearProgressIndicator(),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(AppConstant.kPadding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'You may also like',
                      style: textTheme.headline3,
                    ),
                    Text(
                      '${prodWatchProvider.relatedProd.length}',
                      style: textTheme.caption,
                    )
                  ],
                ),
                const SizedBox(height: 5),
                RelatedProductList(
                  isDarkMode: isDarkMode,
                  textTheme: textTheme,
                ),
              ],
            ),
          );
        });
  }
}

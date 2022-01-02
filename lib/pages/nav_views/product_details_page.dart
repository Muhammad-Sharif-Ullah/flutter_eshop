import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eshop/provider/account_provider.dart';
import 'package:flutter_eshop/provider/product_details_provider.dart';
import 'package:flutter_eshop/theme/app_colors.dart';
import 'package:flutter_eshop/theme/app_constant.dart';
import 'package:flutter_eshop/theme/nab_icon_icons.dart';
import 'package:flutter_eshop/widget/big_splash_button.dart';
import 'package:flutter_eshop/widget/cached_network_widget.dart';
import 'package:flutter_eshop/widget/product_info.dart';
import 'package:flutter_eshop/widget/related_product_section.dart';
import 'package:flutter_eshop/widget/review_section.dart';
import 'package:flutter_eshop/widget/select_size_colors.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductDetailsProvider prodReadProvider =
        context.read<ProductDetailsProvider>();
    final ProductDetailsProvider prodWatchProvider =
        context.read<ProductDetailsProvider>();
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme:
            IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
        elevation: 0,
        backgroundColor:
            isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight,
        title: Text(
          prodReadProvider.product.category!,
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        actions: [
          SizedBox(
            height: 40,
            width: 40,
            child: Stack(
              fit: StackFit.loose,
              alignment: Alignment.center,
              children: [
                const Icon(NabIcon.bagNofill),
                if (context.watch<AccountProvider>().begs.isNotEmpty)
                  Positioned(
                      right: 0,
                      top: 10,
                      child: Container(
                        height: 20,
                        width: 20,
                        padding: const EdgeInsets.all(2.4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                          border: Border.all(
                              width: 2,
                              color: isDarkMode
                                  ? AppColors.blackDark
                                  : Colors.white),
                        ),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Text(
                            context
                                .watch<AccountProvider>()
                                .begs
                                .length
                                .toString(),
                            style: textTheme.caption
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      )),
                if (0 == 0) Container()
              ],
            ),
          ),
          const SizedBox(width: 24),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 350,
              width: width,
              child: CarouselSlider.builder(
                itemCount: prodReadProvider.product.images!.length,
                options: CarouselOptions(
                  autoPlay: true,
                  height: 200,
                  // aspectRatio: 16 / 9,
                  aspectRatio: 2.0,
                  viewportFraction: 0.9,
                  reverse: false,
                  // initialPage: 2,
                ),
                itemBuilder: (context, itemIndex, pageViewIndex) {
                  final String image =
                      prodReadProvider.product.images![itemIndex];
                  return CachedNetworkWidget(
                    url: image,
                    height: 184,
                    width: 200,
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
              child: Column(
                children: [
                  const SelectSizeColor(),
                  ProductInfo(
                    brand: prodReadProvider.product.brand!,
                    price: double.parse(prodReadProvider
                        .product.oldPrice!), //TODO? Deside later
                    prodType: prodReadProvider.product.category!,
                    rating: prodReadProvider.product.rating!, //TODO: Testing
                    shortInfo: prodReadProvider.product.description!,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
              child: BigSplashButton(
                height: 48,
                width: width,
                text: "Add To Cart",
                onPressed: () async =>
                    context.read<ProductDetailsProvider>().addToBag(context),
              ),
            ),
            const SizedBox(height: 20),
            const ReviewSection(),
            const SizedBox(height: 10),
            const Divider(),
            RelatedProductSection(
              textTheme: textTheme,
              prodWatchProvider: prodWatchProvider,
              isDarkMode: isDarkMode,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      // ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'Write Comments',
        onPressed: () {
          // Get.to(
          //   () => WriteReview(),
          //   transition: Transition.downToUp,
          //   duration: Duration(milliseconds: 700),
          //   // curve: Curves.easeInToLinear
          //   curve: Curves.fastLinearToSlowEaseIn,
          //   // curve: Curves.fastOutSlowIn,
          // );
        },
        backgroundColor: AppColors.success,
        icon: const Icon(Icons.edit, color: Colors.white),
        label:
            const Text('Write a review', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_eshop/model/product_mode.dart';
import 'package:flutter_eshop/theme/app_colors.dart';
import 'package:flutter_eshop/theme/fonts_names.dart';
import 'package:flutter_eshop/widget/cached_network_widget.dart';
import 'package:flutter_eshop/widget/favorite_button.dart';
import 'package:flutter_eshop/widget/price_text_widget.dart';
import 'package:flutter_eshop/widget/rating_widget.dart';

class HomeItemCard extends StatelessWidget {
  const HomeItemCard({
    Key? key,
    required this.isDarkMode,
    required this.textTheme,
    required this.product,
  }) : super(key: key);

  final bool isDarkMode;
  final TextTheme textTheme;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    int getPeopleCount() => 5;

    int getRating() {
      // if (getPeopleCount() == 0) return 0;
      // return controller.products[index].rating!.values.fold<int>(
      //         0, (previousValue, element) => (previousValue + element)) ~/
      //     controller.products[index].rating!.length;
      return 4;
    }

    return SizedBox(
      height: 200,
      child: Card(
        elevation: 5,
        color: isDarkMode ? AppColors.blackDark : AppColors.backgroundLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkWidget(
                  url: product.images![0],
                  height: 190,
                  width: 200,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingWidget(
                        rated: getRating(),
                        peopleCount: getPeopleCount(),
                      ),
                      Text(
                        product.brand!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: FontsName.regular,
                          fontSize: 14,
                          color: Colors.grey,
                          letterSpacing: -.3,
                        ),
                      ),
                      Text(
                        product.name!,
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          fontFamily: FontsName.bold,
                          fontSize: 14,
                          color: isDarkMode ? Colors.white : Colors.black,
                          letterSpacing: -1.1,
                        ),
                      ),
                      PriceText(
                        context: context,
                        oldP: product.oldPrice,
                        newP: product.newPrice,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 156,
              right: -4,
              child: FavoriteButton(id: product.id.toString()),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color:
                      // ? AppColors.blackDark
                      // :
                      AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "New",
                  // controller.products[index].discount != 0
                  //     ? "-20%"
                  //     : " New ",
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

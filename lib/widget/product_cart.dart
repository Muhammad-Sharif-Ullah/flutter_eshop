import 'package:flutter/material.dart';
import 'package:flutter_eshop/theme/app_colors.dart';
import 'package:flutter_eshop/widget/favorite_button.dart';
import 'package:flutter_eshop/widget/price_text_widget.dart';
import 'package:flutter_eshop/widget/rating_widget.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.index,
    Key? key,
  }) : super(key: key);
  final int index;

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

    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      width: 200,
      // height: 350,
      padding: const EdgeInsets.only(right: 8.0),
      child: Card(
        elevation: 5,
        color: isDarkMode ? AppColors.blackDark : AppColors.backgroundLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CachedNetworkWidget(
                //   url: controller.products[index].images!.first,
                //   height: 184,
                //   width: 200,
                // ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.asset(
                    "assets/images/banner1.jpg",
                    height: 184,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 15, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingWidget(
                        rated: getRating(),
                        peopleCount: getPeopleCount(),
                      ),
                      Text("Brand Name",
                          //'${product.brand}'
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.caption?.copyWith(
                              color: Colors.grey, letterSpacing: -.3)),
                      Text("Product Name",
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.subtitle1
                              ?.copyWith(letterSpacing: -.5)),
                      PriceText(context: context, oldP: "20.5", newP: "15.5"),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 156,
              right: -3,
              child: FavoriteButton(id: index.toString()),
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


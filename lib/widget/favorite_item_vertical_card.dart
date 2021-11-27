import 'package:flutter/material.dart';
import 'package:flutter_eshop/theme/app_colors.dart';
import 'package:flutter_eshop/theme/fonts_names.dart';
import 'package:flutter_eshop/widget/favorite_button.dart';
import 'package:flutter_eshop/widget/price_text_widget.dart';
import 'package:flutter_eshop/widget/rating_widget.dart';

class FavoriteItemVerticalCard extends StatelessWidget {
  const FavoriteItemVerticalCard({
    Key? key,
    required this.isDarkMode,
    required this.textTheme,
  }) : super(key: key);

  final bool isDarkMode;
  final TextTheme textTheme;

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

    return Card(
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
                    const Text(
                      "Brand Name",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: FontsName.regular,
                        fontSize: 14,
                        color: Colors.grey,
                        letterSpacing: -.3,
                      ),
                    ),
                    // style: textTheme.caption?.copyWith(
                    //     color: Colors.grey, letterSpacing: -.3)),
                    const Text(
                      "Product Type",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: FontsName.bold,
                        fontSize: 16,
                        color: Colors.black,
                        letterSpacing: -.8,
                      ),
                      // style:
                      //     textTheme.subtitle1?.copyWith(letterSpacing: -.5),
                    ),
                    RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                          text: "Colors: ",
                          style: TextStyle(
                            fontFamily: FontsName.regular,
                            fontSize: 14,
                            color: Colors.grey,
                            letterSpacing: -.8,
                          ),
                        ),
                        TextSpan(
                          text: "Blue\t\t",
                          style: TextStyle(
                            fontFamily: FontsName.regular,
                            fontSize: 14,
                            color: Colors.black,
                            letterSpacing: -.8,
                          ),
                        ),
                        TextSpan(
                          text: "Size: ",
                          style: TextStyle(
                            fontFamily: FontsName.regular,
                            fontSize: 14,
                            color: Colors.grey,
                            letterSpacing: -.8,
                          ),
                        ),
                        TextSpan(
                          text: "L",
                          style: TextStyle(
                            fontFamily: FontsName.regular,
                            fontSize: 14,
                            color: Colors.black,
                            letterSpacing: -.8,
                          ),
                        ),
                      ]),
                    ),

                    PriceText(
                      context: context,
                      oldP: "20.5",
                      newP: "15.5",
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 156,
            right: -3,
            child: FavoriteButton(id: 1.toString()),
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
          const Positioned(
            right: 10,
            top: 10,
            child: InkWell(
              child: Icon(Icons.close, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_eshop/model/product_mode.dart';
import 'package:flutter_eshop/provider/account_provider.dart';
import 'package:flutter_eshop/theme/app_colors.dart';
import 'package:flutter_eshop/theme/fonts_names.dart';
import 'package:flutter_eshop/widget/cached_network_widget.dart';
import 'package:flutter_eshop/widget/rating_widget.dart';
import 'package:provider/src/provider.dart';

class FavoriteItemHozontalCard extends StatelessWidget {
  const FavoriteItemHozontalCard({
    required this.isDarkMode,
    required this.textTheme,
    required this.product,
    Key? key,
  }) : super(key: key);

  final bool isDarkMode;
  final TextTheme textTheme;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    int getRating() => 4;
    // product.rating!.values.fold<int>(
    //     0, (previousValue, element) => (previousValue + element)) ~/
    // product.rating!.length;
    int getPeopleCount() => 3; //product.rating!.length;

    return Stack(
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
          color: isDarkMode ? AppColors.blackDark : Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: CachedNetworkWidget(
                  url: product.images!.first,
                  height: 130,
                  width: 200,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Text(
                    //   "Product Brand Name",
                    //   style: textTheme.bodyText1
                    //       ?.copyWith(color: AppColors.grey, fontSize: 15),
                    // ),
                    Text(
                      "${product.brand}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: FontsName.regular,
                        fontSize: 14,
                        color: Colors.grey,
                        letterSpacing: -.3,
                      ),
                    ),
                    Text(
                      "${product.category}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: FontsName.bold,
                        fontSize: 16,
                        color: isDarkMode ? Colors.white : Colors.black,
                        letterSpacing: -.8,
                      ),
                      // style:
                      //     textTheme.subtitle1?.copyWith(letterSpacing: -.5),
                    ),
                    // RichText(
                    //   text: const TextSpan(children: [
                    //     TextSpan(
                    //       text: "Colors: ",
                    //       style: TextStyle(
                    //         fontFamily: FontsName.regular,
                    //         fontSize: 14,
                    //         color: Colors.grey,
                    //         letterSpacing: -.8,
                    //       ),
                    //     ),
                    //     TextSpan(
                    //       text: "Blue\t\t",
                    //       style: TextStyle(
                    //         fontFamily: FontsName.regular,
                    //         fontSize: 14,
                    //         color: Colors.black,
                    //         letterSpacing: -.8,
                    //       ),
                    //     ),
                    //     TextSpan(
                    //       text: "Size: ",
                    //       style: TextStyle(
                    //         fontFamily: FontsName.regular,
                    //         fontSize: 14,
                    //         color: Colors.grey,
                    //         letterSpacing: -.8,
                    //       ),
                    //     ),
                    //     TextSpan(
                    //       text: "L",
                    //       style: TextStyle(
                    //         fontFamily: FontsName.regular,
                    //         fontSize: 14,
                    //         color: Colors.black,
                    //         letterSpacing: -.8,
                    //       ),
                    //     ),
                    //   ]),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '20.0\$',
                          style: textTheme.subtitle1
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 4),
                        RatingWidget(
                          rated: getRating(),
                          peopleCount: getPeopleCount(),
                        ),
                        const Spacer(flex: 2),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: InkWell(
            child: const Icon(Icons.close, color: Colors.red),
            onTap: () => context.read<AccountProvider>().removeFromFavorite(product.id!),
          ),
        ),
        
      ],
    );
  }

  getColor(bool isDarkMode) {
    return isDarkMode ? Colors.white : Colors.black;
  }
}

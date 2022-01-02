import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_eshop/model/beg_model.dart';
import 'package:flutter_eshop/provider/account_provider.dart';
import 'package:flutter_eshop/theme/app_colors.dart';
import 'package:flutter_eshop/theme/fonts_names.dart';
import 'package:flutter_eshop/utils/show_snackbar.dart';
import 'package:flutter_eshop/widget/cached_network_widget.dart';
import 'package:provider/src/provider.dart';

class BegCart extends StatelessWidget {
  const BegCart({
    required this.isDarkMode,
    required this.textTheme,
    required this.product,
    required this.index,
    Key? key,
  }) : super(key: key);

  final bool isDarkMode;
  final TextTheme textTheme;
  final BegModel product;
  final int index;

  @override
  Widget build(BuildContext context) {
    final int? amount = context.watch<AccountProvider>().begs[index].quantity;
    final String? price = context.watch<AccountProvider>().begs[index].price;
    Future<int> originalQuantity = context
        .read<AccountProvider>()
        .getOriginalQuantity(context.watch<AccountProvider>().begs[index].id!)
        .first;
    Future<double> originalPrice = context
        .read<AccountProvider>()
        .getOriginalPrice(context.watch<AccountProvider>().begs[index].id!)
        .first;

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
                  url: product.image!,
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
                      // "$item.brand}",
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
                      // "$item.brand}",
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
                    RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                          text: "Colors: ",
                          style: TextStyle(
                            fontFamily: FontsName.regular,
                            fontSize: 14,
                            color: Colors.grey,
                            letterSpacing: -.8,
                          ),
                        ),
                        TextSpan(
                          text: "${product.color}\t\t",
                          style: TextStyle(
                            fontFamily: FontsName.regular,
                            fontSize: 14,
                            color: isDarkMode ? Colors.white : Colors.black,
                            letterSpacing: -.8,
                          ),
                        ),
                        const TextSpan(
                          text: "Size: ",
                          style: TextStyle(
                            fontFamily: FontsName.regular,
                            fontSize: 14,
                            color: Colors.grey,
                            letterSpacing: -.8,
                          ),
                        ),
                        TextSpan(
                          text: "${product.size}",
                          style: TextStyle(
                            fontFamily: FontsName.regular,
                            fontSize: 14,
                            color: isDarkMode ? Colors.white : Colors.black,
                            letterSpacing: -.8,
                          ),
                        ),
                      ]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FloatingActionButton(
                          onPressed: () async {
                            double oP =
                                await originalPrice.then((value) => value);
                            if (amount! > 1) {
                              int updateA = amount - 1;
                              context
                                  .read<AccountProvider>()
                                  .updatePriceAndQuantity(
                                    updateA,
                                    context
                                        .read<AccountProvider>()
                                        .begs[index]
                                        .id!,
                                    (oP * updateA).toStringAsPrecision(2),
                                  );
                            }
                          },
                          mini: true,
                          heroTag: "Increment ${product.id}",
                          child: Icon(
                            Icons.remove,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text('$amount',
                              style: textTheme.caption
                                  ?.copyWith(fontWeight: FontWeight.w400)),
                        ),
                        FloatingActionButton(
                          onPressed: () async {
                            double oP =
                                await originalPrice.then((value) => value);
                            int oQ =
                                await originalQuantity.then((value) => value);
                            if (amount! < oQ) {
                              int updateA = amount + 1;
                              context
                                  .read<AccountProvider>()
                                  .updatePriceAndQuantity(
                                    updateA,
                                    context
                                        .read<AccountProvider>()
                                        .begs[index]
                                        .id!,
                                    (oP * updateA).toStringAsPrecision(2),
                                  );
                            } else {
                              showSnack(
                                context,
                                "You have already reach max amount",
                                Colors.yellow[50]!,
                                textColor: Colors.black,
                              );
                            }
                          },
                          mini: true,
                          heroTag: "Increment ${product.id}",
                          child: Icon(Icons.add,
                              color: isDarkMode ? Colors.white : Colors.black),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text('${double.parse(price!)}\$',
                              style: textTheme.caption),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 12,
          top: 13,
          child: InkWell(
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.close, color: Colors.red),
            ),
            onTap: () =>
                context.read<AccountProvider>().deleteItemFromBeg(product.id!),
          ),
        ),
      ],
    );
  }

  getColor(bool isDarkMode) {
    return isDarkMode ? Colors.white : Colors.black;
  }
}

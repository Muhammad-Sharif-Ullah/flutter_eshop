import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eshop/provider/product_details_provider.dart';
import 'package:flutter_eshop/theme/app_colors.dart';
import 'package:flutter_eshop/widget/favorite_button.dart';
import 'package:provider/provider.dart';

class SelectSizeColor extends StatelessWidget {
  const SelectSizeColor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    
    final ProductDetailsProvider prodWatchProvider =
        context.watch<ProductDetailsProvider>();
    final TextTheme textTheme = Theme.of(context).textTheme;


    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        OutlinedButton.icon(
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return Container(
                  height: height * .3,
                  padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                  decoration: BoxDecoration(
                    color: !isDarkMode
                        ? AppColors.backgroundLight
                        : AppColors.backgroundDark,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Select Size",
                        style: textTheme.headline5?.copyWith(
                            color: isDarkMode
                                ? AppColors.backgroundLight
                                : AppColors.backgroundDark),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Wrap(
                            runSpacing: 10,
                            spacing: 15,
                            children: prodWatchProvider.product.sizes!.map(
                              (size) {
                                return OutlinedButton(
                                  onPressed: () {
                                    prodWatchProvider.sizeSelected = size;
                                  },
                                  child: Text(size),
                                  style: OutlinedButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor:
                                        prodWatchProvider.sizeSelected == size
                                            ? AppColors.primary
                                            : isDarkMode
                                                ? AppColors.backgroundDark
                                                : Colors.grey[400],
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Close',
                            ),
                            style: OutlinedButton.styleFrom(
                              primary: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              },
            );
          },
          style: OutlinedButton.styleFrom(
            primary: isDarkMode ? Colors.white : Colors.black,
          ),
          icon: const Icon(Icons.keyboard_arrow_down),
          label: const Text("Select Size"),
        ),
        // buildOutlinedButton('Size', Icons.keyboard_arrow_down, () {
        //   buildBottomSheet(
        //     context,
        //     prodWatchProvider.product!.sizes!,
        //     "Select Size",
        //     prodWatchProvider.sizeSelected,
        //     height,
        //     isDarkMode,
        //     textTheme,
        //     false,
        //     prodWatchProvider,
        //   );
        // }, isDarkMode),
        buildOutlinedButton('Color', Icons.keyboard_arrow_down, () {
          buildBottomSheet(
            context,
            prodWatchProvider.product.colors!,
            "Select Colors",
            prodWatchProvider.colorSelected,
            height,
            isDarkMode,
            textTheme,
            true,
            prodWatchProvider,
          );
        }, isDarkMode),
        FavoriteButton(id: context.read<ProductDetailsProvider>().product.id!),
      ],
    );
  }

  OutlinedButton buildOutlinedButton(
    String name,
    IconData icon,
    VoidCallback onTap,
    bool isDarkMode,
  ) {
    return OutlinedButton.icon(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        primary: isDarkMode ? Colors.white : Colors.black,
      ),
      icon: const Icon(Icons.keyboard_arrow_down),
      label: Text(name),
    );
  }

  Future<dynamic> buildBottomSheet(
      BuildContext context,
      List<String> perameter,
      String title,
      String value,
      double height,
      bool isDarkMode,
      TextTheme textTheme,
      bool isColor,
      ProductDetailsProvider provider) {
    final double contentHeight =
        perameter.length < 10 ? height * .3 : height * .45;

    getBgColor(String value) {
      if ((isColor ? provider.colorSelected : provider.sizeSelected) == value) {
        return AppColors.primary;
      }
    }

    getPrimaryColor(String value, bool isDarkMode) {
      // if(rxValue.value == value) return AppColors.primary;
      if (isDarkMode &&
          ((isColor ? provider.colorSelected : provider.sizeSelected) ==
              value)) {
        return Colors.white;
      } else if (!isDarkMode &&
          ((isColor ? provider.colorSelected : provider.sizeSelected) ==
              value)) {
        return Colors.white;
      } else if (isDarkMode &&
          ((isColor ? provider.colorSelected : provider.sizeSelected) !=
              value)) {
        return Colors.white;
      }
      return Colors.black;
    }

    return showModalBottomSheet(
      context: context,
      elevation: 10,
      // backgroundColor: ,
      builder: (context) {
        return Container(
          height: contentHeight,
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          decoration: BoxDecoration(
            color: !isDarkMode
                ? AppColors.backgroundLight
                : AppColors.backgroundDark,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Column(
            children: [
              Text(
                title,
                style: textTheme.headline5?.copyWith(
                    color: isDarkMode
                        ? AppColors.backgroundLight
                        : AppColors.backgroundDark),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Consumer(
                    builder: (cntx, pro, child) => Wrap(
                      runSpacing: 10,
                      spacing: 15,
                      children: [
                        for (int i = 0; i < perameter.length; i++)
                          OutlinedButton(
                            onPressed: () {
                              print.call("B ${provider.colorSelected}");
                              isColor
                                  ? provider.changeSize(perameter[i])
                                  : provider.changeSize(perameter[i]);
                              print.call("A ${provider.colorSelected}");
                            },
                            child: Text(perameter[i].toString()),
                            style: OutlinedButton.styleFrom(
                              primary:
                                  getPrimaryColor(perameter[i], isDarkMode),
                              backgroundColor: getBgColor(
                                perameter[i],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Close',
                    ),
                    style: OutlinedButton.styleFrom(
                      primary: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }
}

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
    // final ProductDetailsProvider prodReadProvider =
    //     context.read<ProductDetailsProvider>();
    // final ProductDetailsProvider prodWatchProvider =
    //     context.watch<ProductDetailsProvider>();
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SelectionButton(
          height: height,
          isDarkMode: isDarkMode,
          textTheme: textTheme,
          isColorButton: false,
          selectionItems: context.read<ProductDetailsProvider>().product.sizes!,
        ),
        SelectionButton(
          height: height,
          isDarkMode: isDarkMode,
          textTheme: textTheme,
          isColorButton: true,
          selectionItems:
              context.read<ProductDetailsProvider>().product.colors!,
        ),
        FavoriteButton(id: context.read<ProductDetailsProvider>().product.id!),
      ],
    );
  }
}

class SelectionButton extends StatelessWidget {
  const SelectionButton({
    Key? key,
    required this.height,
    required this.isDarkMode,
    required this.textTheme,
    required this.isColorButton,
    required this.selectionItems,
  }) : super(key: key);

  final double height;
  final bool isDarkMode;
  final TextTheme textTheme;
  final bool isColorButton;
  final List<String> selectionItems;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return Container(
              height: selectionItems.length < 10 ? height * .25 : height * .45,
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
                    isColorButton ? "Select Color" : "Select Size",
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
                        children: selectionItems.map(
                          (currentValue) {
                            return OutlinedButton(
                              onPressed: () {
                                if (isColorButton) {
                                  context
                                      .read<ProductDetailsProvider>()
                                      .changeColor(currentValue);
                                } else {
                                  context
                                      .read<ProductDetailsProvider>()
                                      .changeSize(currentValue);
                                }
                              },
                              child: Text(currentValue),
                              style: OutlinedButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: currentValue ==
                                        (isColorButton
                                            ? context
                                                .watch<ProductDetailsProvider>()
                                                .colorSelected
                                            : context
                                                .watch<ProductDetailsProvider>()
                                                .sizeSelected)
                                    ? AppColors.primary
                                    : isDarkMode
                                        ? AppColors.backgroundDark
                                        : Colors.grey[600],
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
      label: Text(
        isColorButton ? "Select Color" : "Select Size",
      ),
    );
  }
}

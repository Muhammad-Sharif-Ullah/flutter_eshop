import 'package:flutter/material.dart';
import 'package:flutter_eshop/theme/app_colors.dart';
import 'package:flutter_eshop/theme/fonts_names.dart';
import 'package:flutter_eshop/theme/nab_icon_icons.dart';
import 'package:flutter_eshop/widget/rating_widget.dart';

class FavoriteItemHozontalCard extends StatelessWidget {
  const FavoriteItemHozontalCard({
    required this.isDarkMode,
    required this.textTheme,
    Key? key,
  }) : super(key: key);

  final bool isDarkMode;
  final TextTheme textTheme;

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
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: Image.asset(
                    "assets/images/banner1.jpg",
                    width: 200,
                    height: 130,
                    fit: BoxFit.cover,
                  ),
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
                    Text(
                      "Product Type",
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
        const Positioned(
          right: 10,
          top: 10,
          child: InkWell(
            child: Icon(Icons.close, color: Colors.red),
          ),
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: InkWell(
            child: FloatingActionButton(
              onPressed: () {},
              child: const Icon(NabIcon.bagNofill, color: Colors.white),
              mini: true,
              backgroundColor: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  getColor(bool isDarkMode) {
    return isDarkMode ? Colors.white : Colors.black;
  }
}

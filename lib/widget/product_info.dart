import 'package:flutter/material.dart';
import 'package:flutter_eshop/widget/rating_widget.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo(
      {Key? key,
      required this.brand,
      required this.prodType,
      required this.shortInfo,
      required this.price,
      required this.rating})
      : super(key: key);
  final String brand;
  final String prodType;
  final String shortInfo;
  final double price;
  final Map<String, int> rating;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    int getRating() {
      if (rating.isEmpty) return 0;
      return rating.values.fold<int>(
              0, (previousValue, element) => (previousValue + element)) ~/
          rating.length;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                text: brand,
                style: textTheme.headline2
                    ?.copyWith(letterSpacing: -1, wordSpacing: -1),
                children: [
                  TextSpan(
                    text: '\n$prodType',
                    style: textTheme.subtitle1?.copyWith(
                        color: Colors.grey, letterSpacing: -1, wordSpacing: -1),
                  ),
                ],
              ),
            ),
            Text(
              "\$$price",
              style: textTheme.headline2,
            ),
          ],
        ),
        RatingWidget(rated: getRating(), peopleCount: rating.length),
        const SizedBox(height: 20),
        Text(shortInfo),
        const SizedBox(height: 20),
      ],
    );
  }
}

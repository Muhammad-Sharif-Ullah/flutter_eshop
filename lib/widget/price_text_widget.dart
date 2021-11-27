import 'package:flutter/material.dart';
import 'package:flutter_eshop/theme/app_colors.dart';

class PriceText extends StatelessWidget {
  const PriceText({
    Key? key,
    required this.context,
    required this.oldP,
    required this.newP,
  }) : super(key: key);

  final BuildContext context;
  final String? oldP;
  final String? newP;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    var priceCount = Text.rich(
      TextSpan(
        style: textTheme.subtitle1
            ?.copyWith(color: Colors.grey, letterSpacing: -.5),
        children: [
          if (oldP != "0")
            TextSpan(
                text: '$oldP\$',
                style: const TextStyle(decoration: TextDecoration.lineThrough)),
          TextSpan(
            text: oldP != "0" ? '  $newP\$' : '$newP\$',
            style: textTheme.subtitle1?.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
    return priceCount;
  }
}

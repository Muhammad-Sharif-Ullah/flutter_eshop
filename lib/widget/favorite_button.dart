

import 'package:flutter/material.dart';
import 'package:flutter_eshop/theme/app_colors.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return FloatingActionButton(
      onPressed: () {
        // if (acnCNT.favoritesId.contains(id)) {
        //   FireBaseCollection.removeFromFavorite(id);
        // } else {
        //   FireBaseCollection.addToMyFavorites(id);
        // }
      },
      heroTag: id,
      child: const Icon(Icons.favorite, color: AppColors.primary),
      // child: GetX(
      //   builder: (AccountServiceController acsCNT) {
      //     Icon icon = acsCNT.favoritesId.contains(id)
      //         ? Icon(Icons.favorite, color: AppColors.primary)
      //         : Icon(Icons.favorite_outline_outlined, color: AppColors.grey);
      //     return icon;

      //   },
      // ),
      backgroundColor:
      isDarkMode ? AppColors.blackDark : AppColors.backgroundLight,
      mini: true,
    );
  }
}

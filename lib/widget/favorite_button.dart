import 'package:flutter/material.dart';
import 'package:flutter_eshop/provider/account_provider.dart';
import 'package:flutter_eshop/theme/app_colors.dart';
import 'package:provider/provider.dart';

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
      onPressed: () => context.read<AccountProvider>().addOrRemoveFavorite(id),
      heroTag: id,
      child: context.watch<AccountProvider>().favoriteIds.contains(id)
          ? const Icon(Icons.favorite, color: AppColors.primary)
          : const Icon(Icons.favorite_outline_outlined, color: AppColors.grey),
      backgroundColor:
          isDarkMode ? AppColors.blackDark : AppColors.backgroundLight,
      mini: true,
    );
  }
}

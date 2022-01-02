import 'package:flutter/material.dart';
import 'package:flutter_eshop/model/product_mode.dart';
import 'package:flutter_eshop/provider/account_provider.dart';
import 'package:flutter_eshop/theme/app_colors.dart';
import 'package:flutter_eshop/theme/app_constant.dart';
import 'package:flutter_eshop/widget/bottom_nav_widget.dart';
import 'package:flutter_eshop/widget/favorite_item_horizontal_card.dart';
import 'package:flutter_eshop/widget/favorite_item_vertical_card.dart';
import 'package:provider/provider.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    final TextTheme textTheme = Theme.of(context).textTheme;

    getColorWhiteR() =>
        isDarkMode ? AppColors.white : AppColors.backgroundLight;
    getColor() => isDarkMode ? AppColors.white : AppColors.blackLight;
    getBTNSTYLE() => TextButton.styleFrom(primary: getColor());
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const CustomBottomNavigator(),
      body: SafeArea(
        child: SizedBox(
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                color: isDarkMode
                    ? AppColors.backgroundDark
                    : AppColors.backgroundLight,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstant.kPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * .01),
                      Text(
                        'Favorites',
                        style: textTheme.headline1,
                      ),
                      SizedBox(height: height * .01),
                      SizedBox(
                        height: 35,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: getColorWhiteR(),
                                ),
                                child: Text(
                                  'Content $index',
                                  style: textTheme.subtitle1
                                      ?.copyWith(color: AppColors.blackLight),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: height * .01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextButton.icon(
                              onPressed: () {},
                              icon: const Text("Filter"),
                              label: const Icon(Icons.filter_list_rounded),
                              style: getBTNSTYLE(),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: TextButton.icon(
                              onPressed: () {},
                              icon: const Text("Price: Lowest to high"),
                              label:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                              style: getBTNSTYLE(),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: InkWell(
                                child: context
                                            .watch<AccountProvider>()
                                            .isListView ==
                                        true
                                    ? const Icon(Icons.list_outlined)
                                    : const Icon(Icons.grid_view),
                                onTap: () => context
                                    .read<AccountProvider>()
                                    .toggleListView(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * .01,
              ),
              Expanded(
                child: FutureBuilder<List<ProductModel>>(
                    future: context.read<AccountProvider>().favoritesList(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("${snapshot.error}"));
                      } else if (!snapshot.hasData) {
                        return const Center(
                            child: Text("No item in your favorite list"));
                      }
                      // print.call("######## ${snapshot.data}");
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstant.kPadding,
                        ),
                        child: context.watch<AccountProvider>().isListView
                            ? _buildListView(
                                isDarkMode, textTheme, context, snapshot.data!)
                            : _buildGridView(
                                isDarkMode, textTheme, context, snapshot.data!),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridView(
    bool isDarkMode,
    TextTheme textTheme,
    BuildContext context,
    List<ProductModel> product,
  ) {
    // print.call("------------ ${product.length}");
    return GridView.builder(
      itemCount: context.watch<AccountProvider>().favoriteIds.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 285,
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
      ),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, int index) {
        return InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(10),
          child: FavoriteItemVerticalCard(
            isDarkMode: isDarkMode,
            textTheme: textTheme,
            product: product[index],
          ),
        );
      },
    );
  }

  Widget _buildListView(
    bool isDarkMode,
    TextTheme textTheme,
    BuildContext context,
    List<ProductModel> product,
  ) {
    return ListView.builder(
      itemCount: context.watch<AccountProvider>().favoriteIds.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, int index) {
        return InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(10),
          child: FavoriteItemHozontalCard(
            isDarkMode: isDarkMode,
            textTheme: textTheme,
            product: product[index],
          ),
        );
      },
    );
  }

  // Widget buildGridView() {
  //   return FutureBuilder<List<ProductModel?>>(
  //       future: controller.favoritesList(),
  //       builder: (context, AsyncSnapshot snapshot) {
  //         if (snapshot.hasError) {
  //           return const Text('Something went wrong');
  //         } else if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const Text("Loading");
  //         }
  //         final List<ProductModel?> favoriteList = snapshot.data;
  //         if (favoriteList.isEmpty)
  //           return Center(
  //               child: Text(
  //             'You have no Item in your favorite list',
  //             style: context.textTheme.caption,
  //           ));
  //         return GridView.builder(
  //             physics: BouncingScrollPhysics(),
  //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                 crossAxisCount: 2, mainAxisExtent: 300, mainAxisSpacing: 10),
  //             itemCount: favoriteList.length,
  //             itemBuilder: (context, index) {
  //               return FavoriteGridCard(product: favoriteList[index]!);
  //             });
  //       });
  // }

  // Widget _buildListView() {
  //   return FutureBuilder<List<ProductModel?>>(
  //     future: controller.favoritesList(),
  //     builder: (context, AsyncSnapshot snapshot) {
  //       if (snapshot.hasError) {
  //         return Text('Something went wrong');
  //       } else if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Text("Loading");
  //       }
  //       final List<ProductModel?> favoriteList = snapshot.data;
  //       if (favoriteList.isEmpty)
  //         return Center(
  //             child: Text(
  //           'You have no Item in your favorite list',
  //           style: context.textTheme.caption,
  //         ));
  //       return ListView.builder(
  //           itemCount: favoriteList.length,
  //           physics: BouncingScrollPhysics(),
  //           itemBuilder: (context, index) {
  //             return FavoriteListCard(product: favoriteList[index]!);
  //           });
  //     },
  //   );
  // }
}

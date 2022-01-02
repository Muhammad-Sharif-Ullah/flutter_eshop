import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eshop/data/slider_data.dart';
import 'package:flutter_eshop/model/product_mode.dart';
import 'package:flutter_eshop/provider/product_details_provider.dart';
import 'package:flutter_eshop/routes/app_pages.dart';
import 'package:flutter_eshop/widget/bottom_nav_widget.dart';
import 'package:flutter_eshop/widget/carousel_widget.dart';
import 'package:flutter_eshop/widget/home_item_card.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double height = size.height;
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const CustomBottomNavigator(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TopSlider(sliderItems: allBaners),
            ),
            SizedBox(height: height * .01),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: StreamBuilder<List<ProductModel>>(
                  stream: getProductData(),
                  builder:
                      (context, AsyncSnapshot<List<ProductModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      return HomeGrideView(
                        isDarkMode: isDarkMode,
                        textTheme: textTheme,
                        products: snapshot.data!,
                      );
                    } else if (snapshot.data == null) {
                      return Center(
                        child: Text("No Data Found",
                            style: Theme.of(context).textTheme.bodyText2),
                      );
                    }
                    return Center(
                      child: Text("Faild To Load Data",
                          style: Theme.of(context).textTheme.bodyText2),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stream<List<ProductModel>> getProductData() {
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    return fireStore.collection('products').snapshots().map((query) {
      return query.docs.map((product) {
        return ProductModel.fromJson(product.data());
      }).toList();
    });
  }
}

class HomeGrideView extends StatelessWidget {
  const HomeGrideView({
    Key? key,
    required this.isDarkMode,
    required this.textTheme,
    required this.products,
  }) : super(key: key);

  final bool isDarkMode;
  final TextTheme textTheme;
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 300,
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
      ),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, int index) {
        return InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            context.read<ProductDetailsProvider>().defineProvider(
                  prod: products[index],
                  color: products[index].colors!.first,
                  size: products[index].sizes!.first,
                );
            Navigator.pushNamed(
              context,
              AppRoutes.productDetails,
            );
          },
          child: HomeItemCard(
            isDarkMode: isDarkMode,
            textTheme: textTheme,
            product: products[index],
          ),
        );
      },
    );
  }
}

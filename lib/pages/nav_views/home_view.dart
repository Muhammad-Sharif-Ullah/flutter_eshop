import 'package:flutter/material.dart';
import 'package:flutter_eshop/data/slider_data.dart';
import 'package:flutter_eshop/widget/bottom_nav_widget.dart';
import 'package:flutter_eshop/widget/carousel_widget.dart';
import 'package:flutter_eshop/widget/home_item_card.dart';

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
                child: GridView.builder(
                  itemCount: 12,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 300,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 5,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, int index) {
                    return InkWell(
                      onTap: () {},
                      child: HomeItemCard(
                        isDarkMode: isDarkMode,
                        textTheme: textTheme,
                      ),
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
}

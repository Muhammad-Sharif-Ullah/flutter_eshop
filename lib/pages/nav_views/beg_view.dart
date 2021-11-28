import 'package:flutter/material.dart';
import 'package:flutter_eshop/theme/app_colors.dart';
import 'package:flutter_eshop/theme/app_constant.dart';
import 'package:flutter_eshop/widget/big_splash_button.dart';
import 'package:flutter_eshop/widget/bottom_nav_widget.dart';

class BegView extends StatelessWidget {
  const BegView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final Size size = MediaQuery.of(context).size;

    final double height = size.height;
    final double width = size.width;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Text("My Beg", style: textTheme.headline2),
          elevation: 10,
          backgroundColor:
              isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight,
        ),
        bottomNavigationBar: const CustomBottomNavigator(),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Material(
              //   color: isDarkMode
              //       ? AppColors.backgroundDark
              //       : AppColors.backgroundLight,
              //   elevation: 10,
              //   child: SizedBox(
              //     width: width,
              //     child: Padding(
              //       padding: const EdgeInsets.only(
              //         left: AppConstant.kPadding,
              //         right: 8,
              //         bottom: 8,
              //       ),
              //       child: Text(
              //         'My Bag',
              //         style: textTheme.headline2,
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 5),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstant.kPadding),
                  child: buildObx(context, textTheme),
                ),
              ),
              ...totalListWidget(context, textTheme, width),
            ],
          ),
        ));
  }

  Widget buildObx(BuildContext context, TextTheme textTheme) {
    // controller.total.value = controller.getTotalPrice();
    if ("".isEmpty) {
      return Center(
          child: Text(
        'You have no Item in your beg',
        style: textTheme.caption,
      ));
    }
    return ListView.builder(
        itemCount: 2,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, int index) {
          return Container(color: Colors.red);
        });
  }

  List<Widget> totalListWidget(
      BuildContext context, TextTheme textTheme, double width) {
    return [
      0.0 == 0.0
          ? Container()
          : const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
              child: Divider(
                thickness: 3,
              ),
            ),
      0.0 == 0.0
          ? Container()
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Amount', style: textTheme.subtitle2),
                  Text(
                    '100.0\$',
                    style: textTheme.headline3,
                  ),
                ],
              ),
            ),
      const SizedBox(height: 24),
      10.0 == 0.0
          ? Container()
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
              child: BigSplashButton(
                  height: 48,
                  width: width,
                  text: "CHECK OUT",
                  onPressed: () {}),
            ),
      const SizedBox(height: 14)
    ];
  }
}

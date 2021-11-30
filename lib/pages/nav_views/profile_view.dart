import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eshop/provider/account_provider.dart';
import 'package:flutter_eshop/routes/app_pages.dart';
import 'package:flutter_eshop/theme/app_constant.dart';
import 'package:flutter_eshop/widget/bottom_nav_widget.dart';
import 'package:provider/provider.dart';

class ProfleView extends StatelessWidget {
  const ProfleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AccountProvider>().currentUser;
    // return const Scaffold(
    //   extendBody: true,
    //   bottomNavigationBar:CustomBottomNavigator(),

    //   body: SafeArea(child: Center(child: Text("Profle View"))),
    // );
    // final Size size = MediaQuery.of(context).size;
    // final double width = size.width;
    // final double height = size.height;
    final TextTheme textTheme = Theme.of(context).textTheme;
    // final bool isDarkMode =
    //     MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      // appBar: AppBar(),
      extendBody: true,
      bottomNavigationBar: const CustomBottomNavigator(),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top + 10,
              ),
              Text(
                'My Profile',
                style: textTheme.headline1,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  // Container(
                  //   padding: const EdgeInsets.all(4),
                  //   height: 60,
                  //   width: 60,
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     border: Border.all(color: Colors.greenAccent, width: 3),
                  //     image: DecorationImage
                  //   ),
                  // ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.greenAccent, width: 3),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100000000),
                      child: CachedNetworkImage(
                        imageUrl: user!.photoURL!,
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        fadeInCurve: Curves.bounceIn,
                        // progressIndicatorBuilder:
                        //     (context, url, downloadProgress) =>
                        //         const CupertinoActivityIndicator(),
                        errorWidget: (context, url, error) {
                          print.call(error);
                          return const Icon(Icons.error);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        user.displayName!,
                        style: textTheme.headline3
                            ?.copyWith(letterSpacing: -.1, wordSpacing: -1),
                      ),
                      Text(
                        user.email!,
                        style: textTheme.bodyText2?.copyWith(
                            color: Colors.grey,
                            letterSpacing: -.1,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 28),
              buildContent(
                context,
                title: 'My Order',
                text: 'Already have 12 orders',
                // onTap: () => Get.to(() => MyOrderView()),
                onTap: () {},
              ),
              buildContent(
                context,
                title: 'Shipping Address',
                text: '3 Address',
                onTap: () {},

                // onTap: () => Get.to(() => ShippingView()),
              ),
              buildContent(
                context,
                title: 'Payment Method',
                text: 'Visa **34',
                onTap: () {},

                // onTap: () => Get.to(() => PaymentView()),
              ),
              buildContent(
                context,
                title: 'Promo Codes',
                text: 'You have special promo-codes',
                onTap: () {},
              ),
              buildContent(
                context,
                title: 'My Reviews',
                text: 'Review for 4 items',
                // onTap: () => Get.to(() => MyReviewsView()),
                onTap: () {},
              ),
              buildContent(
                context,
                title: 'Settings',
                text: 'Notification and Password',
                onTap: () => Navigator.pushNamed(context, AppRoutes.settings),
                // onTap: () {},
              ),
              // onTap: () async {
              //   await FireBaseAuth.logOut();
              //   Get.offAllNamed(Routes.AUTHENTICATION);
              // },),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  ListTile buildContent(BuildContext context, {title, text, onTap}) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.subtitle2,
      ),
      subtitle: Text(text,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey)),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
      contentPadding: const EdgeInsets.all(3.0),
    );
  }
}

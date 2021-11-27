import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_eshop/model/slider_model.dart';

class TopSlider extends StatelessWidget {
  const TopSlider({
    Key? key,
    required this.sliderItems,
  }) : super(key: key);

  final List<AppBanner> sliderItems;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return CarouselSlider.builder(
      options: CarouselOptions(
        autoPlay: true,
        height: 200,
        // aspectRatio: 16 / 9,
        // aspectRatio: 2.0,
        // viewportFraction: 0.9,
        // reverse: true
        // initialPage: 2,
      ),
      itemCount: sliderItems.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Image.asset(
              sliderItems[itemIndex].image,
              fit: BoxFit.cover,
              height: 200,
            ),
            Container(
              height: 200,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black12,
                    Colors.black26,
                  ],
                  stops: [0.8, 0.9],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 20,
              child: Text(
                sliderItems[itemIndex].text,
                style: textTheme.headline1?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

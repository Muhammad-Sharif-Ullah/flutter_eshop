import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eshop/services/firebase_storage.dart';

class FutureImageWidget extends StatelessWidget {
  const FutureImageWidget({
    Key? key,
    required this.url,
    required this.height,
    required this.width,
  }) : super(key: key);

  final String url;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: height, //184
        width: width, //200
        child: buildFutureBuilder(url),
      ),
    );
  }

  FutureBuilder<String> buildFutureBuilder(String url) {
    return FutureBuilder<String>(
      future: FireBaseStorage.getDownloadLink(url),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) return buildCachedNetworkImage(snapshot);
        return const CupertinoActivityIndicator();
      },
    );
  }

  CachedNetworkImage buildCachedNetworkImage(AsyncSnapshot<dynamic> snapshot) {
    return CachedNetworkImage(
      imageUrl: snapshot.data,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          const CupertinoActivityIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}

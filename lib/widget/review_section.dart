import 'package:flutter/material.dart';
import 'package:flutter_eshop/theme/app_constant.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstant.kPadding),
      child: ExpansionTile(
        childrenPadding: const EdgeInsets.all(0),
        tilePadding: const EdgeInsets.all(0.0),
        title: const Text(
          'Rating & Reviews',
        ),
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                '13 Reviews',
                style: textTheme.caption,
              ),
            ],
          ),
          const SizedBox(height: 10),
          // ...reviews.map((review) => CommentWidget(reviews: review)).toList(),
          // buildStreamBuilder(),
          // ...controller.reviewsList.map((review) => CommentWidget(reviews: review)).toList(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // StreamBuilder<List<WriteCommentModel>> buildStreamBuilder() {
  //   final String currentUID = FirebaseAuth.instance.currentUser!.uid;

  //   return StreamBuilder<List<WriteCommentModel>>(
  //     stream: controller.reviewsAsStream(),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         // final RxList<WriteCommentModel>? data = RxList<WriteCommentModel>(snapshot.data!);
  //         // if (data!.length == 0) return Text('No Reviews');
  //         if (controller.reviewsList.length == 0) return Text('No Reviews');
  //         return Obx(() => ListView.builder(
  //             physics: const BouncingScrollPhysics(),
  //             itemCount: controller.reviewsList.length,
  //             shrinkWrap: true,
  //             itemBuilder: (context, index) {
  //               return CommentWidget(index: index, currentUID: currentUID);
  //             }));
  //       } else if (snapshot.hasError) {
  //         print.call(snapshot.error);
  //         return const Text('Error occurred. please try again');
  //       }
  //       return const Text('Loading Data');
  //     },
  //   );
  // }
}

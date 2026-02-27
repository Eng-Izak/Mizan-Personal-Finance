import 'package:flutter/material.dart';

class SubCategoryWidget extends StatelessWidget {
  const SubCategoryWidget({
    super.key,
    required this.imageUrl,
    required this.title,
  });
  final String imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        children: [
          SizedBox(width: 5),
          Image.asset(imageUrl, height: 15, width: 15),
          SizedBox(width: 5),
          Text(title),
        ],
      ),
    );
  }
}

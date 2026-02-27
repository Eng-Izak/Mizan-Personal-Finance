import 'package:flutter/material.dart';
import 'package:izak_project_mizan_app/core/theme/app_colors.dart';
import 'package:izak_project_mizan_app/core/utils/size_config.dart';

class HomeCategoryWidget extends StatelessWidget {
  const HomeCategoryWidget({
    super.key,
    required this.categoryTitle,
    required this.categoryImage,
  });

  final String categoryTitle;
  final ImageProvider categoryImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: SizeConfig.screenHeight * .14,
      width: SizeConfig.screenWidth * .95,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: kPrimaryColor3,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35,
            backgroundImage: categoryImage,
          ),
          SizedBox(width: SizeConfig.screenWidth * .1),
          Directionality(
            textDirection: TextDirection.rtl,
            child: SizedBox(
              height: SizeConfig.screenHeight * .1,
              width: SizeConfig.screenWidth * .6,
              child: Text(
                categoryTitle,
                style: TextStyle(
                  fontFamily: 'Handjet',
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:izak_project_mizan_app/core/theme/app_colors.dart';
import 'package:izak_project_mizan_app/core/utils/size_config.dart';

class ScreenMassageWidget extends StatelessWidget {
  const ScreenMassageWidget({super.key, required this.txt});

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: SizeConfig.screenHeight * .15,
      width: SizeConfig.screenWidth * .8,
      margin: EdgeInsets.only(left: 20, right: 30),
      decoration: BoxDecoration(
        color: kPrimaryColor2,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          txt,
          style: TextStyle(
            fontFamily: 'Lemonada',
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}

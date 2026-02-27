import 'package:flutter/material.dart';
import 'package:izak_project_mizan_app/core/utils/size_config.dart';

class NoInstallmentWidget extends StatelessWidget {
  const NoInstallmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "ليس لديك اى قساط بعد",
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            fontFamily: '',
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          height: SizeConfig.screenHeight * .5,
          width: SizeConfig.screenWidth * .95,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/no quest.gif"),
            ),
          ),
        ),
      ],
    );
  }
}

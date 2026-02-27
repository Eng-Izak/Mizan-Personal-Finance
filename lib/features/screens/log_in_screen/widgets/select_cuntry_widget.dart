import 'package:flutter/material.dart';
import 'package:izak_project_mizan_app/core/utils/size_config.dart';

class SelectCuntryWidget extends StatelessWidget {
  const SelectCuntryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(15),
          height: SizeConfig.screenHeight * .05,
          width: SizeConfig.screenWidth * .3,
          child: Icon(Icons.arrow_downward_outlined),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(15),
          height: SizeConfig.screenHeight * .1,
          width: SizeConfig.screenWidth * .4,
          child: Text(
            "اختر دولتك",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Readex Pro',
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}

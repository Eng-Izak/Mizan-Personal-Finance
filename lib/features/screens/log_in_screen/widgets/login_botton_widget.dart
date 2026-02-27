import 'package:flutter/material.dart';
import 'package:izak_project_mizan_app/core/theme/app_colors.dart';
import 'package:izak_project_mizan_app/core/utils/size_config.dart';

class LogInBottonWidget extends StatelessWidget {
  const LogInBottonWidget({super.key, required this.onSave});
  final void Function() onSave;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSave,
      child: Container(
        height: SizeConfig.screenHeight * .06,
        width: SizeConfig.screenWidth * .4,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kPrimaryColor4,
        ),
        child: Text(
          textAlign: TextAlign.center,
          "تسجيل دخول",
          style: TextStyle(
            fontFamily: 'Handjet',
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}

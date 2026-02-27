import 'package:flutter/material.dart';
import 'package:izak_project_mizan_app/core/theme/app_colors.dart';

class CircularIndicatorWidget extends StatelessWidget {
  const CircularIndicatorWidget({
    required this.value,
    required this.txt,
    super.key,
  });
  final String value;
  final String txt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: kPrimaryColor2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: 0.35,
                  strokeWidth: 10,
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFBDC9D1)),
                ),
              ),

              Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),

          Text(
            txt,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:izak_project_mizan_app/core/theme/app_colors.dart';
import 'package:izak_project_mizan_app/core/utils/size_config.dart';

class ExpensesCircularIndicatorWidget extends StatelessWidget {
  const ExpensesCircularIndicatorWidget({
    super.key,
    required this.income,
    required this.percentage,
  });
  final String income;
  final double percentage;
  @override
  Widget build(BuildContext context) {
    double value = double.tryParse(income) ?? 0.0;
    return Container(
      padding: EdgeInsets.all(20),
      color: Color(0xffFEF2E2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: SizeConfig.screenHeight * .15,
                height: SizeConfig.screenHeight * .15,
                child: CircularProgressIndicator(
                  value: percentage,
                  strokeWidth: 10,
                  backgroundColor: kPrimaryColor2,
                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor4),
                ),
              ),
              Positioned(
                top: 25,
                child: Text(
                  "${(100 * percentage)} %",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                child: Text(
                  (value * percentage).toString(),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

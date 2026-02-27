import 'package:flutter/material.dart';
import 'package:izak_project_mizan_app/core/utils/size_config.dart';

class ResultViewWidget extends StatelessWidget {
  const ResultViewWidget({
    super.key,
    required this.selectedCurrency,
    required this.val,
    required this.result,
  });

  final String selectedCurrency;
  final double? val;
  final double result;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: SizeConfig.screenHeight * .25,
      width: SizeConfig.screenWidth * .88,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * .07),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withAlpha(100), width: 2),
        // color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        textAlign: TextAlign.center,
        "$selectedCurrency (${val != 0.0 && val != null ? val : ""}) = \n ${result.toStringAsFixed(2)} USD",
        style: TextStyle(fontSize: 24, fontFamily: 'Readex Pro'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:izak_project_mizan_app/core/utils/size_config.dart';
import 'package:izak_project_mizan_app/features/screens/expenses_organizer_screen/widgets/expenses_circular_indicator_widget.dart';
import 'package:izak_project_mizan_app/features/screens/expenses_organizer_screen/widgets/sub_category_widget.dart';

class MainCategoryWidget extends StatelessWidget {
  const MainCategoryWidget({super.key, required this.income});
  final String income;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      scrollDirection: Axis.horizontal,
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          SizedBox(width: 10),

          Container(
            alignment: Alignment.center,
            height: SizeConfig.screenHeight * .5,
            width: SizeConfig.screenWidth * .5,
            decoration: BoxDecoration(
              color: Color(0xffFEF2E2),
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "مصروفات الاساسية الثابته",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Handjet',
                  ),
                ),
                ExpensesCircularIndicatorWidget(income: income, percentage: .5),
                SubCategoryWidget(
                  imageUrl: "assets/images/l1.png",
                  title: "فواتير الكهرباء والمياة",
                ),
                SubCategoryWidget(
                  imageUrl: "assets/images/l2.png",
                  title: "مصاريف التعليم",
                ),
                SubCategoryWidget(
                  imageUrl: "assets/images/l3.png",
                  title: "الرعاية الصحية",
                ),
                SubCategoryWidget(
                  imageUrl: "assets/images/l7.png",
                  title: "النقل",
                ),
                SubCategoryWidget(
                  imageUrl: "assets/images/l44.png",
                  title: "الاتصالات",
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Container(
            alignment: Alignment.center,
            height: SizeConfig.screenHeight * .5,
            width: SizeConfig.screenWidth * .5,
            decoration: BoxDecoration(
              color: Color(0xffFEF2E2),
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "مصروفات شخصية متغيرة",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Handjet',
                  ),
                ),
                ExpensesCircularIndicatorWidget(income: income, percentage: .3),
                SubCategoryWidget(
                  imageUrl: "assets/images/l4.png",
                  title: "التسويق",
                ),
                SubCategoryWidget(
                  imageUrl: "assets/images/l5.png",
                  title: "الانشطة الترفيهية",
                ),
                SubCategoryWidget(
                  imageUrl: "assets/images/l7.png",
                  title: "الرحلات",
                ),
                SubCategoryWidget(
                  imageUrl: "assets/images/l8.png",
                  title: "الهداية",
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Container(
            alignment: Alignment.center,
            height: SizeConfig.screenHeight * .5,
            width: SizeConfig.screenWidth * .5,
            decoration: BoxDecoration(
              color: Color(0xffFEF2E2),
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "مصروفات الاستثمار",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Handjet',
                  ),
                ),
                ExpensesCircularIndicatorWidget(income: income, percentage: .2),
                SubCategoryWidget(
                  imageUrl: "assets/images/l9.png",
                  title: "زيادة المدخرات",
                ),
                SubCategoryWidget(
                  imageUrl: "assets/images/l10.png",
                  title: "تعجيل سدادالديون",
                ),
                SubCategoryWidget(
                  imageUrl: "assets/images/l10.png",
                  title: "حالات الطوارئ",
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}

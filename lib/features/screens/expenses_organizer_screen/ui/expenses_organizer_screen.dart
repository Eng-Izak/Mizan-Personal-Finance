import 'package:flutter/material.dart';
import 'package:izak_project_mizan_app/core/theme/app_colors.dart';
import 'package:izak_project_mizan_app/core/utils/size_config.dart';
import 'package:izak_project_mizan_app/features/screens/expenses_organizer_screen/widgets/main_category_widget.dart';
import 'package:izak_project_mizan_app/features/comman_widgets/screen_massage_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpensesOrganizerScreen extends StatefulWidget {
  const ExpensesOrganizerScreen({super.key});

  @override
  State<ExpensesOrganizerScreen> createState() =>
      _ExpensesOrganizerScreenState();
}

class _ExpensesOrganizerScreenState extends State<ExpensesOrganizerScreen> {
  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  String income = "";

  Future<void> _initPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String? setIncome = prefs.getString('user_income');
    if (setIncome != null && setIncome.isNotEmpty) {
      setState(() {
        income = setIncome;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String massageContent =
        "فى هذه الصفحة يتم عرض افضل نسبة لتنظيم مصروفات من خلال مرتبك";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Text(
            "ميزان",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 36,
              fontFamily: 'Reem Kufi',
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("assets/images/logo.png"),
                ),
                SizedBox(width: 10),
              ],
            ),
            ScreenMassageWidget(txt: massageContent),
            SizedBox(height: SizeConfig.screenHeight * .03),
            Container(
              alignment: Alignment.center,
              height: SizeConfig.screenHeight * .08,
              width: SizeConfig.screenWidth * .4,
              decoration: BoxDecoration(
                color: kPrimaryColor4,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                income,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Handjet',
                ),
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * .038),

            MainCategoryWidget(income: income),
          ],
        ),
      ),
    );
  }
}

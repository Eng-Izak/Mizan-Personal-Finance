import 'package:flutter/material.dart';
import 'package:izak_project_mizan_app/features/screens/home_screen/widgets/home_category_widget.dart';
import 'package:izak_project_mizan_app/features/comman_widgets/screen_massage_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString("user_name");
    if (name != null && name.isNotEmpty) {
      setState(() {
        userName = name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String massageContent = "اهلا بك فى الميزان يا $userName";

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
            Spacer(),
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/currencyConverter'),
              child: HomeCategoryWidget(
                categoryTitle: "حساب تحويل العملات الى الدولار",
                categoryImage: AssetImage("assets/images/dolar.png"),
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/installments'),
              child: HomeCategoryWidget(
                categoryTitle: "عرض الاقساط ومواعيدها",
                categoryImage: AssetImage("assets/images/aqsat.jpg"),
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/expensesOrganizer'),
              child: HomeCategoryWidget(
                categoryTitle: "تنظيم المصروفات بالنسبة لدخلك الشهرى",
                categoryImage: AssetImage("assets/images/masrouf.png"),
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () async {
                await Navigator.pushNamed(context, '/profile');

                setState(() {
                  _initPrefs();
                });
              },
              child: HomeCategoryWidget(
                categoryTitle: "البيانات الشخصية",
                categoryImage: AssetImage("assets/images/data.jpg"),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

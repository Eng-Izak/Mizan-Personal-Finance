import 'package:flutter/material.dart';
import 'package:izak_project_mizan_app/core/theme/app_colors.dart';
import 'package:izak_project_mizan_app/core/utils/size_config.dart';
import 'package:izak_project_mizan_app/features/screens/profile_screen/widgets/circular_indicator_widget.dart';
import 'package:izak_project_mizan_app/features/screens/profile_screen/widgets/custom_change_data_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  String name = "";
  String email = "";
  String income = "";
  String balance = "";
  String country = "";
  Future<void> _initPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String? setName = prefs.getString('user_name');
    String? setEmail = prefs.getString('user_email');
    String? setIncome = prefs.getString('user_income');
    String? setBalance = prefs.getString('user_balance');
    String? setCountry = prefs.getString('user_country');
    if (setName != null &&
        setEmail != null &&
        setIncome != null &&
        setBalance != null &&
        setCountry != null &&
        setName.isNotEmpty &&
        setEmail.isNotEmpty &&
        setIncome.isNotEmpty &&
        setBalance.isNotEmpty &&
        setCountry.isNotEmpty) {
      setState(() {
        name = setName;
        email = setEmail;
        income = setIncome;
        balance = setBalance;
        country = setCountry;
      });
    }
  }

  void _changeDataDialog() async {
    // انتظر حتى يتم إغلاق الديالوج وتخزين النتيجة في المتغير results
    final result = await showDialog<bool>(
      context: context,
      builder: (context) =>
          CustomChangeDataDialog(), // الـ Widget الخاص بالديالوج
    );

    // إذا كانت النتيجة true، نقوم بتحديث الصفحة
    if (result == true) {
      setState(() {
        // هنا يمكنك إعادة جلب البيانات من قاعدة البيانات أو تحديث القائمة
        _initPrefs();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 40),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: EdgeInsets.all(SizeConfig.screenWidth * .05),
                  width: SizeConfig.screenHeight * .8,
                  height: SizeConfig.screenHeight * .75,
                  decoration: BoxDecoration(
                    color: Color(0xffBEC69F),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 70),
                      Text(name, style: TextStyle(fontSize: 22)),
                      SizedBox(height: 40),
                      Text(email, style: TextStyle(fontSize: 22)),
                      SizedBox(height: 40),
                      Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: 120,
                        decoration: BoxDecoration(
                          color: kPrimaryColor3,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(country, style: TextStyle(fontSize: 22)),
                      ),
                      SizedBox(height: 40),

                      //الجزء الخاص بعرض نسب الداخل والخارج من حساب البنك والراتب على شكل دوائر تمثل النسب لكل منهما
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularIndicatorWidget(
                            value: balance,
                            txt: "الحساب البنكى",
                          ),
                          CircularIndicatorWidget(
                            value: income,
                            txt: "الراتب الشهرى",
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      InkWell(
                        onTap: _changeDataDialog,
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Text(
                            "تعديل",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -40,
                  left: SizeConfig.screenHeight * .16,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Color(0xffBEC69F),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("assets/images/slogan.gif"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

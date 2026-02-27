import 'package:flutter/material.dart';
import 'package:izak_project_mizan_app/core/constants/app_constants.dart';
import 'package:izak_project_mizan_app/core/theme/app_colors.dart';
import 'package:izak_project_mizan_app/core/utils/size_config.dart';
import 'package:izak_project_mizan_app/features/screens/home_screen/ui/home_screen.dart';
import 'package:izak_project_mizan_app/features/screens/log_in_screen/widgets/input_text_form_widgit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _incomeController = TextEditingController();
  final _balanceController = TextEditingController();

  // Variables for Dropdown

  String? _selectedCountry;

  // دالة الحفظ والتحقق من المستخدم

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus(); // إغلاق الكيبورد

      final prefs = await SharedPreferences.getInstance();
      bool isUserExist = prefs.containsKey('user_name');

      if (isUserExist) {
        // 1. إذا كان مسجلاً مسبقاً، نحدث حالة الدخول فقط وننتقل للهوم
        await prefs.setBool('is_logged_in', true);

        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('مرحباً بك مجدداً!')));
          // الانتقال للصفحة الرئيسية واستبدال صفحة اللوجن
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } else {
        // 2. إذا كان مستخدماً جديداً، نحفظ بياناته وحالة الدخول
        await prefs.setString('user_name', _nameController.text);
        await prefs.setString('user_email', _emailController.text);
        await prefs.setString('user_income', _incomeController.text);
        await prefs.setString('user_balance', _balanceController.text);
        _selectedCountry != null
            ? await prefs.setString('user_country', _selectedCountry!)
            : await prefs.setString('user_country', "اختر دولتك");

        await prefs.setBool('is_logged_in', true);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم تسجيل بياناتك بنجاح!')),
          );
          // الانتقال للصفحة الرئيسية
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: kPrimaryColor5,
        appBar: AppBar(
          backgroundColor: kPrimaryColor5,
          centerTitle: true,
          title: Text(
            "ميزان",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Lemonada',
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * .3,
                  width: SizeConfig.screenWidth * .75,
                  child: Image.asset("assets/images/login.gif"),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // 1. حقل الاسم
                      InputTextForm(
                        keyboardType: TextInputType.text,
                        validator: (v) => v!.isEmpty ? 'أدخل الاسم ' : null,
                        controller: _nameController,
                        label: '  الاسم كاملا ',
                      ),
                      const SizedBox(height: 15),
                      // 2. حقل البريد الإلكتروني
                      InputTextForm(
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) => (v == null || v.isEmpty)
                            ? 'أدخل البريد الإلكتروني'
                            : !v.contains('@')
                            ? 'البريد الإلكتروني يجب أن يحتوي على @'
                            : null,
                        controller: _emailController,
                        label: ' الايميل الالكترونى  ',
                      ),
                      const SizedBox(height: 15),
                      // 3. حقل الدخل الشهري (Visibility Toggle)
                      InputTextForm(
                        isPassword: true,
                        keyboardType: TextInputType.number,
                        validator: (v) =>
                            v!.isEmpty ? 'أدخل الدخل الشهرى ' : null,
                        controller: _incomeController,
                        label: ' الدخل الشهرى  ',
                      ),
                      const SizedBox(height: 15),
                      // 4. حقل الرصيد البنكي (Visibility Toggle)
                      InputTextForm(
                        isPassword: true,
                        keyboardType: TextInputType.number,
                        validator: (v) =>
                            v!.isEmpty ? 'أدخل الرصيد البنكى' : null,
                        controller: _balanceController,
                        label: ' الرصيد البنكى ',
                      ),
                      const SizedBox(height: 15),
                      // 5. قائمة منسدلة للدولة
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                            labelText: 'اختر دولتك',
                            suffixIcon: Icon(Icons.arrow_downward_rounded),
                          ),
                          initialValue: _selectedCountry,
                          items: countriesList
                              .map(
                                (c) =>
                                    DropdownMenuItem(value: c, child: Text(c)),
                              )
                              .toList(),
                          onChanged: (val) =>
                              setState(() => _selectedCountry = val),
                          validator: (v) =>
                              v == null ? 'الرجاء اختيار الدولة' : null,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // 6. زر تسجيل الدخول
                      ElevatedButton(
                        onPressed: _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor2,
                          minimumSize: Size(SizeConfig.screenWidth * .7, 50),
                        ),
                        child: const Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: 'Handjet',
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
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

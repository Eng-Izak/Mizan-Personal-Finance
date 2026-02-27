import 'package:flutter/material.dart';
import 'package:izak_project_mizan_app/core/constants/app_constants.dart';
import 'package:izak_project_mizan_app/core/theme/app_colors.dart';
import 'package:izak_project_mizan_app/core/utils/size_config.dart';
import 'package:izak_project_mizan_app/features/screens/log_in_screen/widgets/input_text_form_widgit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomChangeDataDialog extends StatefulWidget {
  const CustomChangeDataDialog({super.key});

  @override
  State<CustomChangeDataDialog> createState() => _CustomChangeDataDialogState();
}

class _CustomChangeDataDialogState extends State<CustomChangeDataDialog> {
  TextEditingController nameController = .new();
  TextEditingController emailController = .new();
  TextEditingController balanceController = .new();
  TextEditingController incomeController = .new();
  // String test1='';
  // String test2='';
  String? selectedCountry;
  final _formKey = GlobalKey<FormState>();
  Future<void> _changeProfileData() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus(); // إغلاق الكيبورد

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', nameController.text);
      await prefs.setString('user_email', emailController.text);
      await prefs.setString('user_income', incomeController.text);
      await prefs.setString('user_balance', balanceController.text);
      selectedCountry != null
          ? await prefs.setString('user_country', selectedCountry!)
          : await prefs.setString('user_country', "اختر دولتك");
      await prefs.setBool('hasChanges', true);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تم التعديل بنجاح !')));
      Navigator.of(context).pop(true);
    }
    setState(() {});
    final prefs = await SharedPreferences.getInstance();
    // prefs.get('user_income');
    debugPrint('${prefs.get('user_income')}======${prefs.get('user_balance')}');
  }

  Future<void> _changeCancelled() async {
    FocusScope.of(context).unfocus(); // إغلاق الكيبورد
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('hasChanges', false);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('تم الغاء التعديل  !')));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        backgroundColor: Colors.white,
        content: Container(
          height: SizeConfig.screenHeight * .8,
          width: SizeConfig.screenWidth * .6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "اضافة قسط جديد",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 32,
                  fontFamily: 'Handjet',
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * .015),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // 1. حقل الاسم
                    InputTextForm(
                      keyboardType: TextInputType.text,
                      validator: (v) => v!.isEmpty ? 'أدخل الاسم ' : null,
                      controller: nameController,
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
                      controller: emailController,
                      label: ' الايميل الالكترونى  ',
                    ),
                    const SizedBox(height: 15),
                    // 3. حقل الدخل الشهري (Visibility Toggle)
                    InputTextForm(
                      isPassword: true,
                      keyboardType: TextInputType.number,
                      validator: (v) =>
                          v!.isEmpty ? 'أدخل الدخل الشهرى ' : null,
                      controller: incomeController,
                      label: ' الدخل الشهرى  ',
                    ),
                    const SizedBox(height: 15),
                    // 4. حقل الرصيد البنكي (Visibility Toggle)
                    InputTextForm(
                      isPassword: true,
                      keyboardType: TextInputType.number,
                      validator: (v) =>
                          v!.isEmpty ? 'أدخل الرصيد البنكى' : null,
                      controller: balanceController,
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
                          prefixIcon: Icon(Icons.arrow_downward_rounded),
                        ),
                        initialValue: selectedCountry,
                        items: countriesList
                            .map(
                              (c) => DropdownMenuItem(value: c, child: Text(c)),
                            )
                            .toList(),
                        onChanged: (val) =>
                            setState(() => selectedCountry = val!),
                        validator: (v) =>
                            v == null ? 'الرجاء اختيار الدولة' : null,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 6. زر تسجيل الدخول
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: kPrimaryColor3,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: MaterialButton(
                            onPressed: _changeProfileData,
                            child: Text(
                              "حفظ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: _changeCancelled,
                          child: Text(
                            "الغاء",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * .05),
            ],
          ),
        ),
      ),
    );
  }
}

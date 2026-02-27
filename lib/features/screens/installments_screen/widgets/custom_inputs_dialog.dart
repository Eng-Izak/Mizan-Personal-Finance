import 'package:flutter/material.dart';
import 'package:izak_project_mizan_app/core/theme/app_colors.dart';
import 'package:izak_project_mizan_app/core/utils/size_config.dart';
import 'package:izak_project_mizan_app/features/screens/installments_screen/widgets/dialog_input_field.dart';
import 'package:izak_project_mizan_app/data/local/db_helper.dart';

class CustomeInputsDialogWidget extends StatefulWidget {
  const CustomeInputsDialogWidget({super.key});

  @override
  State<CustomeInputsDialogWidget> createState() =>
      _CustomeInputsDialogWidgetState();
}

class _CustomeInputsDialogWidgetState extends State<CustomeInputsDialogWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers
  final _monthInstallmentController = TextEditingController();
  final _dateController = TextEditingController();
  final _noteController = TextEditingController();

  // دالة الحفظ والتحقق من المستخدم

  Future<void> _addNewInstallment() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus(); // إغلاق الكيبورد
      SqlDb db = .new();

      await db.insertData(
        '''INSERT INTO Installments (monthly_installment, due_date, notes)
      VALUES ('${_monthInstallmentController.text}', '${_dateController.text}', '${_noteController.text}')''',
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تم الاضافة بنجاح !')));
      Navigator.of(context).pop(true);

      setState(() {});
    }
  }

  void _changeCancelled() {
    FocusScope.of(context).unfocus(); // إغلاق الكيبورد

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('تم الغاء !')));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: SizeConfig.screenHeight * .55,
        width: SizeConfig.screenWidth * .6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

              DialogInputField(
                label: "القسط الشهرى",
                controller: _monthInstallmentController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "الرجاء إدخال قيمة القسط الشهرى";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: SizeConfig.screenHeight * .015),

              DialogInputField(
                label: "الميعاد",
                controller: _dateController,
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "الرجاء إدخال ميعاد القسط الشهرى";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: SizeConfig.screenHeight * .015),
              DialogInputField(
                label: " ملاحظات",
                controller: _noteController,
                keyboardType: TextInputType.text,
                validator: null,
              ),
              SizedBox(height: SizeConfig.screenHeight * .05),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: kPrimaryColor3,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: MaterialButton(
                      onPressed: _addNewInstallment,
                      child: Text(
                        "اضافة",
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
      ),
    );
  }
}

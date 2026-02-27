import 'package:flutter/material.dart';
import 'package:izak_project_mizan_app/core/constants/app_constants.dart';
import 'package:izak_project_mizan_app/core/constants/exchange_rates.dart';
import 'package:izak_project_mizan_app/core/theme/app_colors.dart';
import 'package:izak_project_mizan_app/core/utils/size_config.dart';
import 'package:izak_project_mizan_app/features/comman_widgets/screen_massage_widget.dart';
import 'package:izak_project_mizan_app/features/screens/currency_converter_screen/widgets/result_view_widget.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController inpuController = .new();
  double? selectedValue;
  double result = 0.00;
  String selectedCurrency = 'Egypt (EGP)';
  String pageMessage = "فى هذه الغرفة يمكنك تحويل العملات الى قيمتها الدولارية";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            Text(
              "ميزان",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 42,
                fontFamily: 'Reem Kufi',
              ),
            ),
            SizedBox(width: SizeConfig.screenWidth * .04),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.screenHeight * .015),

                //اللوجو الخاص بالتطبيق موجود فى كل صفحة
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/images/logo.png"),
                    ),
                    SizedBox(width: SizeConfig.screenHeight * .015),
                  ],
                ),
                SizedBox(height: SizeConfig.screenHeight * .015),
                //الرسالة التعريفية الموجودة اول الصفحة
                ScreenMassageWidget(txt: pageMessage),
                SizedBox(height: SizeConfig.screenHeight * .03),
                //القائمة المنسدلة اللى بيقوم العميل باختيار عملته منها
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: SizeConfig.screenWidth * .03),
                    Container(
                      alignment: Alignment.center,
                      height: SizeConfig.screenHeight * .1,
                      width: SizeConfig.screenWidth * .4,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.arrow_downward_rounded),
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                          ),
                          initialValue: selectedCurrency,
                          items: currencyList
                              .map(
                                (element) => DropdownMenuItem(
                                  value: element,
                                  child: Text(
                                    element,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'Handjet',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedCurrency = val!;
                              selectedValue = 0.0;
                              result = 0.0;
                              inpuController.clear();
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: SizeConfig.screenWidth * .03),
                    Expanded(
                      child: Text(
                        textAlign: TextAlign.center,
                        "اختر العملة المراد تحويلها",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: SizeConfig.screenWidth * .001),
                  ],
                ),
                //الخانة اللى بيقوم فيها المستخدم بادخال المبلغ المراد تحويله
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * .25,
                  ),
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    controller: inpuController,
                    decoration: InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                      hintText: "ادخل المبلغ",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * .03),
                // الزر المسؤول عن عملية التحويل
                InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    selectedValue =
                        double.tryParse(inpuController.text) ?? 0.00;

                    double selectedCurrencyVal() {
                      return moneyFelow.entries
                          .firstWhere((entry) => entry.key == selectedCurrency)
                          .value;
                    }

                    result = selectedValue! / selectedCurrencyVal();

                    setState(() {});
                  },
                  child: Container(
                    height: SizeConfig.screenHeight * .07,
                    padding: EdgeInsets.only(
                      right: SizeConfig.screenWidth * .03,
                      left: SizeConfig.screenWidth * .03,
                      top: SizeConfig.screenHeight * .01,
                      bottom: SizeConfig.screenHeight * .001,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * .35,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor3,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "تحويل",
                      style: TextStyle(
                        fontSize: SizeConfig.screenHeight * .027,
                        fontFamily: 'Readex Pro',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * .03),
                //الاطار الذى يظهر به نتيجة التحويل للمبلغ المدخل من المستخدم
                ResultViewWidget(
                  selectedCurrency: selectedCurrency,
                  val: selectedValue,
                  result: result,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

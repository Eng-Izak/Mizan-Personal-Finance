import 'package:flutter/material.dart';
import 'package:izak_project_mizan_app/core/theme/app_colors.dart';
import 'package:izak_project_mizan_app/core/utils/size_config.dart';
import 'package:izak_project_mizan_app/features/comman_widgets/screen_massage_widget.dart';
import 'package:izak_project_mizan_app/core/models/new_installment_model.dart';
import 'package:izak_project_mizan_app/features/screens/installments_screen/widgets/custom_inputs_dialog.dart';
import 'package:izak_project_mizan_app/features/screens/installments_screen/widgets/no_installment_widget.dart';
import 'package:izak_project_mizan_app/data/local/db_helper.dart';

class InstallmentsScreen extends StatefulWidget {
  const InstallmentsScreen({super.key});

  @override
  State<InstallmentsScreen> createState() => _InstallmentsScreenState();
}

class _InstallmentsScreenState extends State<InstallmentsScreen> {
  late Future<List<Installment>> readInstallments;
  @override
  void initState() {
    readInstallments = _readInstallments();

    super.initState();
  }

  Future<List<Installment>> _readInstallments() async {
    SqlDb db = .new();

    List<Map> result = await db.readData("SELECT * FROM installments");
    List<Installment> data = result.map((e) => Installment.fromMap(e)).toList();
    return data;
  }

  void _changeDataDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => CustomeInputsDialogWidget(),
    );

    if (result == true) {
      setState(() {
        readInstallments = _readInstallments();
      });
    }
  }

  final String massage =
      "فى هذه الغرفة يتم عرض او اضافة او حذف الاقساط الملتزم بها حاليا";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        floatingActionButton: Row(
          children: [
            InkWell(
              onTap: _changeDataDialog,
              child: Container(
                height: SizeConfig.screenHeight * .06,
                width: SizeConfig.screenWidth * .14,
                decoration: BoxDecoration(
                  color: kPrimaryColor3,
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.only(left: 30, bottom: 5),
                alignment: Alignment.center,
                child: Icon(Icons.add),
              ),
            ),
            SizedBox(width: SizeConfig.screenHeight * .03),
          ],
        ),
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
            SizedBox(width: 20),
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
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(height: SizeConfig.screenHeight * .015),
                //الرسالة التعريفية الموجودة اول الصفحة
                ScreenMassageWidget(txt: massage),
                SizedBox(height: SizeConfig.screenHeight * .03),
                FutureBuilder<List<Installment>>(
                  future: readInstallments,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("You Have Error For Calling Data"),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return NoInstallmentWidget();
                    } else {
                      final List<Installment> installments = snapshot.data!;
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          dataTextStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          columns: [
                            DataColumn(
                              label: Text(
                                textAlign: TextAlign.center,
                                "ملاحظات",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                textAlign: TextAlign.center,
                                "الميعاد",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                textAlign: TextAlign.center,
                                "القسط الشهرى",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                          rows: installments.map((e) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  Text(e.notes, textAlign: TextAlign.center),
                                ),
                                DataCell(
                                  Text(e.dueDate, textAlign: TextAlign.center),
                                ),
                                DataCell(
                                  Text(
                                    "${e.monthlyInstallment}",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Installment {
  // final int id;
  final double monthlyInstallment;
  final String dueDate;
  final String notes;

  Installment({
    // required this.id,
    required this.monthlyInstallment,
    required this.dueDate,
    required this.notes,
  });

  // وظيفة تحويل الـ Map القادم من قاعدة البيانات إلى Object
  factory Installment.fromMap(Map<dynamic, dynamic> newRowData) {
    return Installment(
      // id: newRowData['id'],
      monthlyInstallment: newRowData['monthly_installment']?.toDouble() ?? 0.0,
      dueDate: newRowData['due_date'],
      notes: newRowData['notes'],
    );
  }
}















// import 'package:flutter/material.dart';

// class newInstallmentModel extends StatelessWidget {
//   const newInstallmentModel({super.key,
//     required this.data,});
//  final Map data;

//   @override
//   Widget build(BuildContext context) {
//     return Table(
//         defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//         border: TableBorder(verticalInside: BorderSide()),
//         children: [
//           TableRow(
//             decoration: BoxDecoration(border: Border.all()),
//             children: [
//               Text(
//                 data['monthly_installment'],
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 data['due_date'],
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 data['notes'],
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ],
//       );
//   }
// }
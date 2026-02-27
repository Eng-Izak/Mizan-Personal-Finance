import 'package:flutter/material.dart';
// import 'package:izak_project_mizan_app/core/utils/size_config.dart';

class DialogInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;

  // البناء (Constructor)
  const DialogInputField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text, // قيمة افتراضية نص
    this.isPassword = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        validator: validator,
        decoration: InputDecoration(
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          labelText: label,
          // border: UnderlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }
}

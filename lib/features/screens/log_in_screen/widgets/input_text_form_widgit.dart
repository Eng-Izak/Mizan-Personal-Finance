import 'package:flutter/material.dart';

class InputTextForm extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword; // هل هو حقل سري (مثل الرصيد أو الدخل)
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const InputTextForm({
    super.key,
    required this.controller,
    required this.label,
    this.isPassword = false, // القيمة الافتراضية أنه غير سري
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  State<InputTextForm> createState() => _InputTextFormState();
}

class _InputTextFormState extends State<InputTextForm> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    // نبدأ بإخفاء النص إذا كان الحقل "سري"
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        obscuringCharacter: '\$',
        controller: widget.controller,
        obscureText: _obscureText,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        decoration: InputDecoration(
          labelStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
          labelText: widget.label,
          // يظهر زر العين فقط إذا كان الحقل مخصصاً للبيانات السرية
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                )
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}

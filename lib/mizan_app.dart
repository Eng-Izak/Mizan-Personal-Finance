import 'package:flutter/material.dart';
import 'package:izak_project_mizan_app/features/screens/currency_converter_screen/ui/currency_converter_screen.dart';
import 'package:izak_project_mizan_app/features/screens/expenses_organizer_screen/ui/expenses_organizer_screen.dart';
import 'package:izak_project_mizan_app/features/screens/home_screen/ui/home_screen.dart';
import 'package:izak_project_mizan_app/features/screens/installments_screen/ui/installments_screen.dart';
import 'package:izak_project_mizan_app/features/screens/log_in_screen/ui/log_in_screen.dart';
import 'package:izak_project_mizan_app/features/screens/profile_screen/ui/profile_screen.dart';
import 'package:izak_project_mizan_app/features/screens/splash_screen/ui/splash_screen.dart';

class MizanApp extends StatelessWidget {
  const MizanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mizan',
      //  splash screen الشاشة التي سيبدأ بها التطبيق
      initialRoute: '/',
      //  خريطة بأسماء الشاشات الاخرى
      routes: {
        '/': (context) => SplashScreen(),
        // الشاشة الرئيسية (القائمة)
        '/homeScreen': (context) => HomeScreen(),
        // شاشة إضافة وتغيير تنظيم المصروفات
        '/expensesOrganizer': (context) => ExpensesOrganizerScreen(),
        // شاشة تحويل قيمة مبلغ من عملة لعملة اخرى
        '/currencyConverter': (context) => CurrencyConverterScreen(),
        // شاشة تسجيل الاقساط والالتزامات المالية
        '/installments': (context) => InstallmentsScreen(),
        // شاشة تسجيل بيانات الدخول فى حالة مستخد جديل
        '/logIn': (context) => LogInScreen(),
        // شاشة عرض وتعديل معلومات الصفحة الشخصية للمستخدم
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}

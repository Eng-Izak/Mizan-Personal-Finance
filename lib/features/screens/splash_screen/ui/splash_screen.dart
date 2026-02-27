import 'dart:async';
import 'package:flutter/material.dart';
import 'package:izak_project_mizan_app/core/utils/size_config.dart';
import 'package:izak_project_mizan_app/features/screens/home_screen/ui/home_screen.dart';
import 'package:izak_project_mizan_app/features/screens/log_in_screen/ui/log_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _scale = 0.0;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        _scale = 1.0;
      });
    });

    Timer(const Duration(seconds: 3), () async {
      final prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;
      if (mounted) {
        if (isLoggedIn) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LogInScreen()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Center(
          child: AnimatedScale(
            scale: _scale,
            duration: const Duration(seconds: 5),
            curve: Curves.easeOutBack,
            child: Column(
              children: [
                Spacer(),
                Image.asset("assets/images/mizan.png"),
                Text(
                  "ميزان",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Gulzar',
                    fontSize: 50,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

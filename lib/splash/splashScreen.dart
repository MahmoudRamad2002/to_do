import 'dart:async';

import 'package:flutter/material.dart';
import 'package:to_do/home_layout/home_layout.dart';
import 'package:to_do/shared/style/app_color.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String routeName = 'splash';

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 4),
        () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeLayout()),
            ));
    return Scaffold(
      backgroundColor: appColor.lightGreenColor,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          height: 211,
          width: 189,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

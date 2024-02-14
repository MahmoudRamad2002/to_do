import 'dart:async';

import 'package:flutter/material.dart';
import 'package:to_do/home_layout/home_layout.dart';

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
    return Scaffold();
  }
}

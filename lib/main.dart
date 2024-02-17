import 'package:flutter/material.dart';
import 'package:to_do/home_layout/home_layout.dart';
import 'package:to_do/shared/style/mt_them_data.dart';
import 'package:to_do/splash/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: myThemeData.ligthTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeLayout.routeName: (context) => HomeLayout()
      },
    );
  }
}

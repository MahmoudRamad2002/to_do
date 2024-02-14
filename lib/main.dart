import 'package:flutter/material.dart';
import 'package:to_do/home_layout/home_layout.dart';
import 'package:to_do/shared/style/mt_them_data.dart';

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
      initialRoute: HomeLayout.routeName,
      routes: {HomeLayout.routeName: (context) => HomeLayout()},
    );
  }
}

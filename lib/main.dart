import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Screens/login_in.dart';
import 'package:to_do/Screens/sign_up_screen.dart';
import 'package:to_do/Screens/update_screen.dart';
import 'package:to_do/firebise/firebaseFunction.dart';
import 'package:to_do/home_layout/home_layout.dart';
import 'package:to_do/provider/my_provider.dart';
import 'package:to_do/shared/style/my_them_data.dart';
import 'package:to_do/splash/splashScreen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.disableNetwork();
  FlutterError.onError = (errorDetails) {
    // If you wish to record a "non-fatal" exception, please use `FirebaseCrashlytics.instance.recordFlutterError` instead
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    // If you wish to record a "non-fatal" exception, please remove the "fatal" parameter
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  firebaseFunction.deleteOldTask();

  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      title: 'Localizations Sample App',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('ar'),
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],
      themeMode: ThemeMode.light,
      theme: myThemeData.ligthTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: provider.firebaseUser != null
          ? HomeLayout.routeName
          : LoginScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeLayout.routeName: (context) => HomeLayout(),
        UpdateScreen.routeName: (context) => UpdateScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
      },
    );
  }
}

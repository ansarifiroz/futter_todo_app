import 'package:flutter/material.dart';
import 'package:flutter_app2/home.dart';
import 'package:flutter_app2/introPage.dart';
import 'package:flutter_app2/language.dart';
import 'package:flutter_app2/splashscreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Messages(), // your translations
      locale: const Locale(
          'en', 'US'), // translations will be displayed in that locale

      home: const SplashScreen(),
    );
  }
}

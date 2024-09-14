import 'package:flutter/material.dart';
import 'package:flutter_app2/home.dart';
import 'package:flutter_app2/introPage.dart';
import 'package:flutter_app2/login.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var screen;
  @override
  void initState() {
    fetchLogin();
    super.initState();
  }

  fetchLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var islogIn = prefs.getBool('isLogIn') ?? false;
    bool introShown = prefs.getBool('introShown') ?? false;

    if (introShown == true) {
      if (islogIn == true) {
        screen = HomeScreen();
      } else {
        screen = LogInPage();
      }
    } else {
      screen = IntroPage();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Center(
            child: LottieBuilder.asset(
              'assets/lottie/Animation - 1725857668913.json',
            ),
          ),
        ],
      ),
      nextScreen: screen,
      splashIconSize: 450,
      backgroundColor: const Color(0xFFFFFFFF),
      splashTransition: SplashTransition.fadeTransition,
      duration: 3000,
    );
  }
}

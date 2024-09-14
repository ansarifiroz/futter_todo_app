import 'package:flutter/material.dart';
import 'package:flutter_app2/login.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Container(
          color: const Color(0xFFFFFFFF),
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.5,
                width: screenWidth * 0.9,
                child: Lottie.asset(
                  'assets/lottie/Animation - 1725857713537.json',
                  fit: BoxFit.contain,
                ),
              ),
              const Text(
                'Explore the app',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF000000)),
              ),
              Container(
                padding: const EdgeInsets.all(25),
                child: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi maecenas quis interdum enim enim molestie faucibus.',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: screenHeight * 0.07,
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                    color: const Color(0xFFFFC600),
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  onPressed: () async {
                    // Set the flag that intro has been shown
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('introShown', true);

                    // Navigate to login page
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LogInPage()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xFFFFC600)),
                  ),
                  child: const Text('Let\'s Start',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

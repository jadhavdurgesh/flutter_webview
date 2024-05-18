import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(() => const HomeScreen());
    });

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Center(
              child: Image.asset(
            "assets/images/nutrahara-logo.png",
            height: 40,
          )),
          SizedBox(height: 30,),
          const CircularProgressIndicator(
            color: Color.fromARGB(255, 2, 79, 6),
            strokeWidth: 2,
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          const Text(
            "Nutrahara: Nourishing Women Naturally \n Trusted by Millions",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 2, 79, 6),
                fontWeight: FontWeight.w600),
          ),
          Container(
            height: 40,
          )
        ],
      ),
    );
  }
}

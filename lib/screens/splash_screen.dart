import 'dart:async';

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/appIcon.png",
          width: 200,
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
          "TODO APP ",
          style: TextStyle(
              fontSize: 30, color: Colors.blue, fontWeight: FontWeight.bold),
        )
      ],
    )));
  }
}

import 'package:classbridge/views/home_screen.dart';
import 'package:classbridge/views/main_screen.dart';
import 'package:classbridge/views/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    timer();
  }

  Future timer() {
    User? user = FirebaseAuth.instance.currentUser;
    final time = Future.delayed(Duration(seconds: 2), () {
      if(user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school_rounded, size: 28),
            SizedBox(width: 10),
            Text('CLASSBRIDGE', style: TextStyle(fontFamily: 'Gilroy', fontWeight: FontWeight.w600, fontSize: 20),),
          ],)),
      ),
    );
  }
}

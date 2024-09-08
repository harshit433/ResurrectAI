import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../routes.dart';
// import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.pushReplacementNamed(context, Routes.homescreen);
      } else {
        Navigator.pushReplacementNamed(context, Routes.splashscreen1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset('assets/images/logo.png',
                    height: MediaQuery.sizeOf(context).width / 3,
                    width: MediaQuery.sizeOf(context).width / 3)),
            const Text('resurrect.ai',
                style: TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.w200,
                  color: Colors.black,
                  fontFamily: 'Kanit',
                )),
          ],
        ),
      ),
    );
  }
}

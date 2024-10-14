import 'package:flutter/material.dart';
import 'package:resurrectai/Pages/SplashScreen/splash_screen.dart';
import 'package:resurrectai/Pages/LandingScreen/landing_screen.dart';
import 'package:resurrectai/Pages/SignUpScreen/signup_screen.dart';
import 'package:resurrectai/Pages/LoginScreen/login_screen.dart';
import 'package:resurrectai/Pages/HomeScreen/home_screen.dart';
import 'package:resurrectai/Pages/chat_screen.dart';
import 'package:resurrectai/Pages/call_screen.dart';
import 'package:resurrectai/Pages/profile_screen.dart';

// Import other screen files as needed

class Routes {
  static const String splashscreen = '/splash_screen';
  static const String splashscreen1 = '/splash_screen1';
  static const String signupscreen = '/signup_screen';
  static const String loginscreen = '/login_screen';
  static const String homescreen = '/home_screen';
  static const String chatscreen = '/chat_screen';
  static const String callscreen = '/call_screen';
  static const String profilescreen = '/profile_screen';

  // Add more route names for other screens

  static Map<String, WidgetBuilder> routes = {
    splashscreen: (context) => const SplashScreen(),
    splashscreen1: (context) => const LandingScreen(),
    signupscreen: (context) => SignUpScreen(),
    loginscreen: (context) => LogInScreen(),
    homescreen: (context) => const HomeScreen(),
    chatscreen: (context) => const ChatScreen(),
    callscreen: (context) => const CallScreen(),
    profilescreen: (context) => const ProfileScreen(
          personality: null,
        ),
    // Add more routes for other screens
  };
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:travelbae_android/ui/screens/splash_screen.dart';
import 'package:travelbae_android/ui/screens/home_screen.dart';
import 'package:travelbae_android/ui/screens/login_screen.dart';
import 'package:travelbae_android/ui/screens/register_screen.dart';
import 'package:travelbae_android/ui/screens/profile_screen.dart';
import 'package:travelbae_android/ui/widgets/custom_bottom_navbar.dart';
import 'package:travelbae_android/ui/screens/detail_place_screen.dart';
import 'package:travelbae_android/ui/screens/ticket_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      //**
      // Testing Perpage
      // */
      // home:
      // LoginScreen(),
      // Test Screen
      // SplashScreen(),
      // RegisterScreen(),
      // HomeScreen(),
      // ProfileScreen(),
      // DetailPlacePage(),
      // MyOrderPage(),
      // CustomBottomNavbar(),
    );
  }
}

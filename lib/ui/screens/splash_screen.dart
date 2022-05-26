// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:travelbae_android/styleGuide.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity, // container full
          margin: EdgeInsets.symmetric(horizontal: 24),
          color: neutral_10,
          child: Column(
            //---TINGGAL EDIT DIBAWAH SINI---
            mainAxisSize:
                MainAxisSize.max, // max: fill container, min: hug content
            children: [
              SizedBox(
                height: 240,
              ),
              Image.asset(
                'asets/Logo.png',
                height: 48,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

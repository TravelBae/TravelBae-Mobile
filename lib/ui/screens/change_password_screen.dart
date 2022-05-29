// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelbae_android/styleGuide.dart';
import 'package:travelbae_android/ui/widgets/custom_form_field.dart';
import 'package:travelbae_android/ui/screens/login_screen.dart';
import 'package:travelbae_android/ui/screens/profile_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity, // container full
          margin: EdgeInsets.symmetric(horizontal: 24), // margin kanan kiri
          color: neutral_10,
          child: SingleChildScrollView(
            child: Column(
              //---TINGGAL EDIT DIBAWAH SINI---
              mainAxisSize:
                  MainAxisSize.max, // max: fill container, min: hug content
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 32,
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
                  },
                  child: SvgPicture.asset(
                    iconBack,
                    height: 32,
                    width: 32,
                    fit: BoxFit.scaleDown,
                  ),
                ),

                SizedBox(
                  height: 16,
                ),

                // HEADER
                Text("Change Password", style: text_lg_bold),
                SizedBox(
                  height: 32,
                ),
                Column(
                  children: [
                    CustomFormField(
                        controller: TextEditingController(),
                        label: "Password",
                        placeholder: "Enter your password ...",
                        isPassword: true)
                  ],
                ),
                Column(
                  children: [
                    CustomFormField(
                        controller: TextEditingController(),
                        label: "Confirm Password",
                        placeholder: "Enter your password ...",
                        isPassword: true)
                  ],
                ),
                SizedBox(
                  height: 250,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ProfileScreen()));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(primary_40),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Submit",
                          style: text_base_bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

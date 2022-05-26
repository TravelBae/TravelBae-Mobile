// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:travelbae_android/styleGuide.dart';
import 'package:travelbae_android/ui/widgets/custom_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
              children: [
                SizedBox(
                  height: 24,
                ),
                Image.asset(
                  'asets/illus/illus-1.png',
                  height: 172,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text("Create Account", style: text_lg_bold),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: Text(
                    "please register to get started",
                    style:
                        TextStyle(color: neutral_40), // textstyle gabisa ya???
                  ),
                ),
                Column(
                  children: [
                    CustomFormField(
                        label: "Name",
                        placeholder: "Enter your name...",
                        isPassword: false)
                  ],
                ),
                Column(
                  children: [
                    CustomFormField(
                        label: "Phone Number",
                        placeholder: "62+",
                        isPassword: false)
                  ],
                ),
                Column(
                  children: [
                    CustomFormField(
                        label: "Email",
                        placeholder: "example@gmail.com",
                        isPassword: false)
                  ],
                ),
                Column(
                  children: [
                    CustomFormField(
                        label: "Password",
                        placeholder: "Enter your password...",
                        isPassword: true)
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {},
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

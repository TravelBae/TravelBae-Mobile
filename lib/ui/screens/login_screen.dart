import 'package:flutter/material.dart';
import 'package:travelbae_android/styleGuide.dart';
import 'package:travelbae_android/ui/widgets/custom_form_field.dart';
import 'package:travelbae_android/ui/widgets/custom_bottom_navbar.dart';
import 'package:travelbae_android/ui/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity, // container full
          margin: EdgeInsets.symmetric(horizontal: 24), // margin kanan kiri
          color: neutral_10,
          child: Column(
            //---TINGGAL EDIT DIBAWAH SINI---
            mainAxisSize:
                MainAxisSize.max, // max: fill container, min: hug content
            children: [
              SizedBox(
                height: 24,
              ),
              Image.asset(
                'asets/illus/illus-2.png',
                height: 172,
              ),
              Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text("Welcome Back", style: text_lg_bold),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Text(
                  "please sign in to continue",
                  style: TextStyle(color: neutral_40), // textstyle gabisa ya???
                ),
              ),
              Column(
                children: [
                  CustomFormField(
                      label: "Email",
                      placeholder: "Enter your email...",
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
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CustomBottomNavbar()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primary_40),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Login",
                      style: text_base_bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Need an account?"),
                    SizedBox(width: 4),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const RegisterScreen()));
                        },
                        child: Text("Register",
                            style: TextStyle(color: primary_40))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

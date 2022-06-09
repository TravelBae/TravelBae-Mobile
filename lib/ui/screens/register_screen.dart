//Import library
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelbae_android/styleGuide.dart';

//Import Screen
import 'package:travelbae_android/ui/screens/login_screen.dart';

//Import Widget
import 'package:travelbae_android/ui/widgets/custom_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var unameController = TextEditingController();
  var passController = TextEditingController();
  var passconfirmController = TextEditingController();
  var emailController = TextEditingController();
  var nohpController = TextEditingController();
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
              children: [
                SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 32,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset(
                    iconBack,
                    height: 32,
                    width: 32,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'asets/illus/illus-1.png',
                        height: 172,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text("Create Account", style: text_lg_bold),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 24),
                        child: Text(
                          "please register to get started",
                          style: TextStyle(color: neutral_40),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    CustomFormField(
                        controller: unameController,
                        label: "Username",
                        placeholder: "Enter your username...",
                        isPassword: false)
                  ],
                ),
                Column(
                  children: [
                    CustomFormField(
                        controller: nohpController,
                        label: "Phone Number",
                        placeholder: "62+",
                        isPassword: false)
                  ],
                ),
                Column(
                  children: [
                    CustomFormField(
                        controller: emailController,
                        label: "Email",
                        placeholder: "example@gmail.com",
                        isPassword: false)
                  ],
                ),
                Column(
                  children: [
                    CustomFormField(
                        controller: passController,
                        label: "Password",
                        placeholder: "Enter your password...",
                        isPassword: true)
                  ],
                ),
                Column(
                  children: [
                    CustomFormField(
                        controller: passconfirmController,
                        label: "Confirm Password",
                        placeholder: "Enter your password...",
                        isPassword: true)
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      register();
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

  Future<void> register() async {
    if (unameController.text.isNotEmpty &&
        passController.text.isNotEmpty &&
        passconfirmController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        nohpController.text.isNotEmpty) {
      if (passController.text == passconfirmController.text) {
        var response = await http.post(
            Uri.parse(
              "http://10.0.2.2:8000/api/register",
            ),
            body: ({
              'username': unameController.text,
              'password': passController.text,
              'password_confirmation': passconfirmController.text,
              'email': emailController.text,
              'noHP': nohpController.text
            }));
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          String apiKey = data['token'];
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text(
              "Registration Success!",
              style: TextStyle(color: neutral_10),
            ),
            backgroundColor: success_30,
          ));
          print(response.statusCode);
          Timer(
              Duration(seconds: 3),
              () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen())));
        } else {
          print(response.statusCode);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text(
              "Something unexpected happened, please try again",
              style: TextStyle(color: neutral_10),
            ),
            backgroundColor: danger_30,
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
            "Your password and confirmation does not match, please try again",
            style: TextStyle(color: neutral_10),
          ),
          backgroundColor: danger_30,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          "Please fill in all the blank form",
          style: TextStyle(color: neutral_10),
        ),
        backgroundColor: danger_30,
      ));
    }
  }
}

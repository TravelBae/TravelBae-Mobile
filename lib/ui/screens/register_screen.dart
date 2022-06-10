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
  bool isHidden = true;
  bool isHidden_conf = true;
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 12, bottom: 4),
                          child: Text("Password", style: text_xs_bold),
                        ),
                        TextFormField(
                          style: text_xs,
                          controller: passController,
                          obscureText: isHidden,
                          decoration: InputDecoration(
                              hintText: "Enter your password...",
                              hintStyle: TextStyle(color: neutral_30),
                              filled: true,
                              fillColor: neutral_20,
                              suffixIcon: IconButton(
                                icon: isHidden == true
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                                onPressed: togglePasswordVisibility,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: neutral_20),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: primary_20),
                                borderRadius: BorderRadius.circular(8),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 12, bottom: 4),
                          child: Text("Confirm Password", style: text_xs_bold),
                        ),
                        TextFormField(
                          style: text_xs,
                          controller: passconfirmController,
                          obscureText: isHidden_conf,
                          decoration: InputDecoration(
                              hintText: "Confirm your password...",
                              hintStyle: TextStyle(color: neutral_30),
                              filled: true,
                              fillColor: neutral_20,
                              suffixIcon: IconButton(
                                icon: isHidden_conf
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                                onPressed: togglePasswordVisibility2,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: neutral_20),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: primary_20),
                                borderRadius: BorderRadius.circular(8),
                              )),
                        ),
                      ],
                    )
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

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
  void togglePasswordVisibility2() =>
      setState(() => isHidden_conf = !isHidden_conf);

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
            headers: {
              'Accept': 'application/json',
            },
            body: ({
              'username': unameController.text,
              'password': passController.text,
              'password_confirmation': passconfirmController.text,
              'email': emailController.text,
              'noHP': nohpController.text
            }));
        print(response.body);
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
        } else if (response.statusCode == 422) {
          final data = jsonDecode(response.body);
          String errmsg = data['message'];
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              errmsg,
              style: TextStyle(color: neutral_10),
            ),
            backgroundColor: danger_30,
          ));
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

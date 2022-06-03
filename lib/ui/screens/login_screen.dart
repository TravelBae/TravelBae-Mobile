import 'package:flutter/material.dart';
import 'package:travelbae_android/styleGuide.dart';
import 'package:travelbae_android/ui/widgets/custom_form_field.dart';
import 'package:travelbae_android/ui/widgets/custom_bottom_navbar.dart';
import 'package:travelbae_android/ui/screens/register_screen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var unameController = TextEditingController();
  var passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity, // container full
            margin:
                const EdgeInsets.symmetric(horizontal: 24), // margin kanan kiri
            color: neutral_10,
            child: Column(
              //---TINGGAL EDIT DIBAWAH SINI---
              mainAxisSize:
                  MainAxisSize.max, // max: fill container, min: hug content
              children: [
                const SizedBox(
                  height: 24,
                ),
                Image.asset(
                  'asets/illus/illus-2.png',
                  height: 172,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text("Welcome Back", style: text_lg_bold),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: Text(
                    "please sign in to continue",
                    style:
                        TextStyle(color: neutral_40), // textstyle gabisa ya???
                  ),
                ),
                Column(
                  children: [
                    CustomFormField(
                        controller: unameController,
                        label: "Username",
                        key: const Key("_username"),
                        placeholder: "Enter your username...",
                        isPassword: false)
                  ],
                ),
                Column(
                  children: [
                    CustomFormField(
                        controller: passController,
                        label: "Password",
                        key: const Key("_password"),
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
                      login();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primary_40),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Login",
                        style: text_base_bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Need an account?"),
                      const SizedBox(width: 4),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const RegisterScreen()));
                          },
                          child: const Text("Register",
                              style: const TextStyle(color: primary_40))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    if (passController.text.isNotEmpty && unameController.text.isNotEmpty) {
      var response =
          await http.post(Uri.parse("http://10.0.2.2:8000/api/login"),
              body: ({
                'username': unameController.text,
                'password': passController.text,
                'role_id': "3"
              }));
      if (response.statusCode == 200) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CustomBottomNavbar(
                  pageindex: 0,
                  username: unameController.text,
                )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
            "Username or password is wrong, please try again",
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

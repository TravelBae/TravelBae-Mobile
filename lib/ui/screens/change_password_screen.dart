//Import library
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelbae_android/styleGuide.dart';

//Import models
import 'package:travelbae_android/models/user_model.dart';

//Import Screen

//Import Widget
import 'package:travelbae_android/ui/widgets/custom_bottom_navbar.dart';
import 'package:travelbae_android/ui/widgets/custom_form_field.dart';

Future<List<User>> fetchUser(http.Client client, String token) async {
  final response = await client
      .get(Uri.parse('http://10.0.2.2:8000/api/customer'), headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer ' + token
  });
  return compute(parseUser, response.body);
}

List<User> parseUser(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<User>((json) => User.fromJson(json)).toList();
}

class ChangePasswordScreen extends StatefulWidget {
  User user;
  String token;
  ChangePasswordScreen({required this.user, required this.token, Key? key})
      : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var passController = TextEditingController();
  var passconfirmationController = TextEditingController();

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
                    Navigator.of(context).pop();
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
                        controller: passController,
                        label: "Password",
                        placeholder: "Enter your password ...",
                        isPassword: true)
                  ],
                ),
                Column(
                  children: [
                    CustomFormField(
                        controller: passconfirmationController,
                        label: "Confirm Password",
                        placeholder: "Enter your password ...",
                        isPassword: true)
                  ],
                ),
                const SizedBox(
                  height: 300,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CustomBottomNavbar(
                                  pageindex: 2,
                                  user: widget.user,
                                  token: widget.token,
                                )));
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> editprofil() async {
    List<User> users;
    int i = 0;
    users = await fetchUser(http.Client(), widget.token);
    int key = users.length - 1;
    for (i = 0; i < users.length - 1; i++) {
      if (users[i].username == widget.user.username) {
        key = i;
      }
    }
    if (passController.text.isNotEmpty &&
        passconfirmationController.text.isNotEmpty) {
      if (passController.text == passconfirmationController.text) {
        var response = await http.put(
            Uri.parse("http://10.0.2.2:8000/api/change-password/" +
                users[key].id.toString()),
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer ' + widget.token
            },
            body: ({
              'password': passController.text,
              'password_confirmation': passconfirmationController.text,
            }));
        if (response.statusCode == 200) {
          print(response.statusCode);
          final data = jsonDecode(response.body);

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CustomBottomNavbar(
                    pageindex: 2,
                    token: widget.token,
                    user: widget.user,
                  )));
        } else {
          print(response.statusCode);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text(
              "Change Password Success!",
              style: TextStyle(color: neutral_10),
            ),
            backgroundColor: success_30,
          ));

          print(
              "http://10.0.2.2:8000/api/customer/" + users[key].id.toString());
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text(
              "Something unexpected happened, please try again",
              style: TextStyle(color: neutral_10),
            ),
            backgroundColor: danger_30,
          ));
        }
      } else {
        print("halo");
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

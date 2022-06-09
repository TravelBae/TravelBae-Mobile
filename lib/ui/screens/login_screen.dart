//Import library
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:travelbae_android/styleGuide.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Import models
import 'package:travelbae_android/models/user_model.dart';

//Import Screen
import 'package:travelbae_android/ui/screens/register_screen.dart';

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

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var unameController = TextEditingController();
  var passController = TextEditingController();
  bool isHidden = true;
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
                    style: TextStyle(color: neutral_40),
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
                                icon: isHidden
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
                              style: TextStyle(color: primary_40))),
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

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);

  Future<void> login() async {
    List<User> users;
    User user;
    int i;
    if (passController.text.isNotEmpty && unameController.text.isNotEmpty) {
      var response =
          await http.post(Uri.parse("http://10.0.2.2:8000/api/login"),
              body: ({
                'username': unameController.text,
                'password': passController.text,
                'role_id': "3"
              }));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String apiKey = data['token'];
        print("apiKey $apiKey");

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
            "Login Success!",
            style: TextStyle(color: neutral_10),
          ),
          backgroundColor: success_30,
        ));

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('apiKey', apiKey);

        users = await fetchUser(http.Client(), apiKey);
        int key = users.length - 1;
        for (i = 0; i < users.length - 1; i++) {
          if (users[i].username == unameController.text) {
            key = i;
          }
        }
        user = users[key];
        print(user.username);

        String? getedApiKey = await prefs.getString('apiKey');
        print(getedApiKey);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CustomBottomNavbar(
                  pageindex: 0,
                  token: getedApiKey.toString(),
                  user: user,
                )));
      } else {
        print("test");
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

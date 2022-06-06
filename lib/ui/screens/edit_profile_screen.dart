import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelbae_android/styleGuide.dart';
import 'package:travelbae_android/ui/widgets/custom_bottom_navbar.dart';
import 'package:travelbae_android/ui/widgets/custom_form_field.dart';
import 'package:travelbae_android/ui/screens/profile_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
                Text("Edit Profile", style: text_lg_bold),
                SizedBox(
                  height: 32,
                ),
                Column(
                  children: [
                    CustomFormField(
                        controller: TextEditingController(),
                        label: "Username",
                        placeholder: "Indra Kenzzz",
                        isPassword: false)
                  ],
                ),
                Column(
                  children: [
                    CustomFormField(
                        controller: TextEditingController(),
                        label: "Phone Number",
                        placeholder: "6285212341234",
                        isPassword: false)
                  ],
                ),
                Column(
                  children: [
                    CustomFormField(
                        controller: TextEditingController(),
                        label: "Email",
                        placeholder: "kenz@gmail.com",
                        isPassword: false)
                  ],
                ),
                SizedBox(
                  height: 180,
                ),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 120,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(neutral_20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              "Discard",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: neutral_40,
                                  fontWeight: bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 218,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CustomBottomNavbar(
                                      pageindex: 2,
                                      username: '',
                                      token: '',
                                    )));
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(primary_40),
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelbae_android/styleGuide.dart';
import 'package:travelbae_android/ui/screens/change_password_screen.dart';
import 'package:travelbae_android/ui/screens/edit_profile_screen.dart';
import 'package:travelbae_android/ui/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                height: 32,
              ),
              //**
              //  Tulisan Profile
              // */
              SizedBox(
                child: Container(
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Profile",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 24, fontWeight: bold)),
                      ),
                    ],
                  ),
                ),
                height: 32,
              ),
              const SizedBox(
                height: 24,
              ),
              Image.asset(
                'asets/illus/illus-4.png',
                height: 272,
              ),
              const SizedBox(
                height: 32,
              ),
              //**
              //  Buttons
              // */
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const EditProfileScreen()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(neutral_20),
                  ),
                  child: Row(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: SvgPicture.asset(
                            iconEditProfile,
                            height: 24,
                            width: 24,
                            fit: BoxFit.scaleDown,
                          )),
                      Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: const Text('Edit Profile',
                              style:
                                  TextStyle(color: neutral_60, fontSize: 16)))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ChangePasswordScreen()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(neutral_20),
                  ),
                  child: Row(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: SvgPicture.asset(
                            iconChangePassword,
                            height: 24,
                            width: 24,
                            fit: BoxFit.scaleDown,
                          )),
                      Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: const Text('Change Password',
                              style:
                                  TextStyle(color: neutral_60, fontSize: 16)))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(neutral_20),
                  ),
                  child: Row(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: SvgPicture.asset(
                            iconSignOut,
                            height: 24,
                            width: 24,
                            fit: BoxFit.scaleDown,
                          )),
                      Container(
                          margin: const EdgeInsets.only(left: 20.0),
                          child: const Text('Sign Out',
                              style:
                                  TextStyle(color: neutral_60, fontSize: 16)))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

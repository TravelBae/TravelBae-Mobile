import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelbae_android/styleGuide.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelbae_android/ui/widgets/custom_bottom_navbar.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity, // container full
          margin: EdgeInsets.symmetric(horizontal: 24),
          color: neutral_10,
          child: Column(
            //---TINGGAL EDIT DIBAWAH SINI---
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 140,
              ),
              Image.asset(
                'asets/illus/illus-3.png',
                height: 272,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Your order has successfully paid!",
                style: text_xl_bold,
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CustomBottomNavbar(
                              pageindex: 0,
                              username: '',
                            )));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(primary_40),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Back to Home",
                      style: text_base_bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 72,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

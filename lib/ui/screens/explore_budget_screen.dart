import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelbae_android/styleGuide.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExploreBudgetPage extends StatefulWidget {
  const ExploreBudgetPage({Key? key}) : super(key: key);

  @override
  State<ExploreBudgetPage> createState() => _ExploreBudgetPageState();
}

class _ExploreBudgetPageState extends State<ExploreBudgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 24),
          color: neutral_10,
          child: Column(
            //---TINGGAL EDIT DIBAWAH SINI---
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 280,
              ),
              Text("Choose your traveling budget!", style: text_2xl_bold),
              SizedBox(
                height: 86,
              ),
              Column(
                children: [
                  categoryOption(),
                  categoryOption(),
                  categoryOption(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryOption() {
    return Container(
      width: double.infinity,
      height: 52,
      margin: EdgeInsets.only(bottom: 24),
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primary_40),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "Budget range",
            style: text_base_bold,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelbae_android/styleGuide.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelbae_android/ui/screens/explore_category_screen.dart';

class ExploreDestinationPage extends StatefulWidget {
  const ExploreDestinationPage({Key? key}) : super(key: key);

  @override
  State<ExploreDestinationPage> createState() => _ExploreDestinationPageState();
}

class _ExploreDestinationPageState extends State<ExploreDestinationPage> {
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
                height: 180,
              ),
              Text("where is your travel destination?", style: text_2xl_bold),
              SizedBox(
                height: 86,
              ),
              Column(
                children: [
                  destinationOption(),
                  destinationOption(),
                  destinationOption(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget destinationOption() {
    return Container(
      width: double.infinity,
      height: 52,
      margin: EdgeInsets.only(bottom: 24),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ExploreCategoryPage()));
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primary_40),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "Destination",
            style: text_base_bold,
          ),
        ),
      ),
    );
  }
}

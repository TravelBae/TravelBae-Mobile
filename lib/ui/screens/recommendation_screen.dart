import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelbae_android/styleGuide.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelbae_android/ui/screens/tourplaces/detail_place_screen.dart';
import 'package:travelbae_android/ui/screens/explore_dest_screen.dart';

class RecomendationScreen extends StatefulWidget {
  const RecomendationScreen({Key? key}) : super(key: key);

  @override
  State<RecomendationScreen> createState() => _RecomendationScreenState();
}

class _RecomendationScreenState extends State<RecomendationScreen> {
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
                height: 32,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ExploreDestinationPage()));
                  },
                  child: SvgPicture.asset(
                    iconBack,
                    height: 32,
                    width: 32,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              SizedBox(
                height: 66,
              ),
              Text("Here’s what we recommend for you!", style: text_2xl_bold),
              SizedBox(
                height: 72,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    customCard(),
                    customCard(),
                    customCard(),
                    customCard(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customCard() {
    return Column(
      children: [
        GestureDetector(
          //onTap: () {
          //  Navigator.of(context).push(MaterialPageRoute(
          //      builder: (context) => DetailPlacePage()));
          //},
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    height: 72,
                    width: 72,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: primary_30,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'asets/illus/image-sample.png',
                        height: 200,
                        width: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nama event",
                    style: text_base_bold,
                  ),
                  Text(
                    "Description about tour place here...",
                    style: text_sm,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

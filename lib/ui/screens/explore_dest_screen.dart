//Import library
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelbae_android/styleGuide.dart';

//Import Screen
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
          margin: const EdgeInsets.symmetric(horizontal: 24),
          color: neutral_10,
          child: Column(
            //---TINGGAL EDIT DIBAWAH SINI---
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 24,
              ),
              const SizedBox(
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
              const SizedBox(
                height: 92,
              ),
              Text("where is your travel destination?", style: text_2xl_bold),
              const SizedBox(
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
      margin: const EdgeInsets.only(bottom: 24),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ExploreCategoryPage()));
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primary_40),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "Destination",
            style: text_base_bold,
          ),
        ),
      ),
    );
  }
}

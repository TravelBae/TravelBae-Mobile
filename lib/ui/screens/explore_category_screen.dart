//Import library
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelbae_android/styleGuide.dart';

//Import Screen
import 'package:travelbae_android/ui/screens/explore_budget_screen.dart';

class ExploreCategoryPage extends StatefulWidget {
  const ExploreCategoryPage({Key? key}) : super(key: key);

  @override
  State<ExploreCategoryPage> createState() => _ExploreCategoryPageState();
}

class _ExploreCategoryPageState extends State<ExploreCategoryPage> {
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
              Text("Which one do you prefer?", style: text_2xl_bold),
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
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ExploreBudgetPage()));
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primary_40),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "Category",
            style: text_base_bold,
          ),
        ),
      ),
    );
  }
}

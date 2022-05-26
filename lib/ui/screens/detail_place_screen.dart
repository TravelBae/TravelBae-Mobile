import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelbae_android/styleGuide.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailPlacePage extends StatefulWidget {
  const DetailPlacePage({Key? key}) : super(key: key);

  @override
  State<DetailPlacePage> createState() => _DetailPlacePageState();
}

class _DetailPlacePageState extends State<DetailPlacePage> {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 32,
              ),

              // GAMBAR

              // DETAIL
              SizedBox(
                height: 24,
              ),

              // ABOUT
              Text("About", style: text_base_bold),
              SizedBox(
                height: 16,
              ),

              // DESC
              Text("Desc", style: text_base),
              SizedBox(
                height: 16,
              ),

              // LOCATION
              Text("Location", style: text_base),
              // TIME
              Text("Clock", style: text_base),

              // MORE INFO
              Row(),

              // BUTTON
            ],
          ),
        ),
      ),
    );
  }
}

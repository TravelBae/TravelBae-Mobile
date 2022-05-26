import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelbae_android/styleGuide.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity, // container full
          margin: EdgeInsets.symmetric(horizontal: 24),
          color: neutral_10,
          child: SingleChildScrollView(
            child: Column(
              //---TINGGAL EDIT DIBAWAH SINI---
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 32,
                ),

                // HEADER
                Text("Welcome!", style: text_base_bold),
                Text("Indra Kenzzz", style: text_2xl_bold),
                SizedBox(
                  height: 32,
                ),

                // BUTTON EXPLORE
                SizedBox(
                  width: double.infinity,
                  height: 81,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(primary_40),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))))),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Explore More",
                                style: text_xl_bold,
                              ),
                              Text(
                                "Get ticket recomendation from us ",
                                style: text_xs,
                              ),
                            ],
                          ),
                          SizedBox(
                            child: Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                color: neutral_10,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                arrowRight,
                                height: 12,
                                width: 12,
                                color: primary_40,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),

                // SEARCH FIELD
                SizedBox(
                  height: 56,
                  child: TextField(
                    style: text_base,
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: neutral_40),
                      filled: true,
                      fillColor: neutral_20,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: neutral_10),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),

                // CATEGORY
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "category1",
                        style: text_base,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "category1",
                        style: text_base,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "category1",
                        style: text_base,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "category1",
                        style: text_base,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),

                // CARD RECOMENDATION
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      mainCard(),
                      mainCard(),
                      mainCard(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),

                // EXPLORE MORE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Newest Event",
                      style: text_xl_bold,
                    ),
                    Text(
                      "See all",
                      style: text_xs,
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [secondCard(), secondCard(), secondCard()],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget mainCard() {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: neutral_30, width: 1),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Image.asset(
              'asets/illus/image-sample.png',
              height: 200,
              width: 220,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sawah Telkom",
                  style: text_base_bold,
                ),
                Text(
                  "Buah batu, Bandung",
                  style: TextStyle(
                    color: neutral_40,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget secondCard() {
    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                Container(
                  height: 72,
                  width: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: primary_30,
                  ),
                  child: Image.asset(
                    'asets/illus/image-sample.png',
                    height: 200,
                    width: 220,
                    fit: BoxFit.cover,
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
                  "Alamat",
                  style: text_sm,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

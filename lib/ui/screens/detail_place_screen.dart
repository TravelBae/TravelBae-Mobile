import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelbae_android/styleGuide.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelbae_android/ui/widgets/custom_description.dart';
import 'package:travelbae_android/ui/screens/checkout_screen.dart';
import 'package:travelbae_android/ui/widgets/custom_bottom_navbar.dart';

class DetailPlacePage extends StatefulWidget {
  const DetailPlacePage({Key? key}) : super(key: key);

  @override
  State<DetailPlacePage> createState() => _DetailPlacePageState();
}

class _DetailPlacePageState extends State<DetailPlacePage> {
  final String desc =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: neutral_10,
          child: SingleChildScrollView(
            child: Column(
              //---TINGGAL EDIT DIBAWAH SINI---
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // GAMBAR
                Stack(
                  children: <Widget>[
                    Stack(children: <Widget>[
                      Image.asset(
                        'asets/illus/image-sample.png',
                        height: 428,
                        width: 420,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        height: 428,
                        width: 420,
                        padding: const EdgeInsets.all(5.0),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Colors.black.withAlpha(0),
                              Colors.black12,
                              Colors.black45
                            ],
                          ),
                        ),
                      )
                    ]),
                    Container(
                      margin: const EdgeInsets.only(left: 24, top: 32),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const CustomBottomNavbar()));
                        },
                        child: SvgPicture.asset(
                          iconDetailBack,
                          height: 32,
                          width: 32,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 24, top: 325),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text('Sawah Telkom',
                                style: TextStyle(
                                    color: neutral_10,
                                    fontSize: 32,
                                    fontWeight: bold)),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: primary_40,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Text(
                              'Category 1',
                              style: TextStyle(fontSize: 14, color: neutral_10),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // DETAIL
                      SizedBox(
                        height: 24,
                      ),
                      // ABOUT
                      Text("About", style: text_xl_bold),
                      SizedBox(
                        height: 16,
                      ),

                      // DESC
                      new CustomDescription(text: desc),
                      SizedBox(
                        height: 16,
                      ),

                      // LOCATION
                      Row(
                        children: [
                          SvgPicture.asset(
                            iconLocation,
                            height: 32,
                            width: 32,
                            fit: BoxFit.scaleDown,
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 8),
                              child: Text("Jl. Sukabirus, Bojongsoang, Bandung",
                                  style: text_base)),
                        ],
                      ),
                      // TIME
                      Row(
                        children: [
                          SvgPicture.asset(
                            iconClock,
                            height: 32,
                            width: 32,
                            fit: BoxFit.scaleDown,
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 8),
                              child: Text("10.00 WIB", style: text_base)),
                        ],
                      ),
                    ],
                  ),
                ),
                // MORE INFO
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Available ticket',
                            style: TextStyle(fontSize: 12, color: neutral_40),
                          ),
                        ),
                        Text(
                          '300',
                          style: TextStyle(fontSize: 24, color: neutral_60),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        color: neutral_40,
                        height: 48,
                        width: 1,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Ticket Price',
                            style: TextStyle(fontSize: 12, color: neutral_40),
                          ),
                        ),
                        Text(
                          'Rp. 150.000',
                          style: TextStyle(fontSize: 23, color: neutral_60),
                        )
                      ],
                    ),
                  ],
                ),

                // BUTTON
                SizedBox(
                  height: 24,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const CheckoutPage()));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(primary_40),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Buy Now",
                          style: text_base_bold,
                        ),
                      ),
                    ),
                  ),
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

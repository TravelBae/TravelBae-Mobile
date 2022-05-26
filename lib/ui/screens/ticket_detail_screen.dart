import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelbae_android/styleGuide.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelbae_android/ui/widgets/custom_bottom_navbar.dart';
import 'package:travelbae_android/ui/widgets/custom_dropdown.dart';
import 'package:travelbae_android/ui/screens/my_order_screen.dart';

class TicketDetailPage extends StatefulWidget {
  const TicketDetailPage({Key? key}) : super(key: key);

  @override
  State<TicketDetailPage> createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {
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

                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CustomBottomNavbar()));
                  },
                  child: SvgPicture.asset(
                    iconBack,
                    height: 32,
                    width: 32,
                    fit: BoxFit.scaleDown,
                  ),
                ),

                SizedBox(
                  height: 16,
                ),

                // HEADER
                Text("Ticket Detail", style: text_lg_bold),
                SizedBox(
                  height: 32,
                ),

                Text("Ticket", style: text_base_bold),
                SizedBox(
                  height: 8,
                ),
                // CARD LIST
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: neutral_20,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.only(bottom: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Sawah Telkom",
                                      style: text_base_bold,
                                    ),
                                    Text(
                                      "Rp 150.000",
                                      style: text_base,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      iconMinus,
                                      height: 32,
                                      width: 32,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    Text(
                                      "2",
                                      style: text_base_bold,
                                    ),
                                    SvgPicture.asset(
                                      iconPlus,
                                      height: 32,
                                      width: 32,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text("Metode Pembayaran", style: text_base_bold),
                      SizedBox(
                        height: 8,
                      ),
                      CustomDropdown(),
                      Text("Detail", style: text_base_bold),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Sawah Telkom", style: text_base),
                                  Text("Rp 150.000", style: text_base),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Qty", style: text_base),
                                  Text("2", style: text_base),
                                ],
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 172,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total", style: text_base_bold),
                          Text("Rp 150.000",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: bold,
                                  color: primary_40)),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

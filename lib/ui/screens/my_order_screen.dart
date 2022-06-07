//Import library
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelbae_android/styleGuide.dart';

//Import models
import 'package:travelbae_android/models/user_model.dart';

//Import Screen
import 'package:travelbae_android/ui/screens/ticket_detail_screen.dart';

class MyOrderPage extends StatefulWidget {
  User user;
  String token;
  MyOrderPage({required this.user, required this.token, Key? key})
      : super(key: key);

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
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
                  height: 52,
                ),

                // HEADER
                Text("My Ticket", style: text_lg_bold),
                SizedBox(
                  height: 32,
                ),

                // CARD LIST
                SingleChildScrollView(
                  child: Column(
                    children: [
                      CardTourPlace(context, widget.user, widget.token),
                      CardTourPlace(context, widget.user, widget.token),
                      CardTourPlace(context, widget.user, widget.token),
                      CardTourPlace(context, widget.user, widget.token),
                      CardTourPlace(context, widget.user, widget.token),
                      CardTourPlace(context, widget.user, widget.token),
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

Widget CardTourPlace(BuildContext context, User user, String token) {
  return Container(
    decoration: BoxDecoration(
      color: neutral_20,
      borderRadius: BorderRadius.circular(16),
    ),
    padding: EdgeInsets.all(12),
    margin: EdgeInsets.only(bottom: 24),
    child: GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TicketDetailPage(
                  user: user,
                  token: token,
                )));
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    ticket,
                    height: 24,
                    width: 24,
                    fit: BoxFit.scaleDown,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Order ID:",
                    style: text_base_bold,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "ID_203",
                    style: text_base,
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: neutral_40,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.all(4),
                child: Text(
                  "Pending",
                  style: TextStyle(color: neutral_10),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: neutral_30, width: 1))),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Nama Tempat",
                style: text_lg_bold,
              ),
              Text(
                "Tanggal",
                style: text_sm,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

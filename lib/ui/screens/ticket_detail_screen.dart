//Import library
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelbae_android/styleGuide.dart';

//Import models
import 'package:travelbae_android/models/user_model.dart';

//Import Widget
import 'package:travelbae_android/ui/widgets/custom_bottom_navbar.dart';
import 'package:travelbae_android/ui/widgets/custom_dropdown.dart';

class TicketDetailPage extends StatefulWidget {
  User user;
  String token;
  TicketDetailPage({required this.user, required this.token, Key? key})
      : super(key: key);

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
                      builder: (context) => CustomBottomNavbar(
                            pageindex: 1,
                            user: widget.user,
                            token: widget.token,
                          )));
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

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: neutral_20,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: primary_40,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              topLeft: Radius.circular(8),
                            ),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sawah Telkom",
                                style: TextStyle(
                                  color: neutral_10,
                                  fontSize: 20,
                                  fontWeight: bold,
                                ),
                              ),
                              Text(
                                "Rp 150.000",
                                style: TextStyle(color: neutral_10),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Text("Payment Detail", style: text_base_bold),
              SizedBox(
                height: 12,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Sawah Telkom", style: text_base),
                          Text("Rp 150.000", style: text_base_bold),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Qty", style: text_base),
                          Text("2", style: text_base_bold),
                        ],
                      ),
                      Divider(color: neutral_50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Pembayaran", style: text_base),
                          Text("Rp 300.000", style: text_base_bold),
                        ],
                      ),
                    ],
                  )),
              SizedBox(
                height: 16,
              ),
              Text("Payment Method", style: text_base_bold),
              Container(
                margin: EdgeInsets.all(12),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      iconCard,
                      height: 24,
                      width: 24,
                      fit: BoxFit.scaleDown,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Bank Mandiri",
                      style: text_base,
                    ),
                  ],
                ),
              ),
              Text("Regulation", style: text_base_bold),
              SizedBox(
                height: 4,
              ),
              Text(
                  "Untuk kenyamanan pengunjung, maka kami menyarankan beberapa hal seperti berikut.",
                  style: TextStyle(color: neutral_40, fontSize: 12)),
              SizedBox(
                height: 12,
              ),
              Text(
                  "1. Membuang Sampah Pada Tempatnya. 2. Tidak Melakukan Tindakan Asusila. ",
                  style: text_base),
            ],
          ),
        ),
      ),
    );
  }
}

//Import library
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelbae_android/styleGuide.dart';

//Import models
import 'package:travelbae_android/models/tourplace_model.dart';
import 'package:travelbae_android/models/user_model.dart';

//Import Screen
import 'package:travelbae_android/ui/screens/success_screen.dart';

//Import Widget
import 'package:travelbae_android/ui/widgets/custom_dropdown.dart';

class TourplaceCheckoutPage extends StatefulWidget {
  User user;
  String token;
  Tourplace tourplace;
  TourplaceCheckoutPage(
      {required this.user,
      required this.token,
      required this.tourplace,
      Key? key})
      : super(key: key);

  @override
  State<TourplaceCheckoutPage> createState() => _TourplaceCheckoutPageState();
}

class _TourplaceCheckoutPageState extends State<TourplaceCheckoutPage> {
  int _itemCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity, // container full
          margin: const EdgeInsets.symmetric(horizontal: 24),
          color: neutral_10,
          child: SingleChildScrollView(
            child: Column(
              //---TINGGAL EDIT DIBAWAH SINI---
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  height: 16,
                ),

                // HEADER
                Text("Checkout", style: text_lg_bold),
                const SizedBox(
                  height: 32,
                ),

                Text("Ticket", style: text_base_bold),
                const SizedBox(
                  height: 8,
                ),
                // CARD LIST
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: neutral_20,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(bottom: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 235,
                                          child: Text(
                                            widget.tourplace.nama_tempat,
                                            style: text_base_bold,
                                          ),
                                        ),
                                        Text(
                                          "Rp " +
                                              widget.tourplace.harga.toString(),
                                          style: text_base,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () =>
                                              setState(() => _itemCount--),
                                          child: SvgPicture.asset(
                                            iconMinus,
                                            height: 32,
                                            width: 32,
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                        Text(
                                          _itemCount.toString(),
                                          style: text_base_bold,
                                        ),
                                        GestureDetector(
                                          onTap: () =>
                                              setState(() => _itemCount++),
                                          child: SvgPicture.asset(
                                            iconPlus,
                                            height: 32,
                                            width: 32,
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Text("Metode Pembayaran", style: text_base_bold),
                          const SizedBox(
                            height: 8,
                          ),
                          const CustomDropdown(),
                          Text("Detail", style: text_base_bold),
                          const SizedBox(
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
                                      SizedBox(
                                        width: 235,
                                        child: Text(
                                            widget.tourplace.nama_tempat,
                                            style: text_base),
                                      ),
                                      Text(
                                          "Rp " +
                                              widget.tourplace.harga.toString(),
                                          style: text_base),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Qty", style: text_base),
                                      Text(_itemCount.toString(),
                                          style: text_base),
                                    ],
                                  ),
                                ],
                              )),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 130,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total", style: text_base_bold),
                              Text(
                                  "Rp " +
                                      (widget.tourplace.harga * _itemCount)
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: bold,
                                      color: primary_40)),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SuccessScreen(
                                          user: widget.user,
                                          token: widget.token,
                                        )));
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(primary_40),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  "Checkout",
                                  style: text_base_bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                        ],
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

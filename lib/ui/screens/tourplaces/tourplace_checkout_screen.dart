//Import library
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelbae_android/styleGuide.dart';
import 'package:intl/intl.dart';

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
  String dropdownValue = 'Mandiri';
  String holder = '';
  List<String> dropList = ['Mandiri', 'Gopay', 'Shopeepay', 'BCA'];
  void getDropDownItem() {
    setState(() {
      holder = dropdownValue;
    });
  }

  int _itemCount = 0;
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');

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
                                          '${formatCurrency.format(widget.tourplace.harga)}',
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
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: neutral_40, width: 1),
                            ),
                            padding: EdgeInsets.only(left: 12),
                            width: double.infinity,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  iconCard,
                                  height: 24,
                                  width: 24,
                                  fit: BoxFit.scaleDown,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: dropdownValue,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                      });
                                    },
                                    items: dropList
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
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
                                        width: 200,
                                        child: Text(
                                            widget.tourplace.nama_tempat,
                                            style: text_base),
                                      ),
                                      Text(
                                          '${formatCurrency.format(widget.tourplace.harga)}',
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
                            height: 180,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total", style: text_base_bold),
                              Text(
                                  '${formatCurrency.format(widget.tourplace.harga * _itemCount)}',
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
                              onPressed: _itemCount != 0
                                  ? () {
                                      checkout(
                                          widget.user,
                                          widget.token,
                                          widget.tourplace.id,
                                          1,
                                          (widget.tourplace.harga * _itemCount),
                                          _itemCount,
                                          dropdownValue);
                                    }
                                  : () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: const Text(
                                          "Minimum order is one (1) ticket",
                                          style: TextStyle(color: neutral_10),
                                        ),
                                        backgroundColor: danger_30,
                                      ));
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

  Future<void> checkout(User user, String token, int id_tempat, int id_event,
      int total_bayar, int total_tiket, String bank) async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    var response = await http.post(
        Uri.parse(
          "http://10.0.2.2:8000/api/customer/order/create",
        ),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token
        },
        body: ({
          "id_customer": user.id.toString(),
          "id_tempat": id_tempat.toString(),
          "id_event": id_event.toString(),
          "nama_customer": user.username,
          "order_status": "Unconfirmed",
          "tanggal_beli": formatted,
          "total_bayar": total_bayar.toString(),
          "total_tiket": total_tiket.toString(),
          "bank": bank
        }));
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SuccessScreen(
                token: token,
                user: user,
              )));
    } else if (response.statusCode == 422) {
      final data = jsonDecode(response.body);
      String errmsg = data['message'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          errmsg,
          style: TextStyle(color: neutral_10),
        ),
        backgroundColor: danger_30,
      ));
    } else {
      print(response.statusCode);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          "Something unexpected happened, please try again",
          style: TextStyle(color: neutral_10),
        ),
        backgroundColor: danger_30,
      ));
    }
  }
}

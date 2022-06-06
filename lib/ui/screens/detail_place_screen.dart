import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelbae_android/styleGuide.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelbae_android/ui/widgets/custom_description.dart';
import 'package:travelbae_android/ui/screens/checkout_screen.dart';
import 'package:travelbae_android/models/tourplace_model.dart';

class DetailPlacePage extends StatefulWidget {
  Tourplace tourplace;
  DetailPlacePage({required this.tourplace, Key? key}) : super(key: key);

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
                      Image.network(
                        widget.tourplace.img_tempat,
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
                          Navigator.of(context).pop();
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
                      margin: const EdgeInsets.only(left: 24, top: 300),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(widget.tourplace.nama_tempat,
                                style: TextStyle(
                                    color: neutral_10,
                                    fontSize: 32,
                                    fontWeight: bold)),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                color: primary_40,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Text(
                              widget.tourplace.kategori.toString(),
                              style: const TextStyle(
                                  fontSize: 14, color: neutral_10),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // DETAIL
                      const SizedBox(
                        height: 24,
                      ),
                      // ABOUT
                      Text("About", style: text_xl_bold),
                      const SizedBox(
                        height: 16,
                      ),

                      // DESC
                      CustomDescription(text: widget.tourplace.deskripsi),
                      const SizedBox(
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
                              padding: const EdgeInsets.only(left: 8),
                              child: SizedBox(
                                width: 320,
                                child: Text(widget.tourplace.alamat,
                                    style: text_base),
                              )),
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
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                  widget.tourplace.jambuka.substring(0, 5) +
                                      ' WIB',
                                  style: text_base)),
                        ],
                      ),
                    ],
                  ),
                ),
                // MORE INFO
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: const Text(
                            'Available ticket',
                            style: TextStyle(fontSize: 12, color: neutral_40),
                          ),
                        ),
                        Text(
                          widget.tourplace.stoktiket.toString(),
                          style:
                              const TextStyle(fontSize: 24, color: neutral_60),
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
                          child: const Text(
                            'Ticket Price',
                            style: TextStyle(fontSize: 12, color: neutral_40),
                          ),
                        ),
                        Text(
                          'Rp ' + widget.tourplace.harga.toString(),
                          style:
                              const TextStyle(fontSize: 23, color: neutral_60),
                        )
                      ],
                    ),
                  ],
                ),

                // BUTTON
                const SizedBox(
                  height: 24,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
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
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          "Buy Now",
                          style: text_base_bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
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

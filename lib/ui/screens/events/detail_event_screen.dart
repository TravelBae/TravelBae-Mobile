//Import library
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelbae_android/styleGuide.dart';
import 'package:intl/intl.dart';

//Import models
import 'package:travelbae_android/models/event_model.dart';
import 'package:travelbae_android/models/user_model.dart';

//Import Screen
import 'package:travelbae_android/ui/screens/events/event_checkout_screen.dart';

//Import Widget
import 'package:travelbae_android/ui/widgets/custom_description.dart';

class DetailEventPage extends StatefulWidget {
  User user;
  String token;
  Event event;
  DetailEventPage(
      {required this.user, required this.token, required this.event, Key? key})
      : super(key: key);

  @override
  State<DetailEventPage> createState() => _DetailEventPageState();
}

class _DetailEventPageState extends State<DetailEventPage> {
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
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
                        widget.event.img_tempat,
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
                            child: Text(widget.event.nama_event,
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
                              widget.event.tipe.toString(),
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
                      Text("Regulasi", style: text_xl_bold),
                      const SizedBox(
                        height: 16,
                      ),

                      // DESC
                      CustomDescription(text: widget.event.regulasi),
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
                                width: 300,
                                child:
                                    Text(widget.event.alamat, style: text_base),
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
                                  widget.event.jammulai.substring(0, 5) +
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
                          widget.event.stok.toString(),
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
                          '${formatCurrency.format(widget.event.harga)}',
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
                        widget.event.stok == 0
                            ? null
                            : Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EventCheckoutPage(
                                      event: widget.event,
                                      user: widget.user,
                                      token: widget.token,
                                    )));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          widget.event.stok != 0 ? primary_40 : neutral_30,
                        ),
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

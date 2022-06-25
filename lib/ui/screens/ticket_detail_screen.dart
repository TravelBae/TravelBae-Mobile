//Import library
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelbae_android/styleGuide.dart';

//Import models
import 'package:travelbae_android/models/tourplace_model.dart';
import 'package:travelbae_android/models/event_model.dart';
import 'package:travelbae_android/models/user_model.dart';
import 'package:travelbae_android/models/order_model.dart';

//Import Widget
import 'package:travelbae_android/ui/widgets/custom_bottom_navbar.dart';

Future<List<Tourplace>> fetchTourplace(http.Client client, String token) async {
  final response = await client
      .get(Uri.parse('http://10.0.2.2:8000/api/tourplaces'), headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer ' + token
  });
  return compute(parseTourplace, response.body);
}

Future<List<Event>> fetchEvent(http.Client client, String token) async {
  final response = await client.get(Uri.parse('http://10.0.2.2:8000/api/event'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token
      });
  return compute(parseEvent, response.body);
}

List<Tourplace> parseTourplace(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Tourplace>((json) => Tourplace.fromJson(json)).toList();
}

List<Event> parseEvent(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Event>((json) => Event.fromJson(json)).toList();
}

class TicketDetailPage extends StatefulWidget {
  User user;
  int index;
  String token;
  String type;
  Order order;

  TicketDetailPage(
      {required this.user,
      required this.token,
      required this.index,
      required this.type,
      required this.order,
      Key? key})
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
          margin: const EdgeInsets.symmetric(horizontal: 24),
          color: neutral_10,
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

              const SizedBox(
                height: 16,
              ),

              // HEADER
              Text("Ticket Detail", style: text_lg_bold),
              const SizedBox(
                height: 32,
              ),

              widget.type == "Event"
                  ? FutureBuilder<List<Event>>(
                      future: fetchEvent(http.Client(), widget.token),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('An error has occurred!'),
                          );
                        } else if (snapshot.hasData) {
                          return TicketDetail(
                              user: widget.user,
                              token: widget.token,
                              order: widget.order,
                              tipe: widget.type,
                              nama: snapshot
                                  .data![widget.order.id_event - 1].nama_event,
                              bank: widget.order.bank);
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                  : FutureBuilder<List<Tourplace>>(
                      future: fetchTourplace(http.Client(), widget.token),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('An error has occurred!'),
                          );
                        } else if (snapshot.hasData) {
                          return TicketDetail(
                              user: widget.user,
                              token: widget.token,
                              order: widget.order,
                              tipe: widget.type,
                              nama: snapshot.data![widget.order.id_tempat - 1]
                                  .nama_tempat,
                              bank: widget.order.bank);
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class TicketDetail extends StatefulWidget {
  User user;
  String token;
  Order order;
  String tipe;
  String nama;
  String bank;
  TicketDetail(
      {key,
      required this.user,
      required this.token,
      required this.order,
      required this.tipe,
      required this.nama,
      required this.bank});

  @override
  State<TicketDetail> createState() => _TicketDetailState();
}

class _TicketDetailState extends State<TicketDetail> {
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
                      decoration: const BoxDecoration(
                        color: primary_40,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(8),
                        ),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.nama,
                            style: TextStyle(
                              color: neutral_10,
                              fontSize: 20,
                              fontWeight: bold,
                            ),
                          ),
                          Text(
                            formatCurrency.format(widget.order.total_bayar /
                                widget.order.total_tiket),
                            style: const TextStyle(color: neutral_10),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Order ID:",
                                style: text_base_bold,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "ID_" + widget.order.id.toString(),
                                style: text_base,
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: widget.order.order_status == "Unconfirmed"
                                  ? neutral_40
                                  : success_30,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              widget.order.order_status,
                              style: const TextStyle(color: neutral_10),
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
          const SizedBox(
            height: 16,
          ),
          Text("Payment Detail", style: text_base_bold),
          const SizedBox(
            height: 12,
          ),
          Container(
              margin: const EdgeInsets.only(left: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.nama, style: text_base),
                      Text(
                          formatCurrency.format(widget.order.total_bayar /
                              widget.order.total_tiket),
                          style: text_base_bold),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Qty", style: text_base),
                      Text(widget.order.total_tiket.toString(),
                          style: text_base_bold),
                    ],
                  ),
                  const Divider(color: neutral_50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Pembayaran", style: text_base),
                      Text(formatCurrency.format(widget.order.total_bayar),
                          style: text_base_bold),
                    ],
                  ),
                ],
              )),
          const SizedBox(
            height: 16,
          ),
          Text("Payment Method", style: text_base_bold),
          Container(
            margin: const EdgeInsets.all(12),
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
                Text(
                  widget.bank,
                  style: text_base,
                ),
              ],
            ),
          ),
        ]);
  }
}

//Import library
import 'dart:convert';
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

//Import Screen
import 'package:travelbae_android/ui/screens/ticket_detail_screen.dart';

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

Future<List<Order>> fetchCustOrder(http.Client client, String token) async {
  final response = await client.get(
      Uri.parse('http://10.0.2.2:8000/api/customer/order/show_cus'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token
      });
  return compute(parseCustOrder, response.body);
}

List<Tourplace> parseTourplace(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Tourplace>((json) => Tourplace.fromJson(json)).toList();
}

List<Event> parseEvent(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Event>((json) => Event.fromJson(json)).toList();
}

List<Order> parseCustOrder(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Order>((json) => Order.fromJson(json)).toList();
}

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
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCustOrder(http.Client(), widget.token);
  }

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
                  height: 52,
                ),

                // HEADER
                Text("My Ticket", style: text_lg_bold),
                const SizedBox(
                  height: 32,
                ),

                // CARD LIST
                FutureBuilder<List<Order>>(
                  future: fetchCustOrder(http.Client(), widget.token),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return const Center(
                        child: Text('An error has occurred!'),
                      );
                    } else if (snapshot.hasData) {
                      return Center(
                        // child: CircularProgressIndicator(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 32,
                            ),
                            Image.asset(
                              'asets/illus/illus-5.png',
                              height: 272,
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Text(
                              "Looks like you haven't made your order yet",
                              style: text_lg_bold,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return CardTicket(
                        orders: snapshot.data!,
                        user: widget.user,
                        token: widget.token,
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardTicket extends StatefulWidget {
  User user;
  String token;
  CardTicket({
    key,
    required this.orders,
    required this.user,
    required this.token,
  });

  final List<Order> orders;

  @override
  State<CardTicket> createState() => _CardTicketState();
}

class _CardTicketState extends State<CardTicket> {
  late String nama;
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      SizedBox(
        height: 250,
        child: ListView.builder(
            itemCount: widget.orders.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: widget.orders[index].id_event != 9999
                          ? (context) => TicketDetailPage(
                                user: widget.user,
                                token: widget.token,
                                type: "Event",
                                index: widget.orders[index].id_event,
                                order: widget.orders[index],
                              )
                          : (context) => TicketDetailPage(
                                user: widget.user,
                                token: widget.token,
                                type: "Tourplace",
                                index: widget.orders[index].id_tempat,
                                order: widget.orders[index],
                              )));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: neutral_20,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 24),
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
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Order ID:",
                                style: text_base_bold,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "ID_" + widget.orders[index].id.toString(),
                                style: text_base,
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: widget.orders[index].order_status ==
                                      "unconfirmed"
                                  ? neutral_40
                                  : success_30,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              widget.orders[index].order_status,
                              style: const TextStyle(color: neutral_10),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 12),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: neutral_30, width: 1))),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widget.orders[index].id_event != 9999
                              ? FutureBuilder<List<Event>>(
                                  future:
                                      fetchEvent(http.Client(), widget.token),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return const Center(
                                        child: Text('An error has occurred!'),
                                      );
                                    } else if (snapshot.hasData) {
                                      return snapshot
                                                  .data![widget.orders[index]
                                                          .id_event -
                                                      1]
                                                  .nama_event
                                                  .length <
                                              23
                                          ? Text(
                                              snapshot
                                                  .data![widget.orders[index]
                                                          .id_event -
                                                      1]
                                                  .nama_event,
                                              style: text_lg_bold,
                                            )
                                          : Text(
                                              snapshot
                                                      .data![widget
                                                              .orders[index]
                                                              .id_event -
                                                          1]
                                                      .nama_event
                                                      .substring(0, 19) +
                                                  "...",
                                              style: text_lg_bold,
                                            );
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                )
                              : FutureBuilder<List<Tourplace>>(
                                  future: fetchTourplace(
                                      http.Client(), widget.token),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return const Center(
                                        child: Text('An error has occurred!'),
                                      );
                                    } else if (snapshot.hasData) {
                                      return snapshot
                                                  .data![widget.orders[index]
                                                          .id_tempat -
                                                      1]
                                                  .nama_tempat
                                                  .length <
                                              23
                                          ? Text(
                                              snapshot
                                                  .data![widget.orders[index]
                                                          .id_tempat -
                                                      1]
                                                  .nama_tempat,
                                              style: text_lg_bold,
                                            )
                                          : Text(
                                              snapshot
                                                      .data![widget
                                                              .orders[index]
                                                              .id_tempat -
                                                          1]
                                                      .nama_tempat
                                                      .substring(0, 19) +
                                                  "...",
                                              style: text_lg_bold,
                                            );
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                          Text(
                            widget.orders[index].tanggal_beli,
                            style: text_sm,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    ]);
  }
}

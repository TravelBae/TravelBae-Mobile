import 'package:flutter/cupertino.dart';
import 'package:travelbae_android/models/tourplace_model.dart';
import 'package:travelbae_android/models/event_model.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:travelbae_android/styleGuide.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelbae_android/ui/screens/detail_place_screen.dart';
import 'package:travelbae_android/ui/screens/explore_dest_screen.dart';

Future<List<Tourplace>> fetchTourplace(http.Client client, String token) async {
  final response = await client
      .get(Uri.parse('http://10.0.2.2:8000/api/tourplaces'), headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer ' + token
  });
  return compute(parseTourplace, response.body);
}

Future<List<Event>> fetchEvent(http.Client client, String token) async {
  final response = await client
      .get(Uri.parse('http://10.0.2.2:8000/api/tourplaces'), headers: {
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

class HomeScreen extends StatefulWidget {
  String username;
  String token;
  HomeScreen({required this.username, required this.token, Key? key})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

                // HEADER
                Text("Welcome!", style: text_base_bold),
                Text(widget.username, style: text_2xl_bold),
                const SizedBox(
                  height: 32,
                ),

                // BUTTON EXPLORE
                SizedBox(
                  width: double.infinity,
                  height: 81,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const ExploreDestinationPage()));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(primary_40),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16))))),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Explore More",
                                style: text_xl_bold,
                              ),
                              Text(
                                "Get ticket recomendation from us ",
                                style: text_xs,
                              ),
                            ],
                          ),
                          SizedBox(
                            child: Container(
                              height: 36,
                              width: 36,
                              decoration: const BoxDecoration(
                                color: neutral_10,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                arrowRight,
                                height: 12,
                                width: 12,
                                color: primary_40,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),

                // SEARCH FIELD
                SizedBox(
                  height: 56,
                  child: TextField(
                    style: text_base,
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: const TextStyle(color: neutral_40),
                      filled: true,
                      fillColor: neutral_20,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: neutral_10),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),

                // CATEGORY
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "category1",
                        style: text_base,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "category1",
                        style: text_base,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "category1",
                        style: text_base,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "category1",
                        style: text_base,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),

                // CARD RECOMENDATION
                FutureBuilder<List<Tourplace>>(
                  future: fetchTourplace(http.Client(), widget.token),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('An error has occurred!'),
                      );
                    } else if (snapshot.hasData) {
                      return TourplaceCard(tourplaces: snapshot.data!);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),

                const SizedBox(
                  height: 24,
                ),

                // EXPLORE MORE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Newest Event",
                      style: text_xl_bold,
                    ),
                    Text(
                      "See all",
                      style: text_xs,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                FutureBuilder<List<Event>>(
                  future: fetchEvent(http.Client(), widget.token),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('An error has occurred!'),
                      );
                    } else if (snapshot.hasData) {
                      return EventList(events: snapshot.data!);
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
      ),
    );
  }
}

class EventList extends StatelessWidget {
  const EventList({key, required this.events});

  final List<Event> events;
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      SizedBox(
        height: 250,
        child: ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 72,
                            width: 72,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: primary_30,
                            ),
                            child: Image.network(
                              events[index].img_tempat,
                              height: 200,
                              width: 220,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: events[index].nama_event.length < 28
                                  ? Text(
                                      events[index].nama_event,
                                      style: text_base_bold,
                                    )
                                  : Text(
                                      events[index]
                                              .nama_event
                                              .substring(0, 23) +
                                          '...',
                                      style: text_base_bold,
                                    )),
                          Container(
                            child: events[index].alamat.length < 43
                                ? Text(
                                    events[index].alamat,
                                    style: const TextStyle(
                                      color: neutral_40,
                                    ),
                                  )
                                : Text(
                                    events[index].alamat.substring(0, 38) +
                                        '...',
                                    style: const TextStyle(
                                      color: neutral_40,
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              );
            }),
      ),
    ]);
  }
}

class TourplaceCard extends StatelessWidget {
  const TourplaceCard({key, required this.tourplaces});

  final List<Tourplace> tourplaces;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 290,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tourplaces.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: neutral_30, width: 1),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailPlacePage(
                                tourplace: tourplaces[index],
                              )));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Image.network(
                            tourplaces[index].img_tempat,
                            height: 200,
                            width: 220,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child:
                                      tourplaces[index].nama_tempat.length < 28
                                          ? Text(
                                              tourplaces[index].nama_tempat,
                                              style: text_base_bold,
                                            )
                                          : Text(
                                              tourplaces[index]
                                                      .nama_tempat
                                                      .substring(0, 23) +
                                                  '...',
                                              style: text_base_bold,
                                            )),
                              Container(
                                child: tourplaces[index].alamat.length < 28
                                    ? Text(
                                        tourplaces[index].alamat,
                                        style: const TextStyle(
                                          color: neutral_40,
                                        ),
                                      )
                                    : Text(
                                        tourplaces[index]
                                                .alamat
                                                .substring(0, 28) +
                                            '...',
                                        style: const TextStyle(
                                          color: neutral_40,
                                        ),
                                      ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}

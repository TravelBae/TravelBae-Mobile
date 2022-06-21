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

//Import Screen
import 'package:travelbae_android/ui/screens/tourplaces/detail_place_screen.dart';
import 'package:travelbae_android/ui/screens/events/detail_event_screen.dart';
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

class HomeScreen extends StatefulWidget {
  User user;
  String token;
  HomeScreen({required this.user, required this.token, Key? key})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool activecategory = true;
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
                Text(widget.user.username, style: text_2xl_bold),
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
                          builder: (context) => ExploreDestinationPage(
                              user: widget.user, token: widget.token)));
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
                  height: 12,
                ),
                // Event
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tourplaces",
                      style: text_xl_bold,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
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
                      return TourplaceCard(
                        tourplaces: snapshot.data!,
                        user: widget.user,
                        token: widget.token,
                      );
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

                // Event
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Events",
                      style: text_xl_bold,
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
                      return EventList(
                        events: snapshot.data!,
                        user: widget.user,
                        token: widget.token,
                      );
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

class EventList extends StatefulWidget {
  User user;
  String token;
  EventList({
    key,
    required this.events,
    required this.user,
    required this.token,
  });

  final List<Event> events;

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      SizedBox(
        height: 250,
        child: ListView.builder(
            itemCount: widget.events.length - 1,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailEventPage(
                            event: widget.events[index + 1],
                            user: widget.user,
                            token: widget.token,
                          )));
                },
                child: Column(
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  widget.events[index + 1].img_tempat,
                                  height: 200,
                                  width: 220,
                                  fit: BoxFit.cover,
                                ),
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
                                child:
                                    widget.events[index + 1].nama_event.length <
                                            28
                                        ? Text(
                                            widget.events[index + 1].nama_event,
                                            style: text_base_bold,
                                          )
                                        : Text(
                                            widget.events[index + 1].nama_event
                                                    .substring(0, 23) +
                                                '...',
                                            style: text_base_bold,
                                          )),
                            const SizedBox(
                              height: 4,
                            ),
                            Container(
                              child: widget.events[index + 1].alamat.length < 38
                                  ? Text(
                                      widget.events[index + 1].alamat,
                                      style: const TextStyle(
                                        color: neutral_40,
                                      ),
                                    )
                                  : Text(
                                      widget.events[index + 1].alamat
                                              .substring(0, 34) +
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
                ),
              );
            }),
      ),
    ]);
  }
}

class TourplaceCard extends StatefulWidget {
  User user;
  String token;
  TourplaceCard({
    key,
    required this.tourplaces,
    required this.user,
    required this.token,
  });

  final List<Tourplace> tourplaces;
  late List<Tourplace> foundtourplaces = [];

  @override
  State<TourplaceCard> createState() => _TourplaceCardState();
}

class _TourplaceCardState extends State<TourplaceCard> {
  @override
  initState() {
    widget.foundtourplaces = widget.tourplaces;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Tourplace> results = [];
    if (enteredKeyword.isEmpty) {
      results = widget.tourplaces;
    } else {
      results = widget.tourplaces
          .where((user) => user.nama_tempat
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      widget.foundtourplaces = results;
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // SEARCH FIELD
        SizedBox(
          height: 56,
          child: TextField(
            onChanged: (value) => _runFilter(value),
            style: text_base,
            decoration: InputDecoration(
              hintText: "Search Tourplace...",
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
          height: 12,
        ),
        SizedBox(
          height: 290,
          child: widget.foundtourplaces.isNotEmpty
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.foundtourplaces[0].id != 1
                      ? widget.foundtourplaces.length
                      : widget.foundtourplaces.length - 1,
                  itemBuilder: (context, index) {
                    return widget.foundtourplaces[0].id != 1
                        ? Card(
                            shape: RoundedRectangleBorder(
                              side:
                                  const BorderSide(color: neutral_30, width: 1),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailPlacePage(
                                        tourplace:
                                            widget.foundtourplaces[index],
                                        user: widget.user,
                                        token: widget.token)));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16)),
                                    child: Image.network(
                                      widget.foundtourplaces[index].img_tempat,
                                      height: 200,
                                      width: 220,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            child: widget.foundtourplaces[index]
                                                        .nama_tempat.length <
                                                    28
                                                ? Text(
                                                    widget
                                                        .foundtourplaces[index]
                                                        .nama_tempat,
                                                    style: text_base_bold,
                                                  )
                                                : Text(
                                                    widget
                                                            .foundtourplaces[
                                                                index]
                                                            .nama_tempat
                                                            .substring(0, 23) +
                                                        '...',
                                                    style: text_base_bold,
                                                  )),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          child: widget.foundtourplaces[index]
                                                      .alamat.length <
                                                  28
                                              ? Text(
                                                  widget.foundtourplaces[index]
                                                      .alamat,
                                                  style: const TextStyle(
                                                    color: neutral_40,
                                                  ),
                                                )
                                              : Text(
                                                  widget.foundtourplaces[index]
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
                          )
                        : Card(
                            shape: RoundedRectangleBorder(
                              side:
                                  const BorderSide(color: neutral_30, width: 1),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailPlacePage(
                                        tourplace:
                                            widget.foundtourplaces[index + 1],
                                        user: widget.user,
                                        token: widget.token)));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16)),
                                    child: Image.network(
                                      widget.foundtourplaces[index + 1]
                                          .img_tempat,
                                      height: 200,
                                      width: 220,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            child: widget
                                                        .foundtourplaces[
                                                            index + 1]
                                                        .nama_tempat
                                                        .length <
                                                    28
                                                ? Text(
                                                    widget
                                                        .foundtourplaces[
                                                            index + 1]
                                                        .nama_tempat,
                                                    style: text_base_bold,
                                                  )
                                                : Text(
                                                    widget
                                                            .foundtourplaces[
                                                                index + 1]
                                                            .nama_tempat
                                                            .substring(0, 23) +
                                                        '...',
                                                    style: text_base_bold,
                                                  )),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          child:
                                              widget.foundtourplaces[index + 1]
                                                          .alamat.length <
                                                      28
                                                  ? Text(
                                                      widget
                                                          .foundtourplaces[
                                                              index + 1]
                                                          .alamat,
                                                      style: const TextStyle(
                                                        color: neutral_40,
                                                      ),
                                                    )
                                                  : Text(
                                                      widget
                                                              .foundtourplaces[
                                                                  index + 1]
                                                              .alamat
                                                              .substring(
                                                                  0, 28) +
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
                  })
              : ListView(scrollDirection: Axis.horizontal, children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: neutral_30, width: 1),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16)),
                          child: Image.asset(
                            'asets/Logo.png',
                            height: 200,
                            width: 220,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: Text(
                                "No tourplaces found!",
                                style: text_base_bold,
                              )),
                              const SizedBox(
                                height: 4,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
        ),
      ],
    );
  }
}

//Import library
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelbae_android/styleGuide.dart';

//Import Screen
import 'package:travelbae_android/ui/screens/events/detail_event_screen.dart';
import 'package:travelbae_android/ui/screens/explore_category_screen.dart';
import 'package:travelbae_android/ui/screens/tourplaces/detail_place_screen.dart';
import 'package:travelbae_android/ui/widgets/custom_bottom_navbar.dart';
import 'package:travelbae_android/ui/screens/explore_dest_screen.dart';

//Import models
import 'package:travelbae_android/models/tourplace_model.dart';
import 'package:travelbae_android/models/event_model.dart';
import 'package:travelbae_android/models/user_model.dart';

class RecomendationScreen extends StatefulWidget {
  User user;
  String token;
  String type;
  String kategori;
  int budget;
  RecomendationScreen(
      {required this.type,
      required this.kategori,
      required this.budget,
      required this.token,
      required this.user,
      Key? key})
      : super(key: key);

  @override
  State<RecomendationScreen> createState() => _RecomendationScreenState();
}

class _RecomendationScreenState extends State<RecomendationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 24),
          color: neutral_10,
          child: Column(
            //---TINGGAL EDIT DIBAWAH SINI---
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 32,
              ),
              Container(
                alignment: Alignment.topLeft,
              ),
              SizedBox(
                height: 66,
              ),
              Text("Here’s what we recommend for you!", style: text_2xl_bold),
              SizedBox(
                height: 72,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: widget.type == "Tourplace"
                          ? FutureBuilder<List<Tourplace>>(
                              future:
                                  fetchTourplace(http.Client(), widget.token),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return const Center(
                                    child: Text('An error has occurred!'),
                                  );
                                } else if (snapshot.hasData) {
                                  return TourplaceRecommendation(
                                    kategori: widget.kategori,
                                    budget: widget.budget,
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
                            )
                          : FutureBuilder<List<Event>>(
                              future: fetchEvent(http.Client(), widget.token),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return const Center(
                                    child: Text('An error has occurred!'),
                                  );
                                } else if (snapshot.hasData) {
                                  return EventRecommendation(
                                    events: snapshot.data!,
                                    user: widget.user,
                                    token: widget.token,
                                    budget: widget.budget,
                                    kategori: widget.kategori,
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ExploreDestinationPage(
                                  user: widget.user, token: widget.token)));
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(neutral_20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            "Reset Preference",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: bold,
                                color: danger_20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CustomBottomNavbar(
                                    pageindex: 0,
                                    token: widget.token,
                                    user: widget.user,
                                  )));
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(primary_40),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            "Back to Home",
                            style: text_base_bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EventRecommendation extends StatefulWidget {
  User user;
  String token;
  String kategori;
  int budget;
  EventRecommendation({
    key,
    required this.events,
    required this.user,
    required this.token,
    required this.kategori,
    required this.budget,
  });

  final List<Event> events;

  @override
  State<EventRecommendation> createState() => _EventRecommendationState();
}

class _EventRecommendationState extends State<EventRecommendation> {
  late List<Event> eventrecommend = [];
  void initState() {
    super.initState();
    for (int i = 0; i < widget.events.length; i++) {
      if (widget.events[i].tipe == widget.kategori) {
        if (widget.budget == 1) {
          if (widget.events[i].harga <= 50000) {
            eventrecommend.add(widget.events[i]);
          }
        } else if (widget.budget == 2) {
          if (widget.events[i].harga > 50000 &&
              widget.events[i].harga <= 150000) {
            eventrecommend.add(widget.events[i]);
          }
        } else {
          if (widget.events[i].harga > 150000) {
            eventrecommend.add(widget.events[i]);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      SizedBox(
        height: 350,
        child: eventrecommend.isNotEmpty
            ? ListView.builder(
                itemCount: eventrecommend.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailEventPage(
                                event: eventrecommend[index],
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
                                      eventrecommend[index].img_tempat,
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
                                    child: eventrecommend[index]
                                                .nama_event
                                                .length <
                                            28
                                        ? Text(
                                            eventrecommend[index].nama_event,
                                            style: text_base_bold,
                                          )
                                        : Text(
                                            eventrecommend[index]
                                                    .nama_event
                                                    .substring(0, 23) +
                                                '...',
                                            style: text_base_bold,
                                          )),
                                const SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  child:
                                      eventrecommend[index].alamat.length < 38
                                          ? Text(
                                              eventrecommend[index].alamat,
                                              style: const TextStyle(
                                                color: neutral_40,
                                              ),
                                            )
                                          : Text(
                                              eventrecommend[index]
                                                      .alamat
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
                })
            : ListView(children: <Widget>[
                Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 300,
                              child: Text(
                                'Unfortunately, we do not have any recommendation for now :(',
                                style: text_base_bold,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ]),
      ),
    ]);
  }
}

class TourplaceRecommendation extends StatefulWidget {
  User user;
  String token;
  String kategori;
  int budget;
  TourplaceRecommendation({
    key,
    required this.tourplaces,
    required this.user,
    required this.token,
    required this.kategori,
    required this.budget,
  });

  final List<Tourplace> tourplaces;

  @override
  State<TourplaceRecommendation> createState() =>
      _TourplaceRecommendationState();
}

class _TourplaceRecommendationState extends State<TourplaceRecommendation> {
  late List<Tourplace> tourplacerecommend = [];
  void initState() {
    super.initState();
    for (int i = 0; i < widget.tourplaces.length; i++) {
      if (widget.tourplaces[i].tipe == widget.kategori) {
        if (widget.budget == 1) {
          if (widget.tourplaces[i].harga <= 50000) {
            tourplacerecommend.add(widget.tourplaces[i]);
          }
        } else if (widget.budget == 2) {
          if (widget.tourplaces[i].harga > 50000 &&
              widget.tourplaces[i].harga <= 150000) {
            tourplacerecommend.add(widget.tourplaces[i]);
          }
        } else {
          if (widget.tourplaces[i].harga > 150000) {
            tourplacerecommend.add(widget.tourplaces[i]);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      SizedBox(
        height: 350,
        child: tourplacerecommend.isNotEmpty
            ? ListView.builder(
                itemCount: tourplacerecommend.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailPlacePage(
                                tourplace: tourplacerecommend[index],
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
                                      tourplacerecommend[index].img_tempat,
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
                                    child: tourplacerecommend[index]
                                                .nama_tempat
                                                .length <
                                            28
                                        ? Text(
                                            tourplacerecommend[index]
                                                .nama_tempat,
                                            style: text_base_bold,
                                          )
                                        : Text(
                                            tourplacerecommend[index]
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
                                      tourplacerecommend[index].alamat.length <
                                              38
                                          ? Text(
                                              tourplacerecommend[index].alamat,
                                              style: const TextStyle(
                                                color: neutral_40,
                                              ),
                                            )
                                          : Text(
                                              tourplacerecommend[index]
                                                      .alamat
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
                })
            : ListView(children: <Widget>[
                Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 300,
                              child: Text(
                                'Unfortunately, we do not have any recommendation for now :(',
                                style: text_base_bold,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ]),
      ),
    ]);
  }
}

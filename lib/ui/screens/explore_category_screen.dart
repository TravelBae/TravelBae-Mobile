//Import library
import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelbae_android/styleGuide.dart';

//Import Screen
import 'package:travelbae_android/ui/screens/explore_budget_screen.dart';

//Import models
import 'package:travelbae_android/models/tourplace_model.dart';
import 'package:travelbae_android/models/event_model.dart';
import 'package:travelbae_android/models/user_model.dart';

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

class ExploreCategoryPage extends StatefulWidget {
  String type;
  String token;
  User user;
  ExploreCategoryPage(
      {required this.type, required this.user, required this.token, Key? key})
      : super(key: key);

  @override
  State<ExploreCategoryPage> createState() => _ExploreCategoryPageState();
}

class _ExploreCategoryPageState extends State<ExploreCategoryPage> {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
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
                height: 92,
              ),
              Text("Which one do you prefer?", style: text_2xl_bold),
              SizedBox(
                height: 86,
              ),
              Container(
                child: widget.type == "Tourplace"
                    ? FutureBuilder<List<Tourplace>>(
                        future: fetchTourplace(http.Client(), widget.token),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text('An error has occurred!'),
                            );
                          } else if (snapshot.hasData) {
                            return TourplaceButton(
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
                            return EventButton(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TourplaceButton extends StatefulWidget {
  User user;
  String token;
  TourplaceButton({
    key,
    required this.tourplaces,
    required this.user,
    required this.token,
  });

  final List<Tourplace> tourplaces;

  @override
  State<TourplaceButton> createState() => _TourplaceButtonState();
}

class _TourplaceButtonState extends State<TourplaceButton> {
  var tipe = <String>{};
  late List<Tourplace> uniquetype = widget.tourplaces
      .where((tourplaces) => tipe.add(tourplaces.tipe))
      .toList();
  var optionList = [];
  void initState() {
    super.initState();
    while (optionList.length < 3) {
      int option = Random().nextInt(uniquetype.length);
      while (option == 0) {
        option = Random().nextInt(uniquetype.length);
      }
      if (!optionList.contains(option)) {
        optionList.add(option);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      SizedBox(
          height: 250,
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    margin: const EdgeInsets.only(bottom: 24),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ExploreBudgetPage(
                                  user: widget.user,
                                  token: widget.token,
                                  type: "Tourplace",
                                  kategori: uniquetype[optionList[index]].tipe,
                                )));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(primary_40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          uniquetype[optionList[index]].tipe,
                          style: text_base_bold,
                        ),
                      ),
                    ),
                  ),
                );
              })),
    ]);
  }
}

class EventButton extends StatefulWidget {
  User user;
  String token;
  EventButton({
    key,
    required this.events,
    required this.user,
    required this.token,
  });

  final List<Event> events;

  @override
  State<EventButton> createState() => _EventButtonState();
}

class _EventButtonState extends State<EventButton> {
  var tipe = <String>{};
  late List<Event> uniquetype =
      widget.events.where((events) => tipe.add(events.tipe)).toList();
  var optionList = [];
  void initState() {
    super.initState();
    while (optionList.length < 3) {
      int option = Random().nextInt(uniquetype.length);
      while (option == 0) {
        option = Random().nextInt(uniquetype.length);
      }
      if (!optionList.contains(option)) {
        optionList.add(option);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      SizedBox(
          height: 250,
          child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    margin: const EdgeInsets.only(bottom: 24),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ExploreBudgetPage(
                                  user: widget.user,
                                  token: widget.token,
                                  type: "Event",
                                  kategori: uniquetype[optionList[index]].tipe,
                                )));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(primary_40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          uniquetype[optionList[index]].tipe,
                          style: text_base_bold,
                        ),
                      ),
                    ),
                  ),
                );
              })),
    ]);
  }
}

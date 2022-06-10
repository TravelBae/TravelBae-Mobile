//Import library
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelbae_android/styleGuide.dart';

//Import Screen
import 'package:travelbae_android/ui/screens/recommendation_screen.dart';

//Import models
import 'package:travelbae_android/models/user_model.dart';

class ExploreBudgetPage extends StatefulWidget {
  String token;
  User user;
  String type;
  String kategori;
  ExploreBudgetPage(
      {required this.type,
      required this.kategori,
      required this.user,
      required this.token,
      Key? key})
      : super(key: key);

  @override
  State<ExploreBudgetPage> createState() => _ExploreBudgetPageState();
}

class _ExploreBudgetPageState extends State<ExploreBudgetPage> {
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
              Text("Choose your traveling budget!", style: text_2xl_bold),
              SizedBox(
                height: 86,
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 52,
                    margin: const EdgeInsets.only(bottom: 24),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RecomendationScreen(
                                type: widget.type,
                                kategori: widget.kategori,
                                budget: 1,
                                token: widget.token,
                                user: widget.user)));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(primary_40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "<= Rp50.000,00",
                          style: text_base_bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 52,
                    margin: const EdgeInsets.only(bottom: 24),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RecomendationScreen(
                                type: widget.type,
                                kategori: widget.kategori,
                                budget: 2,
                                token: widget.token,
                                user: widget.user)));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(primary_40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "> Rp50.000,00 & <= Rp150.000,00",
                          style: text_base_bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 52,
                    margin: const EdgeInsets.only(bottom: 24),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RecomendationScreen(
                                type: widget.type,
                                kategori: widget.kategori,
                                budget: 3,
                                token: widget.token,
                                user: widget.user)));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(primary_40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "> Rp150.000,00",
                          style: text_base_bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:travelbae_android/styleGuide.dart';
import 'package:travelbae_android/ui/screens/home_screen.dart';
import 'package:travelbae_android/ui/screens/profile_screen.dart';
import 'package:travelbae_android/ui/screens/my_order_screen.dart';
import 'package:travelbae_android/ui/screens/login_screen.dart';

class CustomBottomNavbar extends StatefulWidget {
  String username;
  int pageindex;
  String token;
  CustomBottomNavbar(
      {required this.pageindex,
      required this.username,
      required this.token,
      Key? key})
      : super(key: key);

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  late List<Widget> _widgetOptions;
  @override
  void initState() {
    super.initState();
    _widgetOptions = [
      HomeScreen(username: widget.username, token: widget.token),
      MyOrderPage(),
      ProfileScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      widget.pageindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(widget.pageindex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: 'My Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: widget.pageindex,
        selectedItemColor: primary_40,
        unselectedItemColor: neutral_40,
        onTap: _onItemTapped,
      ),
    );
  }
}

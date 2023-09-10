import 'package:ecommerce/account.dart';
import 'package:ecommerce/cart.dart';
import 'package:ecommerce/categories.dart';
import 'package:ecommerce/landing.dart';
import 'package:ecommerce/notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int current_index = 0;
  final PageController _pageController = PageController();
  bool isSwitched = false;

  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
    // ...
  }

  Future<void> _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      isSwitched = _prefs.getBool('switchState') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (int newIndex) {
          setState(() {
            current_index = newIndex;
          });
        },
        children: [
          // Replace these with your different pages/widgets
          Landing(
            onSwitchChanged: (bool newValue) {
              setState(() {
                isSwitched = newValue;
              });
            },
          ),
          Category(),
          Notifications(),
          Account(),
          Cart()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        enableFeedback: true,
        iconSize: 30,
        unselectedItemColor: Colors.black54,
        selectedItemColor: Colors.blue,
        selectedLabelStyle: TextStyle(fontSize: 12, color: Colors.black54),
        unselectedLabelStyle: TextStyle(fontSize: 12, color: Colors.black54),
        currentIndex: current_index,
        onTap: (int newIndex) {
          setState(() {
            current_index = newIndex;
          });
          _pageController.animateToPage(
            newIndex,
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Category',
            icon: Icon(Icons.category_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Notifications',
            icon: Icon(Icons.notifications_none),
          ),
          BottomNavigationBarItem(
            label: 'Account',
            icon: Icon(Icons.perm_identity),
          ),
          BottomNavigationBarItem(
            label: 'Cart',
            icon: Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
    );
  }
}

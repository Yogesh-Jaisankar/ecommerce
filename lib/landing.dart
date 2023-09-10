import 'dart:async';
import 'package:ecommerce/curated.dart';
import 'package:ecommerce/search.dart';
import 'package:ecommerce/trending.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing extends StatefulWidget {
  final Function(bool) onSwitchChanged;
  const Landing({Key? key, required this.onSwitchChanged});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  bool is_Switched = false;

  int current_index = 0;

  Timer? textTimer;

  late SharedPreferences _prefs;

  List<String> textList = [
    'Iphone',
    'Kurti',
    'FloorMat',
    'headphones',
    'jackets'
  ];

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
    textTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        current_index = ((current_index + 1) % textList.length) as int;
      });
    });
  }

  Future<void> _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      is_Switched = _prefs.getBool('switchState') ?? false;
    });
  }

  void _saveSwitchState(bool value) {
    setState(() {
      is_Switched = value;
    });
    _prefs.setBool(
        'switchState', value); // Save the switch state to SharedPreferences
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed to prevent memory leaks
    textTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 60.0,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          "Brand Mall",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                        Transform.scale(
                          scale: 0.9,
                          child: CupertinoSwitch(
                              activeColor: Colors.black54,
                              value: is_Switched,
                              onChanged: (value) {
                                setState(() {
                                  is_Switched = value;
                                });
                                _saveSwitchState(value);
                                widget.onSwitchChanged(value);
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchPage()),
                      );
                    },
                    child: Container(
                        color: Colors.white,
                        height: 50,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  textList[current_index],
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.mic_none_outlined,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

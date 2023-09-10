import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class Trending extends StatefulWidget {
  const Trending({super.key});

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  Timer? imageTimer;
  int _currentIndex = 0;

  late PageController _pageControllerx;
  List<String> ImageList = [
    'assets/images/loan.jpg',
    'assets/images/phone.jpg',
    'assets/images/shoes.jpg',
    'assets/images/watch.jpg',
    'assets/images/loan.jpg',
    'assets/images/phone.jpg',
    'assets/images/shoes.jpg',
    'assets/images/watch.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _pageControllerx = PageController(initialPage: _currentIndex);
    startImageTimer();
  }

  @override
  void dispose() {
    _pageControllerx.dispose();
    super.dispose();
  }

  void startImageTimer() {
    const duration = Duration(seconds: 3); // Change the interval as needed
    Timer.periodic(duration, (Timer timer) {
      if (_currentIndex < ImageList.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
        _pageControllerx.jumpToPage(0); // Go back to the first image
      }
      if (_pageControllerx.hasClients) {
        _pageControllerx.animateToPage(
          _currentIndex,
          duration: Duration(milliseconds: 100),
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Container(
                height: 150, // Adjust the height as needed
                child: PageView.builder(
                  controller: _pageControllerx,
                  itemCount: ImageList.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Image.asset(
                      ImageList[index],
                      width: 510, // Adjust the width as needed
                      height: 510, // Adjust the height as needed
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 3, // Adjust the top position as needed
                child: Center(
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black12,
                    ),
                    child: DotsIndicator(
                      // Add the DotsIndicator widget
                      dotsCount: ImageList.length,
                      position: _currentIndex,
                      decorator: DotsDecorator(
                        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                        activeColor: Colors.white,
                        size: const Size.square(6.0),
                        activeSize: const Size(16.0, 6.0),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            SizedBox(height: 5),
            Container(
              height: 90,
              child: Center(
                  child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _sponsored("assets/images/coin.png", "Super Coin"),
                  _sponsored("assets/images/loan.png", "Personal Loan"),
                  _sponsored("assets/images/money.png", "Money+"),
                  _sponsored("assets/images/games.png", "Game zone"),
                  _sponsored("assets/images/credit.png", "EMI"),
                  _sponsored("assets/images/camera.png", "Camera"),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sponsored(String imagePath, String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                child: Image.asset(imagePath),
              )
            ],
          ),
          Text(
            label,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

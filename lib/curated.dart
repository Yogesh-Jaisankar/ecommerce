import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class Curated extends StatefulWidget {
  const Curated({super.key});

  @override
  State<Curated> createState() => _CuratedState();
}

class _CuratedState extends State<Curated> {
  Timer? imageTimer;
  int _currentIndex = 0;

  late PageController _pageController;
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
    _pageController = PageController(initialPage: _currentIndex);
    startImageTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void startImageTimer() {
    const duration = Duration(seconds: 3); // Change the interval as needed
    Timer.periodic(duration, (Timer timer) {
      if (_currentIndex < ImageList.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
        _pageController.jumpToPage(0); // Go back to the first image
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
      );
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
                height: 300, // Adjust the height as needed
                child: PageView.builder(
                  controller: _pageController,
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
          ],
        ),
      ),
    );
  }
}

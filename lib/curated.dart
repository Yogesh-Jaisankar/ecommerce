import 'dart:async';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce/cart.dart';
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
      if (_pageController.hasClients) {
        _pageController.animateToPage(
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
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    height: 50,
                    child: Image.asset("assets/images/offers.png"),
                  ),
                  SizedBox(width: 10),
                  Center(
                    child: Text(
                      "Big  Brands  Big  Savings!",
                      style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontFamily: "Monton"),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _bigdaysale("assets/images/card.png", "Woodland & More"),
                    _bigdaysale("assets/images/iphone.png", "iPhone"),
                    _bigdaysale("assets/images/shoe.png", "Nike"),
                    _bigdaysale("assets/images/laptops.png", "HP"),
                    // Add more items here as needed
                  ],
                )),
            Container(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Items in your cart",
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Cart()),
                          );
                        },
                        color: Colors.blue,
                        child: Text(
                          "Go to Cart",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 260,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _cartItems("assets/images/shoe.png", "Nike", "Description",
                      "1200", "30 % OFF"),
                  _cartItems("assets/images/shoe.png", "Nike", "Description",
                      "1200", "30 % OFF"),
                  _cartItems("assets/images/shoe.png", "Nike", "Description",
                      "1200", "30 % OFF"),
                  _cartItems("assets/images/shoe.png", "Nike", "Description",
                      "1200", "30 % OFF"),
                  _cartItems("assets/images/shoe.png", "Nike", "Description",
                      "1200", "30 % OFF"),
                ],
              ),
            )
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

  Widget _bigdaysale(String imagePath, String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              child: Image.asset(imagePath),
            ),
          ),
          SizedBox(height: 5),
          Container(
            height: 20,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _cartItems(String imagePath, String brand, String Description,
      String Price, String Discount) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 200,
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 200,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                child: Image.asset("assets/images/shoe.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      brand,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      Description,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "₹" + Price,
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      Discount,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                    Text(
                      "Only Few left",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

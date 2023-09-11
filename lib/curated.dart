import 'dart:async';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce/cart.dart';
import 'package:ecommerce/reviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  _productx("assets/images/coin.png", "Super Coin"),
                  _productx("assets/images/loan.png", "Personal Loan"),
                  _productx("assets/images/money.png", "Money+"),
                  _productx("assets/images/games.png", "Game zone"),
                  _productx("assets/images/credit.png", "EMI"),
                  _productx("assets/images/camera.png", "Camera"),
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
                          color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Cart()),
                          );
                        },
                        color: Colors.indigoAccent,
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
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(width: 1, color: Colors.grey.shade300))),
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
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Help India Make Better Choices",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Reviews()),
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                                color: Colors.indigoAccent,
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Icon(
                              Icons.chevron_right_rounded,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _reviewItems(
                    "assets/images/power.png",
                    "Apple 20W, USB-C power",
                    "Delivered on August 12, 2023",
                  ),
                  _reviewItems(
                    "assets/images/power.png",
                    "Apple 20W, USB-C power",
                    "Delivered on August 12, 2023",
                  ),
                  _reviewItems(
                    "assets/images/power.png",
                    "Apple 20W, USB-C power",
                    "Delivered on August 12, 2023",
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Container(
              height: 50,
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "Sponsored",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.start,
                  )),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Widget _productx(String imagePath, String label) {
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

  Widget _reviewItems(String imagePath, String p_name, String delivery_date) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 320,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade300)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(imagePath),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 70,
                      width: 210,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  p_name,
                                  // "Apple 20W, USB-C power",
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  delivery_date,
                                  //"Delivered on August 12, 2023",
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                    height: 40,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: RatingBar.builder(
                          glow: true,
                          glowColor: Colors.green,
                          itemSize: 25,
                          minRating: 1,
                          maxRating: 5,
                          direction: Axis.horizontal,
                          itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.green,
                              ),
                          onRatingUpdate: (rating) {
                            print("Rated $rating");
                          }),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

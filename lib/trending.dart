import 'package:flutter/material.dart';

class Trending extends StatefulWidget {
  const Trending({super.key});

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Add your scrollable content here
            // For example, you can add ListTile items
            Container(
              color: Colors.pink,
              height: 300,
            ),
            Container(
              color: Colors.purple,
              height: 300,
            ),
            Container(
              color: Colors.lightGreen,
              height: 300,
            )
          ],
        ),
      ),
    );
  }
}

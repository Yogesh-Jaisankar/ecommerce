import 'package:flutter/material.dart';

class Curated extends StatefulWidget {
  const Curated({super.key});

  @override
  State<Curated> createState() => _CuratedState();
}

class _CuratedState extends State<Curated> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Add your scrollable content here
            // For example, you can add ListTile items
            Container(
              color: Colors.lightBlue,
              height: 300,
            ),
            Container(
              color: Colors.green,
              height: 300,
            ),
            Container(
              color: Colors.yellow,
              height: 300,
            )
          ],
        ),
      ),
    );
  }
}

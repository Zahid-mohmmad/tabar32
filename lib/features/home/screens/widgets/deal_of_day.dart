import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10),
          child: const Text(
            'Shop of the day',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        Image.asset(
          'images/centerpoint.jpeg',
          height: 235,
          fit: BoxFit.fitHeight,
        ),
        Container(
          padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
          alignment: Alignment.bottomCenter,
          child: Text('See All Shops',
              style: TextStyle(
                  color: Colors.cyan[800],
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
        ),
      ],
    );
  }
}

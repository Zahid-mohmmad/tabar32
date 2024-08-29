import 'package:flutter/material.dart';

String uri = 'http://192.168.100.95:3000';

class GlobalVariables {
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192), 
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'images/max.png',
    'images/redtag.png',       
    'images/centerpoint.jpeg',
    'images/ab.png',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Max',
      'image': 'images/max.png',
    },
    {
      'title': 'Center-point',
      'image': 'images/centerpoint.jpeg',
    },
    {
      'title': 'Splash',
      'image': 'images/s.jpg',
    },
    {
      'title': 'Bershka',
      'image': 'images/j.jpg',
    },
    {
      'title': 'Red Tag',
      'image': 'images/redtag.png',
    },
    {
      'title': 'MarAbaya',
      'image': 'images/ab.png',
    },
  ];
}

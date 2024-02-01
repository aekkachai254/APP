import 'package:application/screen/Intro.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CARGO SWIF',
      theme: ThemeData(
        brightness: Brightness.dark, // กำหนดให้เป็นธีมสีดำ
      ),
      debugShowCheckedModeBanner: false,
      home: IntroScreen(),
    );
  }
}

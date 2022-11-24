import 'package:flutter/material.dart';
import "home.dart";
import 'loading.dart';

int buttonPushed = 1;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override

  Widget build(BuildContext context) {
    //int buttonPushed = 1;
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      home: (buttonPushed==1)?loadingPage():HomePage(),
    );
  }
}

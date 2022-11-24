import 'package:compass_using_flutter/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          buttonPushed = 1;
        });
        debugPrint("hello"+buttonPushed.toString());
      },
      child: Container(
        color: Colors.white,
        child: Center(child: Text('hello World', style: TextStyle(color: Colors.black),)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'main.dart';

class loadingPage extends StatefulWidget {
  const loadingPage({Key? key}) : super(key: key);

  @override
  State<loadingPage> createState() => _loadingPageState();
}

class _loadingPageState extends State<loadingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            child: Center(child: Text("loading page")),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                buttonPushed = 2;
                debugPrint("hello"+buttonPushed.toString());
              });
            },
            child: Container(
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}


import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'dart:math' as math;
import 'package:compass_using_flutter/neu_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _hasPermissions = false;

  @override
  void initState() {
    super.initState();

    _fetchPermissionStatus();
  }

  void _fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then((status) {
      if (mounted) {
        setState(() {
          _hasPermissions = (status == PermissionStatus.granted);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                  child: Container(

                  ))
              ,
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.blueGrey,
                  child: Center(child: Text("DigiCOMPASS", style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),)),
                ),
              ),
              Expanded(
                flex: 21,
                child: Builder(
                  builder: (context) {
                    if (_hasPermissions) {
                      return _buildCompass();
                    } else {
                      return _buildPermissionSheet();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        double? direction = snapshot.data!.heading;

        // if direction is null, then device does not support this sensor
        // show error message
        if (direction == null) {
          return const Center(
            child: Text("Device does not have sensors !"),
          );
        }

        return NeuCircle(
          child: Transform.rotate(
            angle: (direction * (math.pi / 180) * -1),
            child: Image.asset(
              'assets/compass.png',
              color: Colors.white,
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPermissionSheet() {
    return Center(
      child: GestureDetector(
        onTap: () {
          Permission.locationWhenInUse.request().then((ignored) {
            _fetchPermissionStatus();
          });
        },
        child: Container(
          child: Center(child: const Text('Request Permissions')),
         //color: Colors.blueGrey,
         height: 100,
         width: 300,
         padding: EdgeInsets.all(8),
         decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(50),
           boxShadow: [
           const BoxShadow(
             color: Color(0xFFBEBEBE),
             offset: Offset(10, 10),
             blurRadius: 20,
             spreadRadius: 1,
             ),
           const BoxShadow(
             color: Colors.white,
             offset: Offset(-10, -10),
             blurRadius: 20,
             spreadRadius: 1,
             ),
           ]
         ),
         /* onPressed: () {
            Permission.locationWhenInUse.request().then((ignored) {
              _fetchPermissionStatus();
            });
          },*/
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';
import 'test.dart';
import 'networking.dart';

class weather extends StatefulWidget {
  var temperature;

  weather({Key? key, required this.temperature}) : super(key: key);

  @override
  State<weather> createState() => _weatherState();
}

class _weatherState extends State<weather> {
  String iconurl = 'https://openweathermap.org/img/wn/11d@4x.png';
  String icon = '';
  String currentTime = '';
  Color day = Color.fromARGB(255, 168, 224, 250);
  Color night = Color.fromARGB(255, 2, 35, 69);
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted)
        setState(() {
          currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: day,
      body: Stack(
        children: [
          Positioned(
            top: 110,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment
              .center,
              child: Container(
                height: 400,
                width: 400,
                child: Lottie.asset("images/rain.json"),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 15,
            right: 0,
            child: Container(
              child: Text(
                "$currentDate",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "MyFont",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: 15,
            right: 0,
            child: Container(
              child: Text(
                "$currentTime",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "MyFont",
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
            top: 500,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                child: Text(
                  widget.temperature.toInt().toString()+"°C",
                  style: TextStyle(fontFamily: "MyFont2", fontSize: 50,color: Colors.white,fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

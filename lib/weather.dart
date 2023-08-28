import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';
import 'test.dart';
import 'networking.dart';

class weather extends StatefulWidget {
  //var temperature;
  final variables variable;
  final String cityName;

  weather({Key? key, required this.variable, required this.cityName})
      : super(key: key);

  @override
  State<weather> createState() => _weatherState();
}

class _weatherState extends State<weather> {
  String iconurl = 'https://openweathermap.org/img/wn/11d@4x.png';
  String icon = '';
  String currentTime = '';
  //Color day = Color.fromARGB(255, 168, 224, 250);
  Color night = Color.fromARGB(255, 2, 35, 69);
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String day = DateFormat('EEEE').format(DateTime.now());
  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  bool timeOfDay = true;
  List<String> conditions = [
    "Thunderstorm",
    "Drizzle",
    "Rain",
    "Snow",
    "Atmosphere",
    "Clear",
    "Clouds"
  ];
  int currentHour = DateTime.now().hour;
  bool rain = false;

  @override
  void initState() {
    super.initState();
    if (widget.variable.main == conditions[0] ||
        widget.variable.main == conditions[1] ||
        widget.variable.main == conditions[2]) {
      rain = true;
    } else {
      rain = false;
    }
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted)
        setState(() {
          //int currentHour = DateTime.now().hour;
          currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
          //timeOfDay= currentHour>=6 && currentHour<18;
        });
    });
    //timeOfDay!= currentHour>=6 && currentHour<18;
    if (currentHour >= 6 && currentHour < 18) {
      timeOfDay = true;
    } else {
      timeOfDay = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: day,
      body: Stack(
        children: [
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.asset(
                  timeOfDay ? "images/day-2.png" : "images/night-4.png"),
            ),
          ),
          Positioned(
            top: 110,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 300,
                width: 300,
                child: Lottie.asset(
                  timeOfDay
                      ? (rain
                          ? "images/dayrain.json"
                          : "images/clearsun.json")
                      : (rain
                          ? "images/nightrain.json"
                          : "images/clearmoon.json"),
                ),
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
            top: 450,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white.withOpacity(0.3),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.4),
                    width: 1.2,
                  ),
                ),
                child: SizedBox(
                  height: 320,
                  width: 320,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 40,
                        child: Text(
                          day +
                              ", " +
                              capitalizeFirstLetter(widget.cityName) +
                              ", " +
                              widget.variable.country,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "MyFont3",
                              fontSize: 15),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Text(
                            widget.variable.temperature.toInt().toString() +
                                "°C",
                            style: const TextStyle(
                              fontFamily: "MyFont3",
                              fontSize: 70,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 3,
                      // ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Text(
                            capitalizeFirstLetter(widget.variable.description),
                            style: const TextStyle(
                              fontFamily: "MyFont3",
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Icon(
                            Icons.air,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Wind",
                            style: TextStyle(
                                color: Colors.white, fontFamily: "MyFont3"),
                          ),
                          SizedBox(
                            width: 48,
                          ),
                          Text(
                            "|",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            ((((widget.variable.wind)) * 18 * 0.2).toInt())
                                    .toString() +
                                " km/h",
                            style: TextStyle(
                                fontFamily: "MyFont3", color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Icon(
                            Icons.water_drop_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Hum",
                            style: TextStyle(
                                color: Colors.white, fontFamily: "MyFont3"),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            "|",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            (widget.variable.humidity).toString() + " %",
                            style: TextStyle(
                                fontFamily: "MyFont3", color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Icon(
                            CupertinoIcons.sun_max,
                            color: Colors.white,
                            size: 30,
                          ),
                          //SizedBox(width: 1,),

                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Max / Min",
                            style: TextStyle(
                                color: Colors.white, fontFamily: "MyFont3"),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "|",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            (widget.variable.mintemp).toInt().toString() +
                                "°C / " +
                                (widget.variable.maxtemp).toInt().toString() +
                                "°C",
                            style: TextStyle(
                                fontFamily: "MyFont3", color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

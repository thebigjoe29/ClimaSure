import 'package:demoapp/weather.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'main.dart';
import 'networking.dart';
import 'package:page_transition/page_transition.dart';

class video extends StatefulWidget {
  const video({Key? key}) : super(key: key);

  @override
  State<video> createState() => _videoState();
}

class _videoState extends State<video> {
  final TextEditingController name = TextEditingController();
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String currentTime = '';
  bool isLoading = false;
  String loading = "Get Weather!";
  String cityName='';
  
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.asset("images/bg.png"), // Path to your SVG image
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
            top: 310,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                child: Text(
                  "ClimaSure",
                  style: TextStyle(
                      fontSize: 54,
                      fontFamily: "MyFont",
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 253, 252, 252)),
                ),
              ),
            ),
          ),
          Positioned(
              top: 395,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  child: Text(
                    "To get started, enter the city whose weather you want!",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "MyFont",
                        fontSize: 12),
                  ),
                ),
              )),
          // Positioned(child: SizedBox(height: 20)), // Add this SizedBox
          Positioned(
            top: 450, // Adjust the position as needed
            left: 30, // Adjust the position as needed
            right: 30, // Adjust the position as needed
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Container(
                  color: Colors.transparent, // Set a transparent color
                  child: Icon(Icons.location_city_outlined,
                      color: const Color.fromARGB(145, 0, 0, 0)),
                ),
                hintText: "eg. Mumbai",
                hintStyle: TextStyle(fontFamily: "MyFont"),
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              onChanged: (value){
                setState(() {
                  cityName=value;
                });
              },
            ),
          ),
          Positioned(
            top: 580,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                  height: 60,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = !isLoading;
                        if (isLoading) {
                          loading = "Fetching live data";
                        } else {
                          loading = "Get Weather!";
                        }
                        
                      });
                      
                      var temperature=await getTemp(cityName, api);
                      
                       
                      Navigator.push(
                            context,
                            PageTransition(
                                child: weather(temperature:temperature),
                                type: PageTransitionType.rightToLeft)
                            //MaterialPageRoute(builder: (context) => options()),
                            );
                            
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$loading",
                          style: TextStyle(
                              fontFamily: "MyFont",
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                        if (isLoading)
                          SizedBox(
                            width: 10,
                          ),
                        if (isLoading)
                          SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              )),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

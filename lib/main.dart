//import 'dart:convert';
import 'package:demoapp/test.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'weather.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: video(),
    );
  }
}


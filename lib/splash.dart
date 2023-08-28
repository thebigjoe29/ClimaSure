import 'package:demoapp/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class splashscreen extends StatefulWidget {
  
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2),(){
      Navigator.push(context, PageTransition(child: video(), type: PageTransitionType.bottomToTop));
    });
  }
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset("images/rain.json",height: 100,width: 100),
      ),
    );
  }
}
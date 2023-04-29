import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'HomePage.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(
          seconds: 4,
        ), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child:Container(
                alignment: Alignment.center,
                width: 300,
                height: 300,
                child: Image.network("https://cdn.dribbble.com/users/2344150/screenshots/13896429/media/c3e7114fb91046c8ceeaa74e5abc112b.gif")
            ),
          ),
          Text(
            "Currency  Convertor",
            style: GoogleFonts.rubikPuddles(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

Widget appBarTitle() {
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    // Text("Overl",
    //     style: GoogleFonts.pacifico(textStyle: TextStyle(color: Colors.black))),

    // totalRepeatCount: 1,
    Container(
      child: TextLiquidFill(
        loadDuration: Duration(seconds: 3),
        waveDuration: Duration(seconds: 1),
        text: "Overl",
        boxBackgroundColor: Colors.white,
        boxWidth: 52,
        textStyle: GoogleFonts.pacifico(color: Colors.black),
        waveColor: Colors.black,
      ),
    ),
    Container(
      child: TextLiquidFill(
        loadDuration: Duration(seconds: 3),
        waveDuration: Duration(seconds: 1),
        text: "ay",
        boxBackgroundColor: Colors.white,
        boxWidth: 19,
        textStyle: GoogleFonts.pacifico(color: Colors.black),
        waveColor: Colors.cyan,
      ),
    )

    // Text("ay",
    //     style: GoogleFonts.pacifico(textStyle: TextStyle(color: Colors.cyan)))
  ]);
}

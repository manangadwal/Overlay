// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Data/data.dart';
import 'home.dart';
import 'models/wallpaper_model.dart';
import 'package:http/http.dart' as http;

class Categorie extends StatefulWidget {
  String? searchQuery;
  Categorie({this.searchQuery});

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  List<Wallpapermodel> wallpaperList = [];

  getSearchWallpapers(String query) async {
    var response = await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=80"),
        headers: {"Authorization": apikey});

    // print(response.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      // print(element);
      Wallpapermodel wallpapermodel = Wallpapermodel();
      wallpapermodel = Wallpapermodel.fromMap(element);
      wallpaperList.add(wallpapermodel);
    });

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSearchWallpapers(widget.searchQuery ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: RichText(
          text: TextSpan(
            text: 'Overl',
            style: GoogleFonts.pacifico(
                textStyle: TextStyle(color: Colors.black, fontSize: 20)),
            children: const <TextSpan>[
              TextSpan(text: 'ay', style: TextStyle(color: Colors.cyan)),
            ],
          ),
        ),
      ),
      body: Container(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            wallpaperListWidget(wallpapers: wallpaperList, context: context),
          ],
        ),
      )),
    );
  }
}

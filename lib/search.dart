// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:wally/Data/data.dart';

import 'home.dart';
import 'models/wallpaper_model.dart';

class Search extends StatefulWidget {
  String? searchQuery;
  Search({this.searchQuery});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController textEditingController = TextEditingController();
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
    textEditingController.text = widget.searchQuery ?? '';
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
              // TextSpan(text: ' world!'),
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

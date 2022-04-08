// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wally/Data/data.dart';
import 'package:wally/categorie.dart';
import 'package:wally/image_view.dart';
import 'package:wally/models/categories_model.dart';
import 'package:wally/models/wallpaper_model.dart';
import 'package:wally/search.dart';
import 'package:wally/widgets/appbar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:http/http.dart' as http;
import 'package:easy_push/easy_push.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isPressed = false;
  TextEditingController textEditingController = TextEditingController();

  List<CategoriesModel> categories = [];
  List<Wallpapermodel> wallpaperList = [];

  getTrendingWallpapers() async {
    var response = await http.get(
        Uri.parse("https://api.pexels.com/v1/curated?per_page=80"),
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
    getTrendingWallpapers();
    categories = getCategories();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: appBarTitle(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Container(
            child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: [
                    isPressed
                        ? GestureDetector(
                            onTap: (() {
                              setState(() {
                                textEditingController.text = '';
                                isPressed = false;
                              });
                            }),
                            child: Icon(Icons.arrow_back_ios_new))
                        : Container(),
                    Expanded(
                      child: Stack(
                          alignment: AlignmentDirectional.centerStart,
                          children: [
                            TextField(
                              controller: textEditingController,
                              onTap: () {
                                setState(() {
                                  isPressed = true;
                                });
                              },
                              onChanged: (val) {
                                setState(() {
                                  isPressed = true;
                                  // textEditingController.text = val;
                                });
                              },
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              showCursor: false,
                            ),
                            isPressed
                                ? Container()
                                : Container(
                                    // margin: EdgeInsets.only(top: 15),
                                    child: AnimatedTextKit(
                                      totalRepeatCount: 2,
                                      animatedTexts: [
                                        TypewriterAnimatedText(
                                          "Love",
                                          textStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54),
                                          cursor: '',
                                          speed: Duration(milliseconds: 100),
                                        ),
                                        TypewriterAnimatedText(
                                          "Flowers",
                                          textStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54),
                                          cursor: '',
                                          speed: Duration(milliseconds: 100),
                                        ),
                                        TypewriterAnimatedText(
                                          "Landscape",
                                          textStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54),
                                          cursor: '',
                                          speed: Duration(milliseconds: 100),
                                        ),
                                        TypewriterAnimatedText(
                                          "Animals",
                                          textStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54),
                                          cursor: '',
                                          speed: Duration(milliseconds: 100),
                                        ),
                                        TypewriterAnimatedText(
                                          "Nature",
                                          textStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54),
                                          cursor: '',
                                          speed: Duration(milliseconds: 100),
                                        ),
                                        TypewriterAnimatedText(
                                          "Coding",
                                          textStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54),
                                          cursor: '',
                                          speed: Duration(milliseconds: 100),
                                        ),
                                        TypewriterAnimatedText(
                                          "Search Wallpapers",
                                          textStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54),
                                          cursor: '',
                                          speed: Duration(milliseconds: 100),
                                        ),
                                      ],
                                    ),
                                  )
                          ]),
                    ),
                    GestureDetector(
                        onTap: () {
                          // Push.to(context , Search());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Search(
                                        searchQuery: textEditingController.text,
                                      )));
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.black54,
                        ))
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 70,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, idx) {
                      CategoriesModel cm = categories[idx];
                      return CategoryTile(
                        imgurl: categories[idx].imgUrl,
                        title: cm.categorieName,
                      );
                    }),
              ),
              // SizedBox(
              //   height: 16,
              // ),
              wallpaperListWidget(wallpapers: wallpaperList, context: context),
            ],
          ),
        )),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String? imgurl, title;
  CategoryTile({Key? key, this.imgurl, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Categorie(
                      searchQuery: title,
                    )));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imgurl ?? '',
                  fit: BoxFit.cover,
                  width: 140,
                  // height: 70,
                )),
            Container(
                alignment: Alignment.center,
                height: 80,
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  title ?? '',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                )),
          ],
        ),
      ),
    );
  }
}

///
///
///
///
Widget wallpaperListWidget(
    {required List<Wallpapermodel> wallpapers, context}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
    child: GridView.count(
      scrollDirection: Axis.vertical,
      // primary: true,
      physics: ScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 0.55,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((e) {
        return GridTile(
          child: Container(
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImageView(
                              url: e.src?.portrait ?? '',
                            )));
              },
              child: Hero(
                tag: e.src?.portrait ?? '',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    e.src?.portrait ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}

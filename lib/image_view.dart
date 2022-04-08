// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:dio/dio.dart';
import 'package:image_downloader/image_downloader.dart';

class ImageView extends StatefulWidget {
  String? url;
  ImageView({this.url});
  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  _save() async {
    var response = await Dio().get(widget.url ?? '',
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 100,
    );
    Navigator.pop(context);
  }

  getDownload() async {
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(widget.url ?? '');
      if (imageId == null) {
        return;
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Hero(
              tag: widget.url ?? '',
              child: Image.network(
                widget.url ?? '',
                fit: BoxFit.cover,
              )),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            GestureDetector(
              onTap: () {
                // _save();
                getDownload();
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white38),
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(54, 59, 58, 58),
                      Color.fromARGB(15, 26, 22, 22),
                    ])),
                child: Text(
                  "Download Image",
                  style: TextStyle(color: Colors.grey[300]),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.grey[300]),
              ),
            ),
            SizedBox(
              height: 35,
            )
          ]),
        )
      ]),
    );
  }
}

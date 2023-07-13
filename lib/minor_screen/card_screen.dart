import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:uikit/Model/postmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CardScreen extends StatelessWidget {
  String linkUrl;
  CardScreen({super.key, required this.linkUrl});

  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..loadRequest(Uri.parse(linkUrl));
    Color appBarColor = HexColor('#212024');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          'GOSU News',
          style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
/*class CardScreen extends StatefulWidget {
   String linkUrl ;
  
   CardScreen({super.key, required this.linkUrl});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  var postURL = [];
 
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      var response = await Dio().get('https://auth.gosucorp.vn/api/list-news');
      if (response.statusCode == 200) {
        setState(() {
          postURL = response.data["data"] as List;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  WebViewController controller = WebViewController()
    ..loadRequest(Uri.parse());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PostModel>(builder: (context, snapshot) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'GOSU News',
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: WebViewWidget(controller: controller),
      );
    });
  }
} */


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('Employee');

  @override
  void initState() {



    super.initState();
  }

  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {





    Size ScreenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: WebView(
          key: _key,
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: "https://staff-akhair.web.app/login"),
    );
  }
}
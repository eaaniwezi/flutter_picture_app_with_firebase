// ignore_for_file: prefer_const_constructors

import 'package:firebase_picture_app/widgets/app_bar_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "welcome",
          style: TextStyle(
            color: Color(0xff182647),
          ),
        ),
      ),
      drawer: AppBarDrawer(),
    );
  }
}

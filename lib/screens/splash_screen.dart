// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SlapshScreen extends StatelessWidget {
  final String? description;
  const SlapshScreen({
    Key? key,
     this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitFadingCircle(
            color: Colors.black,
            size: 50.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(description.toString()),
          ),
        ],
      ),
    );
  }
}

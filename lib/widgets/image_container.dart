// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:firebase_picture_app/models/picture_model.dart';

class ImageModel extends StatelessWidget {
  final PictureModel pictureModel;
  const ImageModel({
    Key? key,
    required this.pictureModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: Stack(
            children: [
              Positioned.fill(
                child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      color: Colors.transparent,
                      child: SpinKitCubeGrid(
                        size: 35,
                        color: Color(0xff182647),
                      ),
                    )),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(pictureModel.picture),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Transform.translate(
                  offset: Offset(50, -50),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 65, vertical: 63),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: const Icon(
                      Icons.delete,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

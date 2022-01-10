// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:firebase_picture_app/bloc/picture/picture_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_picture_app/widgets/button.dart';
import 'package:firebase_picture_app/widgets/app_bar_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final imagePicker = ImagePicker();
  var _image;
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
      bottomNavigationBar: ButtonContainer(
        label: 'добавить фотографию',
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => CupertinoAlertDialog(
                    title: Text('Добавить фото'),
                    content: Text('откуда?'),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () async {
                            // var image = await ImagePicker.platform
                            //     .pickImage(source: ImageSource.camera);

                            // setState(() {
                            //   _image = image as File?;
                            // });
                            dynamic image = await imagePicker.pickImage(
                                source: ImageSource.camera);
                            print(image!.path.toString() +
                                " this is the image to string");
                                setState(() {
                                  _image = File(image.path);
                                    print(_image.path.toString() +
                                " this is the _imagwegege to string");
                                ;

                                });
                            BlocProvider.of<PictureBloc>(context).add(
                              OnTapEvent(image: _image),
                            );
                          },
                          child: Text('камера')),
                      //**** */
                      TextButton(
                        onPressed: () {},
                        child: Text('галерея'),
                      )
                    ],
                  ));
        },
      ),
    );
  }
}

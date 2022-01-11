// ignore_for_file: prefer_const_constructors, avoid_print, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_picture_app/bloc/picture/picture_bloc.dart';
import 'package:firebase_picture_app/models/picture_model.dart';
import 'package:firebase_picture_app/widgets/image_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_picture_app/widgets/button.dart';
import 'package:firebase_picture_app/widgets/app_bar_drawer.dart';
import 'package:logger/logger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
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
          "Привет😉",
          style: TextStyle(
            color: Color(0xff182647),
          ),
        ),
      ),
      drawer: AppBarDrawer(),
      bottomNavigationBar: ButtonContainer(
        label: 'выберите фотографию',
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => CupertinoAlertDialog(
                    title: Text('Добавить фото'),
                    content: Text('откуда?'),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () async {
                            Navigator.pop(context);

                            XFile? image = await imagePicker.pickImage(
                              source: ImageSource.camera,
                            );
                            setState(() {
                              _image = File(image!.path);
                            });
                          },
                          child: Text('с камеры')),
                      //**** */
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          XFile? image = await imagePicker.pickImage(
                            source: ImageSource.gallery,
                          );
                          setState(() {
                            _image = File(image!.path);
                          });
                        },
                        child: Text('из галереи'),
                      )
                    ],
                  ));
        }, bottonHeight: false,
      ),
      body: BlocListener<PictureBloc, PictureState>(
        // listenWhen: (oldState, newState) => newState is PictureLoadedState,
        listener: (context, state) {
          print(state.toString() + " this is my pics state");
          if (state is PictureLoadingState) {
            setState(() {
              isLoading = true;
            });
          } else if (state is PictureLoadedState) {
            setState(() {
              Fluttertoast.showToast(msg: "успешно отправленный");
            });
          }
        },
        child: _image != null
            ? ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: double.infinity,
                      child: Image.file(
                        _image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 70,
                      right: 70,
                      bottom: 15,
                    ),
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<PictureBloc>(context).add(
                          OnTapEvent(image: _image),
                        );
                        setState(() {
                          _image = null;
                        });
                      },
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xff182647),
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text(
                            isLoading == true
                                ? "загрузка фотографии"
                                : 'добавить фотографию',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : BlocBuilder<PictureBloc, PictureState>(
                builder: (context, state) {
                  if (state is PictureFetchedState) {
                    List<PictureModel> pictureList = state.pictureItemModelList;

                    return pictureList.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                "Нажмите на кнопку ниже, чтобы добавить несколько фотографий😉",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : GridView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              // childAspectRatio: (3 / 2),
                            ),
                            itemCount: pictureList.length,
                            itemBuilder: (BuildContext context, int index) {
                              final pictureModel = pictureList[index];
                              return ImageModel(
                                pictureModel: pictureModel,
                              );
                            },
                          );
                  }
                  return Center(
                      child:
                          CircularProgressIndicator(color: Color(0xff182647)));
                },
              ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:firebase_picture_app/bloc/picture/picture_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    return BlocListener<PictureBloc, PictureState>(
   listenWhen: (oldState, newState) => newState is PictureDeletedState,
      listener: (context, state) {
       
        if (state is PictureDeletedState) {
          Fluttertoast.showToast(msg: "Успешно удален");
        }
      },
      child: Padding(
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 65, vertical: 63),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => CupertinoAlertDialog(
                                      title: Text('Хотите удалить'),
                                      content: Text('эту фотографию?'),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Нет')),
                                        //**** */
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            BlocProvider.of<PictureBloc>(
                                                    context)
                                                .add(DetelePictureEvent(
                                                    pictureModel:
                                                        pictureModel));
                                          },
                                          child: Text('да'),
                                        )
                                      ],
                                    ));
                          },
                          icon: Icon(
                            Icons.delete,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

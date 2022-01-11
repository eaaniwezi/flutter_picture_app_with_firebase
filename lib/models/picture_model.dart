import 'package:cloud_firestore/cloud_firestore.dart';

class PictureModel {
  final String id;
  final String picture;

  PictureModel({
    required this.id,
    required this.picture,
  });

  factory PictureModel.fromSnapshot(DocumentSnapshot snapshot) {
    return PictureModel(
      id: snapshot['id'],
      picture: snapshot['picture'],
    );
  }
}

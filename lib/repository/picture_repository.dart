// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_picture_app/models/picture_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class PictureRepository {
  String collection = "pictures";
  String collectionName = "Userpictures";
  var log = Logger();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  createPictureCollectionInFireStore(
      Map<String, dynamic> data, dynamic currentUserId) {
    var id = const Uuid();
    String pictureId = id.v1();
    data["id"] = pictureId;
    _firebaseFirestore
        .collection(collection)
        .doc(currentUserId)
        .collection(collectionName)
        .doc(pictureId)
        .set(data);
    // _firebaseFirestore.collection(collection).doc(pictureId).set(data);
  }

  Future<String> sendAndStorePicturesInDb(dynamic image) async {
    final String picture =
        "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg}";
    log.v(picture);
    TaskSnapshot snapshot =
        await firebaseStorage.ref().child(picture).putFile(image);

    if (snapshot.state == TaskState.success) {
      final imageUrl = snapshot.ref.getDownloadURL();
      return imageUrl;
    }
    return snapshot.ref.getDownloadURL();
  }

  Future<List<PictureModel>> getUserPictures(dynamic currentUserId) async =>
      _firebaseFirestore
          .collection(collection)
          .doc(currentUserId)
          .collection(collectionName)
          .get()
          .then((result) {
        List<PictureModel> pictures = [];
        for (DocumentSnapshot picture in result.docs) {
          pictures.add(PictureModel.fromSnapshot(picture));
          log.wtf(pictures.length);
        }

        return pictures;
      });
}

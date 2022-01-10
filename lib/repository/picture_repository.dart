import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class PictureRepository {
  String collection = "pictures";
  var log = Logger();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  createPictureCollectionInFireStore(Map<String, dynamic> data) {
    var id = const Uuid();
    String pictureId = id.v1();
    data["id"] = pictureId;
    _firebaseFirestore.collection(collection).doc(pictureId).set(data);
  }

  Future<String> sendAndStorePicturesInDb(dynamic image) async {
    final String picture =
        "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg}";
        log.v(picture);
    TaskSnapshot snapshot =
        await firebaseStorage.ref().child(picture).putFile(image);
    if (snapshot.state == TaskState.success) {
      final String imageUrl = snapshot.ref.getDownloadURL().toString();
     print(imageUrl + " thisi is image url");
      return imageUrl;
    }
    return snapshot.ref.getDownloadURL();
  }
}

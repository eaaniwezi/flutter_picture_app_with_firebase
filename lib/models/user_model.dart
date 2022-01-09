import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String phoneNumber;

  UserModel({
    required this.id,
    required this.phoneNumber,
  });

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      id: snapshot['id'],
      phoneNumber: snapshot['phoneNumber'],
    );
  }
}

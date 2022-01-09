import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final firebaseAuth = FirebaseAuth.instance;
  



  // UserRepository({FirebaseAuth? firebaseAuth}) : _firebaseAuth = firebaseAuth!;

  Future<void> sendOtp(
      String phoneNumber,
      Duration timeOut,
      PhoneVerificationFailed phoneVerificationFailed,
      PhoneVerificationCompleted phoneVerificationCompleted,
      PhoneCodeSent phoneCodeSent,
      PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout) async {
    firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: timeOut,
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }

  Future<UserCredential> verifyAndLogin(
      String verificationId, String smsCode) async {
    AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    return firebaseAuth.signInWithCredential(authCredential);
  }

  Future<User?> getUser() async {
    var user = firebaseAuth.currentUser;
     print(user.toString() + " this is the token");
    return user;
  }



  // final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  // String collection = "users";

  // createUserCollectionInFireStore(Map<String, dynamic> data) async {
  //   await _firebaseFirestore.collection(collection).doc(data["uid"]).set(data);
  // }

}

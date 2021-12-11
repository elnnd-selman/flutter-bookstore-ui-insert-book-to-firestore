import 'dart:io';

import 'package:avreenbooks/model/user_info_from_firestore_model.dart';
import 'package:avreenbooks/provider/firestore_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

class FirebaseAuth_provider with ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> signInToFirebaseAuth(
      String name, String email, String password, File file) async {
 
    Reference ref = _storage.ref().child('user-profile-image').child(email);
    TaskSnapshot _uploadFile = await ref.putFile(file);
    if (_uploadFile.state == TaskState.success) {
      String _profileImageUrl = await ref.getDownloadURL();
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        toFirestore(name, email, _profileImageUrl);
        print('User Created');
      }).catchError((err) => print(err));
    }
  }

  Future<void> toFirestore(
      String name, String email, String imageProfileUrl) async {
    User user = _firebaseAuth.currentUser;
    UserFireStoreInfo _newUser = UserFireStoreInfo(
        id: user.uid, imageProfileUrl: imageProfileUrl, name: name);
    await FirestoreClass().collectionUser.doc(user.uid).set(_newUser.toMap());
  }

  Future<void> loginInToFirebaseAuth(String email, String password) async {
    await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('User login');
    }).catchError((err) => print(err));
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    print('signOut');
  }

  Stream<User> get user => _firebaseAuth.authStateChanges().map((user) => user);
}

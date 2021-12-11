import 'dart:io';

import 'package:avreenbooks/model/book_model.dart';
import 'package:avreenbooks/model/user_info_from_firestore_model.dart';
import 'package:avreenbooks/model/user_info_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class FirestoreClass with ChangeNotifier {
  CollectionReference collection =
      FirebaseFirestore.instance.collection('books');
  CollectionReference collectionUser =
      FirebaseFirestore.instance.collection('users');

  FirebaseStorage storage = FirebaseStorage.instance;
  //////////////////////////////////
//add and update
  Future<void> addToFireStore(
      Book book, File file, String imageUrl, String id, Map likes) async {
    var options = SetOptions(merge: true);

    var newBookId = Uuid().v4();

    if (file != null && imageUrl.length < 5) {
      print('1');
      Reference ref = storage.ref().child('image_of_books/${newBookId}');
      TaskSnapshot uploadedFile = await ref.putFile(file);
      if (uploadedFile.state == TaskState.success) {
        ref.getDownloadURL().then((value) {
          if (book.id == null) {
            Book newBook = Book(
              likes: {},
              userId: book.userId,
              id: newBookId,
              name: book.name,
              imageUrl: value,
              description: book.description,
              price: book.price,
              translate: book.translate,
              writer: book.writer,
              category: book.category,
              languages: book.languages,
              numofpage: book.numofpage,
            );

            collection
                .doc(newBookId)
                .set(newBook.toMap(), options)
                .catchError((err) {
              print(err);
            });
          }
        });
      }
    } else if (file == null && imageUrl.length > 5) {
      print('2');
      Book newBook = Book(
        likes: likes,
        userId: book.userId,
        id: id,
        name: book.name,
        imageUrl: imageUrl,
        description: book.description,
        price: book.price,
        translate: book.translate,
        writer: book.writer,
        category: book.category,
        languages: book.languages,
        numofpage: book.numofpage,
      );
      collection.doc(id).set(newBook.toMap(), options).catchError((err) {
        print(err);
      });
    } else if (file != null && imageUrl.length > 5) {
      print('3');
      await storage
          .refFromURL(imageUrl)
          .delete()
          .catchError((err) => print(err));
      Reference ref = storage.ref().child('image_of_books/${newBookId}');
      TaskSnapshot uploadedFile = await ref.putFile(file);
      if (uploadedFile.state == TaskState.success) {
        ref.getDownloadURL().then(
          (value) {
            if (book.id == null) {
              Book newBook = Book(
                likes: likes,
                userId: book.userId,
                id: id,
                name: book.name,
                imageUrl: value,
                description: book.description,
                price: book.price,
                translate: book.translate,
                writer: book.writer,
                category: book.category,
                languages: book.languages,
                numofpage: book.numofpage,
              );
              collection
                  .doc(id)
                  .set(newBook.toMap(), options)
                  .catchError((err) {
                print(err);
              });
            }
          },
        );
      }
      ///////////////////////////
    }
  }

/////////////////////////////////////
  //get
  Stream<List<Book>> getBookInFirestore(String category) {
    print(category);
    if (category == 'toyota') {
      return collection
          .where('category', arrayContains: 'toyota')
          .snapshots()
          .map(
            (event) => event.docs
                .map(
                  (e) => Book.fromJson(e.data()),
                )
                .toList(),
          );
    }
    if (category == 'biology') {
      return collection
          .where('category', arrayContains: 'بایۆلۆجی')
          .snapshots()
          .map(
            (event) => event.docs
                .map(
                  (e) => Book.fromJson(
                    e.data(),
                  ),
                )
                .toList(),
          );
    }

    return collection.snapshots().map(
          (event) => event.docs
              .map(
                (e) => Book.fromJson(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<Book>> getMyBookInFirestore() {
    User user = FirebaseAuth.instance.currentUser;
    return collection.where('userId', isEqualTo: user.uid).snapshots().map(
          (event) => event.docs
              .map(
                (e) => Book.fromJson(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<Book>> getMyLikesInFirestore() {
    User user = FirebaseAuth.instance.currentUser;
    return collection
        .where('likes.${user.uid}', isEqualTo: true)
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        print(Book.fromJson(
          e.data(),
        ));
        return Book.fromJson(
          e.data(),
        );
      }).toList();
    });
  }

  ///////////////////////////////////
  //delete
  Future<void> deleteBookByIdFromFireStore(String id, String imageUrl) async {
    await collection.doc(id).delete().catchError((err) => print(err));

    await storage.refFromURL(imageUrl).delete().catchError((err) => print(err));
  }

  Future getUserByIdFromFireStore(String id) async {
    DocumentSnapshot snapshot = await collectionUser.doc(id).get();
    var data2 = snapshot.data() as Map;
    UserFireStoreInfo data = UserFireStoreInfo.fromJson(snapshot.data());
    return data;
  }

  Future changeBioFromFirestore(String id, String bio) async {
    await collectionUser.doc(id).update({'bio': bio}).then((value) {
      print('update bio');
    }).catchError((err) {
      print(err);
    });

    ;
  }

  Future<Book> findBookByIdFromFirestore(String id) async {
    DocumentSnapshot snapshot = await collection.doc(id).get();
    Book book = Book.fromJson(snapshot.data());
    return book;
  }

  Future<void> likeBooksToFirestore(String userId, String id) async {
    // DocumentSnapshot snapshot = await collection.doc(id).get();
    // Book book = Book.fromJson(snapshot.data());
    // return book;
    collection.doc(id).update({'likes.$userId': true});
  }

  Future<void> unLikeBooksToFirestore(String userId, String id) async {
    // DocumentSnapshot snapshot = await collection.doc(id).get();
    // Book book = Book.fromJson(snapshot.data());
    // return book;
    collection.doc(id).update({'likes.$userId': false});
  }
}

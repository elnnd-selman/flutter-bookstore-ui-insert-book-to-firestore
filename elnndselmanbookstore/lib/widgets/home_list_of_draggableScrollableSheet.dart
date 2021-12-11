import 'dart:ui';

import 'package:avreenbooks/colors.dart';
import 'package:avreenbooks/model/book_model.dart';
import 'package:avreenbooks/provider/firestore_provider.dart';
import 'package:avreenbooks/screens/detial_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './methodWidgets/dialogsignin.dart';

class HomeListOfDraggableScrollableSheet extends StatefulWidget {
  final Map likes;
  final String id;
  final String name;
  final String imageUrl;
  final String price;
  final bool isFavorites;
  final String writer;
  final String languages;
  final String numofpage;
  final String userId;
  final List category;
  final String translate;
  final String description;
  HomeListOfDraggableScrollableSheet(
      {Key key,
      @required this.numofpage,
      @required this.languages,
      @required this.id,
      @required this.userId,
      @required this.name,
      @required this.imageUrl,
      @required this.price,
      @required this.isFavorites,
      @required this.writer,
      @required this.category,
      @required this.translate,
      @required this.description,
      @required this.likes})
      : super(key: key);

  @override
  _HomeListOfDraggableScrollableSheetState createState() =>
      _HomeListOfDraggableScrollableSheetState();
}

class _HomeListOfDraggableScrollableSheetState
    extends State<HomeListOfDraggableScrollableSheet> {
  String numOfLikes() {
    List likesList = [];
    widget.likes.forEach((key, value) {
      if (value == true) {
        likesList.add(key);
      }
    });

    return likesList.length.toString();
  }

  bool like = false;
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (user != null) {
      if (widget.likes[user.uid] == true) {
        setState(() {
          like = true;
        });
      } else {
        setState(() {
          like = false;
        });
      }
    } else {
      setState(() {
        like = false;
      });
    }

    return Container(
      margin: EdgeInsets.only(bottom: 5),
      height: 155,
      child: Stack(
        children: [
          Positioned(
            // top: ,
            right: 10,
            left: 10,
            bottom: 0,
            child: Container(
              height: 135,
              // width: 330,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(29),
                color: redList,
              ),
            ),
          ),
          Positioned(
            left: 30,
            top: 35,
            bottom: 17,
            child: Container(
              height: 105,
              width: 70,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, DetialScreen.routeName,
                      arguments: Book(
                          numofpage: widget.numofpage,
                          userId: widget.userId,
                          id: widget.id,
                          name: widget.name,
                          imageUrl: widget.imageUrl,
                          description: widget.description,
                          languages: widget.languages,
                          price: double.parse(widget.price),
                          translate: widget.translate,
                          writer: widget.writer,
                          category: widget.category,
                          likes: widget.likes));
                },
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.network(widget.imageUrl),
                ),
              ),
            ),
          ),
          FutureBuilder(
            future: Provider.of<FirestoreClass>(context)
                .getUserByIdFromFireStore(widget.userId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 170,
                      height: 60,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ));
              }
              return Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 170,
                  height: 60,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 10,
                        top: 10,
                        left: 0,
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 5, right: 42, top: 5, bottom: 0),
                          width: 150,
                          decoration: BoxDecoration(
                            color: one,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            child: snapshot.hasData
                                ? Text(
                                    snapshot.data.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                    textDirection: TextDirection.rtl,
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border:
                                  Border.all(width: 2, color: greenCirculer)),
                          child: CircleAvatar(
                            radius: 27,
                            backgroundImage:
                                NetworkImage(snapshot.data.imageProfileUrl),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 17,
            right: 20,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Icon(
                        Icons.badge,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        widget.price,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Icon(
                        Icons.attach_money,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '${widget.numofpage} لاپەڕە',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Icon(
                        Icons.layers,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            left: 180,
            child: IconButton(
              iconSize: 30,
              icon: Icon(like ? Icons.favorite : Icons.favorite_outline),
              color: Colors.white,
              onPressed: () {
                if (user == null) {
                  return ShowDialogAlert().DialogSignIn(context, 'bka');
                }
                if (!like) {
                  return Provider.of<FirestoreClass>(context, listen: false)
                      .likeBooksToFirestore(user.uid, widget.id);
                }
                Provider.of<FirestoreClass>(context, listen: false)
                    .unLikeBooksToFirestore(user.uid, widget.id);
              },
            ),
          ),
          Positioned(
            bottom: 17,
            left: 150,
            child: Text(
              ' ${numOfLikes()} ڵایک',
              textDirection: TextDirection.rtl,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

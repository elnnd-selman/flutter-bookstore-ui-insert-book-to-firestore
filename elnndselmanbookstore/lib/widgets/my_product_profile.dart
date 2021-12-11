import 'package:avreenbooks/colors.dart';
import 'package:avreenbooks/provider/firestore_provider.dart';
import 'package:avreenbooks/screens/text_filed_book_screen.dart';
import 'package:avreenbooks/widgets/home_special_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProductProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: Provider.of<FirestoreClass>(context).getMyBookInFirestore(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data.length < 1) {
            return Center(child: Text('have not any Produc'));
          }
          return ListView.builder(
            itemBuilder: (context, index) {
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
                          color: one,
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
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image.network(snapshot.data[index].imageUrl),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 17,
                      right: 90,
                      child: Container(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(
                                  snapshot.data[index].name,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
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
                                  snapshot.data[index].price.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
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
                                  '${snapshot.data[index].numofpage} لاپەڕە',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
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
                        top: 28,
                        right: 20,
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                              color: greenCirculer,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                iconSize: 30,
                                icon: Icon(Icons.edit),
                                color: Colors.blueAccent,
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, TextFieldS.routeName,
                                      arguments: snapshot.data[index].id);
                                },
                              ),
                              IconButton(
                                iconSize: 30,
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () async {
                                  await Provider.of<FirestoreClass>(context,
                                          listen: false)
                                      .deleteBookByIdFromFireStore(
                                          snapshot.data[index].id,
                                          snapshot.data[index].imageUrl);
                                },
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              );
            },
            itemCount: snapshot.data.length,
          );
        },
      ),
    );
  }
}
        // return ListView.builder(
        //   itemBuilder: (context,index) {
        //     return Text('hi');


        
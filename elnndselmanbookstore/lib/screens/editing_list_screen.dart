import 'package:avreenbooks/colors.dart';
import 'package:avreenbooks/provider/firestore_provider.dart';
import 'package:avreenbooks/screens/drawer.dart';
import 'package:avreenbooks/screens/text_filed_book_screen.dart';
import 'package:avreenbooks/widgets/edite_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditinListScreen extends StatelessWidget {
  static const routeName = '/editinglist';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: one,
          title: Text('Editing List'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, TextFieldS.routeName);
              },
            ),
          ],
        ),
        drawer: DrawerScreen(),
        body: StreamBuilder(
          stream: Provider.of<FirestoreClass>(context).getBookInFirestore('All'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: redList,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 2),
                                  blurRadius: 2,
                                  spreadRadius: 2),
                              BoxShadow(color: redList)
                            ]),
                        child: ListTile(
                          leading: Text(
                            'we have ${snapshot.data.length} Books, Should any action?',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        )),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return EditeListItem(
                          id: snapshot.data[index].id,
                          imageUrl: snapshot.data[index].imageUrl,
                          name: snapshot.data[index].name,
                        );
                      },
                      itemCount: snapshot.data.length,
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}

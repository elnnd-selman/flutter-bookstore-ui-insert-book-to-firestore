import 'package:avreenbooks/colors.dart';
import 'package:avreenbooks/provider/firestore_provider.dart';
import 'package:avreenbooks/screens/text_filed_book_screen.dart';
import 'package:avreenbooks/widgets/text_filed_book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditeListItem extends StatefulWidget {
  final String id;
  final String name;
  final String imageUrl;

  const EditeListItem({
    Key key,
    this.id,
    this.name,
    this.imageUrl,
  }) : super(key: key);

  @override
  _EditeListItemState createState() => _EditeListItemState();
}

class _EditeListItemState extends State<EditeListItem> {
  @override
  Widget build(BuildContext context) {
    bool load = false;
    return Container(
      height: 100,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            color: Colors.black,
            blurRadius: 1,
          ),
          BoxShadow(
            offset: Offset(0, 0),
            color: Colors.white,
          ),
        ],
      ),
      child: load
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: ListTile(
                leading: Container(
                  width: 40,
                  height: 50,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.network(widget.imageUrl),
                  ),
                ),
                title: Text(
                  widget.name,
                  style: TextStyle(color: one, fontSize: 15),
                ),
                trailing: Container(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: one,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, TextFieldS.routeName,arguments: widget.id);
                          }),
                      IconButton(
                          icon: load
                              ? CircularProgressIndicator()
                              : Icon(Icons.delete, color: redList),
                          onPressed: () async {
                            setState(() {
                              load = !load;
                            });
                            Provider.of<FirestoreClass>(context, listen: false)
                                .deleteBookByIdFromFireStore(
                                    widget.id, widget.imageUrl);
                          })
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

import 'package:avreenbooks/colors.dart';
import 'package:avreenbooks/provider/firestore_provider.dart';
import 'package:avreenbooks/screens/user_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditeBio extends StatefulWidget {
  static const routeName = '/edite-bio';

  @override
  _EditeBioState createState() => _EditeBioState();
}

class _EditeBioState extends State<EditeBio> {
  final _text = TextEditingController();

  bool load = false;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(
                context, UserProdileScreen.routeName);
          },
        ),
        backgroundColor: one,
        actions: [
          load
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : TextButton(
                  onPressed: () async {
                    setState(() {
                      load = true;
                    });
                    await Provider.of<FirestoreClass>(context, listen: false)
                        .changeBioFromFirestore(user.uid, _text.text)
                        .then((value) {
                      setState(() {
                        load = false;
                      });
                    });

                    Navigator.pushReplacementNamed(
                        context, UserProdileScreen.routeName);
                  },
                  child: Text(
                    'باشە',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: TextField(
          controller: _text,
          decoration: InputDecoration(hintText: 'بیۆ'),
        ),
      ),
    );
  }
}

import 'package:avreenbooks/provider/firebaseAuth_provider.dart';
import 'package:avreenbooks/provider/firestore_provider.dart';
import 'package:avreenbooks/screens/detial_screen.dart';
import 'package:avreenbooks/screens/edite_bio.dart';
import 'package:avreenbooks/screens/editing_list_screen.dart';
import 'package:avreenbooks/screens/home.dart';
import 'package:avreenbooks/screens/signUp_screen.dart';
import 'package:avreenbooks/screens/text_filed_book_screen.dart';
import 'package:avreenbooks/screens/user_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => FirestoreClass(),
          ),
          StreamProvider<User>(
              create: (context) => FirebaseAuth_provider().user,
              initialData: null)
        ],
        child: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return MaterialApp(
                home: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return MaterialApp(
              title: 'Avreen Books',
              home: Home(),
              routes: {
                // Home.routeName: (context) => Home(),
                EditinListScreen.routeName: (context) => EditinListScreen(),
                TextFieldS.routeName: (context) => TextFieldS(),
                SignUp.routeName: (context) => SignUp(),
                UserProdileScreen.routeName: (context) => UserProdileScreen(),
                DetialScreen.routeName: (context) => DetialScreen(),
                EditeBio.routeName: (context) => EditeBio()
              },
            );
          },
        ));
  }
}

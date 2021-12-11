import 'package:avreenbooks/colors.dart';
import 'package:avreenbooks/provider/firestore_provider.dart';
import 'package:avreenbooks/screens/edite_bio.dart';
import 'package:avreenbooks/screens/home.dart';
import 'package:avreenbooks/widgets/favorie_list_profile.dart';
import 'package:avreenbooks/widgets/my_product_profile.dart';
import 'package:avreenbooks/widgets/save_list_in_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProdileScreen extends StatefulWidget {
  static const routeName = '/user-profile-screen';
  @override
  _UserProdileScreenState createState() => _UserProdileScreenState();
}

class _UserProdileScreenState extends State<UserProdileScreen> {
  int _selecting = 2;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    PageController _pageController =
        PageController(initialPage: 2, keepPage: true);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: one,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacementNamed(context, Home.routeName);
              }),
        ),
        body: Column(
          children: [
            Container(
                color: one,
                width: double.infinity,
                child: FutureBuilder(
                  future: Provider.of<FirestoreClass>(context)
                      .getUserByIdFromFireStore(user.uid),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(width: 5, color: greenCirculer),
                            color: one,
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                NetworkImage(snapshot.data.imageProfileUrl),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          snapshot.data.name,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapshot.data.bio != null ? snapshot.data.bio : "",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 40,
                          padding: EdgeInsets.only(right: 10, left: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: TextButton.icon(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, EditeBio.routeName);
                              },
                              icon: Icon(
                                Icons.edit,
                                color: greenCirculer,
                                size: 25,
                              ),
                              label: Text(
                                'دەسکاری بیۆ ',
                                style: TextStyle(color: one, fontSize: 16),
                              )),
                        )
                      ],
                    );
                  },
                )),
            Container(
              decoration: BoxDecoration(
                  color: one,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(70),
                      bottomRight: Radius.circular(70))),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      decoration: BoxDecoration(
                          color: greenCirculer,
                          borderRadius: BorderRadius.circular(50)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              _selecting == 0
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: Colors.white,
                              size: _selecting == 0 ? 40 : 28,
                            ),
                            onPressed: () {
                              setState(() {
                                _selecting = 0;
                                _pageController.animateToPage(_selecting,
                                    duration: Duration(milliseconds: 222),
                                    curve: Curves.bounceIn);
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              _selecting == 1
                                  ? Icons.person
                                  : Icons.person_outline,
                              color: Colors.white,
                              size: _selecting == 1 ? 40 : 28,
                            ),
                            onPressed: () {
                              setState(() {
                                _selecting = 1;
                                _pageController.animateToPage(_selecting,
                                    duration: Duration(milliseconds: 100),
                                    curve: Curves.bounceIn);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (value) {
                        setState(() {
                          _selecting = value;
                        });
                      },
                      children: [
                        FavoriteListProfile(),
                        // SaveListProfile(),
                        MyProductProfile()
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}

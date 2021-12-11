import 'package:avreenbooks/colors.dart';
import 'package:avreenbooks/model/category_item_model.dart';
import 'package:avreenbooks/provider/firestore_provider.dart';
import 'package:avreenbooks/screens/drawer.dart';
import 'package:avreenbooks/screens/text_filed_book_screen.dart';
import 'package:avreenbooks/widgets/home_list_category_item.dart';
import 'package:avreenbooks/widgets/home_list_of_draggableScrollableSheet.dart';
import 'package:avreenbooks/widgets/home_special_product.dart';
import 'package:avreenbooks/widgets/methodWidgets/dialogsignin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:location_permissions/location_permissions.dart';

class Home extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String categoryCheck = 'All';
  int selectedItemCategory = 0;

  @override
  Widget build(BuildContext context) {
    void handleLocaion() async {
      var permission = await LocationPermissions().requestPermissions();
    }

    List categoryItem = [
      CategoryItemModel(
        category: 'All',
        fun: () {
          setState(() {
            selectedItemCategory = 0;

            categoryCheck = 'All';
          });
        },
        image: 'assets/images/history.jpg',
      ),
      CategoryItemModel(
        category: 'History',
        fun: () {
          setState(() {
            selectedItemCategory = 1;
            categoryCheck = 'history';
          });
        },
        image: 'assets/images/history.jpg',
      ),
      CategoryItemModel(
          category: 'Biology',
          fun: () {
            setState(() {
              selectedItemCategory = 2;
              categoryCheck = 'biology';
            });
          },
          image: 'assets/images/biology.jpg'),
      CategoryItemModel(
          category: 'Education',
          fun: () {},
          image: 'assets/images/education.png'),
    ];
    User user = Provider.of<User>(context);
    if (user != null) {
      print(user.email);
    } else {
      print('user nyaa');
    }
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
            builder: (context) => IconButton(
                  icon: Icon(Icons.menu_rounded, color: Colors.black),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                )),
        title: Text(
          'lalavook',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              icon: Icon(
                Icons.handyman,
                color: Colors.black,
              ),
              onPressed: () async {
                handleLocaion();
              }),
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () async {
                if (Provider.of<User>(context, listen: false) != null) {
                  return await Navigator.pushNamed(
                      context, TextFieldS.routeName);
                }
                await ShowDialogAlert().DialogSignIn(context, 'nothing');
              }),
        ],
      ),
      drawer: DrawerScreen(),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 240,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => HomeSpecialProduct(),
                      itemCount: 20,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 55,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => HomeListCategoryItem(
                        category: categoryItem[index].category,
                        function: categoryItem[index].fun,
                        image: categoryItem[index].image,
                        index: index,
                        selecting: selectedItemCategory,
                      ),
                      itemCount: categoryItem.length,
                    ),
                  ),
                ],
              ),
              DraggableScrollableSheet(
                maxChildSize: 1,
                minChildSize: 0.47,
                initialChildSize: 0.47,
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            offset: Offset(1, 1),
                            color: Colors.black26,
                            spreadRadius: 2.7,
                          ),
                          BoxShadow(
                              blurRadius: 1,
                              offset: Offset(2, 1),
                              color: Colors.white),
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        )),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 10, right: 10),
                      child: StreamBuilder(
                          stream: Provider.of<FirestoreClass>(context)
                              .getBookInFirestore(categoryCheck),
                          builder: (context, snapshot) {
                            // var data = snapshot.data;
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  backgroundColor: greenCirculer,
                                ),
                              );
                            }
                            if (snapshot.data.length < 1) {
                              return Center(
                                child: Text('we have not data'),
                              );
                            }
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                return HomeListOfDraggableScrollableSheet(
                                    likes: snapshot.data[index].likes,
                                    translate: snapshot.data[index].translate,
                                    description:
                                        snapshot.data[index].description,
                                    category: snapshot.data[index].category,
                                    userId: snapshot.data[index].userId,
                                    numofpage: snapshot.data[index].numofpage,
                                    languages: snapshot.data[index].languages,
                                    id: snapshot.data[index].id,
                                    name: snapshot.data[index].name,
                                    imageUrl: snapshot.data[index].imageUrl,
                                    price:
                                        snapshot.data[index].price.toString(),
                                    isFavorites:
                                        snapshot.data[index].isFavorites,
                                    writer: snapshot.data[index].writer);
                              },
                              itemCount: snapshot.data.length,
                              controller: scrollController,
                            );
                          }),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:avreenbooks/colors.dart';
import 'package:flutter/material.dart';

class HomeListCategoryItem extends StatelessWidget {
  final int selecting;
  final int index;
  final String category;
  final Function function;
  final String image;
  const HomeListCategoryItem({
    Key key,
    @required this.category,
    @required this.function,
    @required this.image,
    @required this.selecting,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 160,
      decoration: BoxDecoration(
          color: selecting == index ? redList : greenCirculer,
          borderRadius: BorderRadius.circular(26)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(image),
        ),
        title: Text(
          category,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        onTap: function,
      ),
    );
  }
}

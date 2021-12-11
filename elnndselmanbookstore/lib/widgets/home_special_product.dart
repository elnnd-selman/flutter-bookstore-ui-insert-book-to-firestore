import 'package:avreenbooks/colors.dart';
import 'package:flutter/material.dart';

class HomeSpecialProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      // color: Colors.black,
      height: 170,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50, left: 10, right: 10),
            width: 340,
            height: 163,
            decoration: BoxDecoration(
              color: one,
              borderRadius: BorderRadius.circular(29),
            ),
          ),
          Positioned(
            top: 10,
            left: 30,
            child: Container(
              width: 100,
              height: 155,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.network(
                  'https://m.media-amazon.com/images/I/41gr3r3FSWL.jpg',
                ),
              ),
            ),
          ),
          Positioned(
              top: 60,
              right: 0,
              child: Container(
                width: 240,
                height: 135,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Gradient',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Container(
                          height: 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kurdish',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                              Text(
                                '159 pages',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 25,
                          width: 54,
                          decoration: BoxDecoration(
                              color: yellow,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text('NEW'),
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 90,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: greenCirculer,
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                              Positioned(
                                  top: 0,
                                  child: Text(
                                    '5',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 77),
                                  ))
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

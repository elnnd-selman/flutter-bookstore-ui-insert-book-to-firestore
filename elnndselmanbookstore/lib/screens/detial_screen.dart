import 'package:avreenbooks/colors.dart';
import 'package:avreenbooks/model/book_model.dart';
import 'package:flutter/material.dart';

class DetialScreen extends StatefulWidget {
  static const routeName = '/detial-screen';
  @override
  _DetialScreenState createState() => _DetialScreenState();
}

class _DetialScreenState extends State<DetialScreen> {
  Book book = Book(
    numofpage: '',
    userId: '',
    id: '',
    name: '',
    imageUrl: '',
    description: '',
    languages: '',
    price: 0,
    translate: '',
    writer: '',
    category: [],
    likes: {},
  );

  @override
  void didChangeDependencies() {
    Book newBook = ModalRoute.of(context).settings.arguments as Book;
    setState(() {
      book = Book(
          numofpage: newBook.numofpage,
          userId: newBook.userId,
          id: newBook.id,
          name: newBook.name,
          imageUrl: newBook.imageUrl,
          description: newBook.description,
          languages: newBook.languages,
          price: newBook.price,
          translate: newBook.translate,
          writer: newBook.writer,
          category: newBook.category,
          likes: newBook.likes);
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ModalRoute.of(context).settings.arguments as Book;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.center,
                height: 260,
                width: 174,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.network(book.imageUrl),
                ),
              ),
              Divider(
                height: 10,
                color: one,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    ' ???????? ??????????????:${book.name}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.person,
                    size: 30,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    ' ??????????:${book.description}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.person,
                    size: 30,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '??????  :${book.price.toString()} ?????????? ??????????',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.person,
                    size: 30,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '?????????? ???? ${book.languages} ???? ??????????  :${book.translate}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.person,
                    size: 30,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '????????????  :${book.writer}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.person,
                    size: 30,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Text(
              //       '??????  :${book.dep}',
              //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              //       textDirection: TextDirection.rtl,
              //     ),
              //     SizedBox(
              //       width: 8,
              //     ),
              //     Icon(
              //       Icons.person,
              //       size: 30,
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '???????????? ??????????  :${book.numofpage}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.person,
                    size: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

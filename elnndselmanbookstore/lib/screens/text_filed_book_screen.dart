import 'dart:io';

import 'package:avreenbooks/colors.dart';
import 'package:avreenbooks/model/book_model.dart';
import 'package:avreenbooks/provider/firestore_provider.dart';
import 'package:avreenbooks/widgets/selecting_category.dart';
import 'package:avreenbooks/widgets/text_filed_book.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextFieldS extends StatefulWidget {
  static const routeName = '/add-product';

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<TextFieldS> {
  final _form = GlobalKey<FormState>();
  final _id = TextEditingController();

  final _imageUrl = TextEditingController();
  final _description = TextEditingController();
  final _price = TextEditingController();
  final _translate = TextEditingController();
  final _writer = TextEditingController();
  final _dep = TextEditingController();
  final _languages = TextEditingController();
  final _numOfPage = TextEditingController();
  final _name = TextEditingController();
  File file;
  Book _dataOfbook;
  Map likes;
  bool load = false;
  bool value = false;
  List category = [];

  @override
  void didChangeDependencies() async {
    User user = Provider.of<User>(context, listen: false);

    setState(() {
      _dataOfbook = Book(
        id: null,
        name: '',
        imageUrl: '',
        description: '',
        price: 0,
        translate: '',
        writer: '',
        category: [],
        userId: user.uid,
        languages: '',
        numofpage: '',
        likes: {},
      );
    });

    String id = ModalRoute.of(context).settings.arguments as String;
    if (id != null) {
      Book book = await Provider.of<FirestoreClass>(context)
          .findBookByIdFromFirestore(id);
      setState(() {
        likes = book.likes;
      });

      _id.text = book.id;
      _name.text = book.name;
      _imageUrl.text = book.imageUrl;
      _description.text = book.description;
      _price.text = book.price.toString();
      _translate.text = book.translate;
      _writer.text = book.writer;

      _languages.text = book.languages;
      _numOfPage.text = book.numofpage;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrl.dispose();
    _description.dispose();
    _price.dispose();
    _translate.dispose();
    _writer.dispose();
    _dep.dispose();
    _numOfPage.dispose();
    _languages.dispose();
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final books = Provider.of<FirestoreClass>(context);
    User user = Provider.of<User>(context, listen: false);

    void _selectCategoryFun(List<int> list) {
      print(list);
      if (list.contains(0)) {
        if (!category.contains('میژوو')) {
          setState(() {
            category.add('میژوو');
          });
        }
      } else {
        setState(() {
          if (category.contains('میژوو')) {
            category.remove('میژوو');
          }
        });
      }
      if (list.contains(1)) {
        if (!category.contains('بایۆلۆجی')) {
          setState(() {
            category.add('بایۆلۆجی');
          });
        }
      } else {
        setState(() {
          if (!category.contains('بایۆلۆجی')) {
            category.remove('بایۆلۆجی');
          }
        });
      }
      setState(() {
        _dataOfbook = Book(
          id: null,
          name: '',
          imageUrl: '',
          description: '',
          price: 0,
          translate: '',
          writer: '',
          category: category,
          userId: user.uid,
          languages: '',
          numofpage: '',
          likes: {},
        );
      });
    }

    //save
    void _saveToFireStoreAndFireStorage() async {
      _form.currentState.save();

      if (_form.currentState.validate() && _dataOfbook.name.length > 2) {
        print(_dataOfbook.name);

        setState(() {
          load = true;
        });
        await books
            .addToFireStore(_dataOfbook, file, _imageUrl.text, _id.text, likes)
            .then((_) {
          setState(() {
            load = false;
          });
        });
        Navigator.pop(context);
      }
    }

    //upload image
    void _uploadImage() async {
      final _picker = ImagePicker();
      PickedFile image;

      image = await _picker.getImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          file = File(image.path);
        });
      } else {
        print('empty image no path');
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: redList,
        actions: [
          load
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : TextButton.icon(
                  onPressed: _saveToFireStoreAndFireStorage,
                  icon: Icon(Icons.save, color: Colors.white),
                  label: Text('باشە',
                      style: TextStyle(fontSize: 20, color: Colors.white)))
        ],
      ),
      body: Column(
        children: [
          Form(
            key: _form,
            child: Expanded(
              child: ListView(
                children: [
                  TextFieldBook(
                    validat: 'name',
                    type: TextInputType.name,
                    controller: _name,
                    labelText: 'ناوی پەرتووک یاخوود ناوی بەرهەمەکە',
                    onChange: (value) {
                      _dataOfbook = Book(
                        likes: _dataOfbook.likes,
                        id: null,
                        name: value,
                        description: _dataOfbook.description,
                        price: _dataOfbook.price,
                        translate: _dataOfbook.translate,
                        writer: _dataOfbook.writer,
                        category: _dataOfbook.category,
                        imageUrl: _dataOfbook.imageUrl,
                        userId: _dataOfbook.userId,
                        languages: _dataOfbook.languages,
                        numofpage: _dataOfbook.numofpage,
                      );
                    },
                  ),
                  SelectingCategory(selectCategoryFun: _selectCategoryFun),
                  TextFieldBook(
                    validat: 'writer',
                    type: TextInputType.text,
                    controller: _writer,
                    labelText: 'ناوی نووسەرەکە',
                    onChange: (value) {
                      _dataOfbook = Book(
                        likes: _dataOfbook.likes,
                        id: null,
                        name: _dataOfbook.name,
                        description: _dataOfbook.description,
                        price: _dataOfbook.price,
                        translate: _dataOfbook.translate,
                        writer: value,
                        category: _dataOfbook.category,
                        imageUrl: _dataOfbook.imageUrl,
                        userId: _dataOfbook.userId,
                        languages: _dataOfbook.languages,
                        numofpage: _dataOfbook.numofpage,
                      );
                    },
                  ),
                  TextFieldBook(
                    validat: 'translate',
                    type: TextInputType.text,
                    controller: _translate,
                    labelText: 'ناوی وەرگێر ئەگەر هەبوو',
                    onChange: (value) {
                      _dataOfbook = Book(
                        likes: _dataOfbook.likes,
                        id: null,
                        name: _dataOfbook.name,
                        description: _dataOfbook.description,
                        price: _dataOfbook.price,
                        translate: value,
                        writer: _dataOfbook.writer,
                        category: _dataOfbook.category,
                        imageUrl: _dataOfbook.imageUrl,
                        userId: _dataOfbook.userId,
                        languages: _dataOfbook.languages,
                        numofpage: _dataOfbook.numofpage,
                      );
                    },
                  ),
                  TextFieldBook(
                    validat: 'price',
                    type: TextInputType.number,
                    controller: _price,
                    labelText: 'نرخ بە ژمارە',
                    onChange: (value) {
                      _dataOfbook = Book(
                        id: null,
                        likes: _dataOfbook.likes,
                        name: _dataOfbook.name,
                        description: _dataOfbook.description,
                        price: double.parse(value),
                        translate: _dataOfbook.translate,
                        writer: _dataOfbook.writer,
                        category: _dataOfbook.category,
                        imageUrl: _dataOfbook.imageUrl,
                        userId: _dataOfbook.userId,
                        languages: _dataOfbook.languages,
                        numofpage: _dataOfbook.numofpage,
                      );
                    },
                  ),
                  TextFieldBook(
                    validat: 'description',
                    type: TextInputType.text,
                    controller: _description,
                    labelText: 'کوورتەیەک بنووسە لەسەر بەرهەمەکە',
                    onChange: (value) {
                      _dataOfbook = Book(
                        likes: _dataOfbook.likes,
                        id: null,
                        name: _dataOfbook.name,
                        description: value,
                        price: _dataOfbook.price,
                        translate: _dataOfbook.translate,
                        writer: _dataOfbook.writer,
                        category: _dataOfbook.category,
                        imageUrl: _dataOfbook.imageUrl,
                        userId: _dataOfbook.userId,
                        languages: _dataOfbook.languages,
                        numofpage: _dataOfbook.numofpage,
                      );
                    },
                  ),
                  TextFieldBook(
                    validat: 'languages',
                    type: TextInputType.text,
                    controller: _languages,
                    labelText: 'زمانی پەرتووک',
                    onChange: (value) {
                      _dataOfbook = Book(
                        likes: _dataOfbook.likes,
                        id: null,
                        name: _dataOfbook.name,
                        description: _dataOfbook.description,
                        price: _dataOfbook.price,
                        translate: _dataOfbook.translate,
                        writer: _dataOfbook.writer,
                        category: _dataOfbook.category,
                        imageUrl: _dataOfbook.imageUrl,
                        userId: _dataOfbook.userId,
                        languages: value,
                        numofpage: _dataOfbook.numofpage,
                      );
                    },
                  ),
                  TextFieldBook(
                    validat: 'numofpages',
                    type: TextInputType.number,
                    controller: _numOfPage,
                    labelText: 'ژمارەی ڵاپەرەی بەرهەمەکەت',
                    onChange: (value) {
                      _dataOfbook = Book(
                        likes: _dataOfbook.likes,
                        id: null,
                        name: _dataOfbook.name,
                        description: _dataOfbook.description,
                        price: _dataOfbook.price,
                        translate: _dataOfbook.translate,
                        writer: _dataOfbook.writer,
                        category: _dataOfbook.category,
                        imageUrl: _dataOfbook.imageUrl,
                        userId: _dataOfbook.userId,
                        languages: _dataOfbook.languages,
                        numofpage: value,
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            width: 150,
                            height: 200,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: redList),
                            ),
                            child: FittedBox(
                                fit: BoxFit.fill,
                                child: file != null
                                    ? Image.file(
                                        file,
                                        fit: BoxFit.fill,
                                      )
                                    : _imageUrl.text.length > 5
                                        ? Image.network(
                                            _imageUrl.text,
                                            fit: BoxFit.fill,
                                          )
                                        : Text('وێنە ')),
                          ),
                        ),
                        Flexible(
                          child: TextButton.icon(
                            style: ButtonStyle(
                                visualDensity:
                                    VisualDensity.adaptivePlatformDensity),
                            onPressed: _uploadImage,
                            icon: Icon(Icons.image, color: redList, size: 50),
                            label: Text(
                              'وێنەیەک دابنێ ',
                              style: TextStyle(color: redList, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

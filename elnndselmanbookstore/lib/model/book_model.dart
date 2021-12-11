import 'package:flutter/material.dart';

class Book {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final double price;
  final String translate;
  final String languages;
  final String writer;
  final String numofpage;
  final bool isFavorites;
  final List category;
  final String userId;
  final Map<String, dynamic> likes;
  Book({
    @required this.likes,
    @required this.numofpage,
    @required this.userId,
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.description,
    @required this.languages,
    @required this.price,
    @required this.translate,
    @required this.writer,
    @required this.category,
    this.isFavorites = false,
  });
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      price: json['price'],
      translate: json['translate'],
      writer: json['writer'],
      category: json['category'],
      isFavorites: json['isFavorites'],
      userId: json['userId'],
      languages: json['languages'],
      numofpage: json['numofpage'],
      likes: json['likes'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'price': price,
      'translate': translate,
      'numofpage': numofpage,
      'languages': languages,
      'writer': writer,
      'category': category,
      'isFavorites': isFavorites,
      'userId': userId,
      'likes': likes
    };
  }
}

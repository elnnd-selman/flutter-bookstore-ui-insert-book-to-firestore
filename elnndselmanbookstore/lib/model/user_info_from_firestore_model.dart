import 'package:flutter/material.dart';

class UserFireStoreInfo {
  final String id;
  final String name;
  final String imageProfileUrl;
  final String bio;
  UserFireStoreInfo(
      {@required this.id,
      @required this.name,
      @required this.imageProfileUrl,
      this.bio = ''});
  factory UserFireStoreInfo.fromJson(Map<String, dynamic> json) {
    return UserFireStoreInfo(
        id: json['id'],
        name: json['name'],
        imageProfileUrl: json['imageProfileUrl'],
        bio: json['bio']);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageProfileUrl': imageProfileUrl,
      'bio': bio,
    };
  }
}

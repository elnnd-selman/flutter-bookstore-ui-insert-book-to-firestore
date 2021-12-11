import 'package:avreenbooks/colors.dart';
import 'package:avreenbooks/model/book_model.dart';
import 'package:flutter/material.dart';

class TextFieldBook extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final Function onChange;
  final type;
  final String validat;
  const TextFieldBook({
    Key key,
    @required this.labelText,
    @required this.controller,
    @required this.onChange,
    @required this.type,
    @required this.validat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: TextFormField(
          keyboardType: type,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(15.7),
            ),
            labelText: labelText,
            labelStyle: TextStyle(color: redList),
            // contentPadding: const EdgeInsets.only(
            //     left: 14.0, bottom: 8.0, top: 8.0),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: redList),
              borderRadius: BorderRadius.circular(15.7),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: one),
              borderRadius: BorderRadius.circular(15.7),
            ),
          ),
          textInputAction: TextInputAction.newline,
          onSaved: onChange,
          validator: (value) {
            if (validat == 'name'||validat=='writer'||validat=='translate') {
              if (value.length > 9 || value.length < 3) {
                return 'پێویستە لە نێوان ٣ تا ٩ پیت دا بیت';
              }
            }
            if (validat == 'languages') {
              if ( value.length < 3) {
                return 'پێویستە لە  ٣ زیاتر بێت';
              }
            }
            if (validat == 'description') {
              if ( value.length < 20||value.length > 100) {
                return 'پێویستە لە نێوان ٢٠ تا ١٠٠ پیت دا بیت';
              }
            }
             if (validat == 'price') {
              if (value.length > 3) {
                return ' ئەمە ژمارەیە ڕێگە پێنەدراوە';
              }
            }
             if (validat == 'numofpages') {
              if (value.length > 4) {
                return ' ئەمە ژمارەیە ڕێگە پێنەدراوە';
              }
            }
            return null;
          }),
    ));
  }
}

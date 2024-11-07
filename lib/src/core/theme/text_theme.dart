import 'package:flutter/material.dart';

class TextStyles {
  //header  text style
  static TextStyle headerText = const TextStyle(
      fontSize: 22, color: Color(0xff000000), fontWeight: FontWeight.w500);
  //text field text style
  static TextStyle fieldText = const TextStyle(
      fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400);
  //simple  text style
  static TextStyle simpleText = const TextStyle(
      fontSize: 20, color: Colors.black, fontWeight: FontWeight.w300);
  // mini text
  static TextStyle miniText = const TextStyle(
      fontSize: 14, color: Color(0xff868686), fontWeight: FontWeight.normal);
  // bold mini text
  static TextStyle boldMiniText = const TextStyle(
      fontSize: 14, color: Color(0xff868686), fontWeight: FontWeight.bold);
  // underline text
  static TextStyle underlineText = const TextStyle(
      fontSize: 14,
      color: Color(0xff868686),
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.underline,
      decorationColor: Color(0xff868686));
  // profile tile text
  static TextStyle tileText = const TextStyle(
    fontSize: 12,
    color: Color(0xff868686),
    fontWeight: FontWeight.normal,
  );
}

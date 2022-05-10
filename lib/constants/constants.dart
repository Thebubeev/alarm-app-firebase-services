import 'package:flutter/material.dart';

final titleText =
    TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontFamily: 'Gilroy');
final usualText = TextStyle(fontSize: 20, fontFamily: 'Gilroy');
final bottomText =
    TextStyle(color: Colors.white, fontFamily: 'Gilroy', fontSize: 17);
final bottomBlackText =
    TextStyle(fontFamily: 'Gilroy', fontSize: 17, color: Colors.black);
final borderRad = BorderRadius.only(
  topLeft: Radius.circular(10.0),
  bottomLeft: Radius.circular(10.0),
  bottomRight: Radius.circular(10.0),
  topRight: Radius.circular(10.0),
);

const kPrimaryColor = Color(0xFF00BF6D);
const kSecondaryColor = Color(0xFFFE9901);
const kContentColorLightTheme = Color(0xFF1D1D35);
const kContentColorDarkTheme = Color(0xFFF5FCF9);
const kWarninngColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);

const kDefaultPadding = 20.0;


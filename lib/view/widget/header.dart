import 'package:flutter/material.dart';

AppBar header(context, {removeBackbutton = false}) {
  return AppBar(
    title: Text(
      'PawnBook',
      style: TextStyle(fontFamily: "ShortBaby"),
    ),
  );
}

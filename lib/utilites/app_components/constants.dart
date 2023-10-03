import 'package:flutter/material.dart';

InputDecoration kSearchTextField() {
    return InputDecoration(
                      prefixIconColor: Colors.grey,
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(15.0)),
                      ));
  }

const kMainHeadingStyle = TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold);

const kButtonStyle = TextStyle(fontSize: 18.0);




import 'package:flutter/material.dart';

class AppWidget{
  static TextStyle boldTextFieldStyle(){
    return TextStyle(
        fontSize: 20,
        color: Colors.black87,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins");
  }
  static TextStyle headlineTextFieldStyle(){
    return TextStyle(
        fontSize: 22,
        color: Colors.black87,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins");
  }
  static TextStyle lightTextFieldStyle(){
    return TextStyle(
        fontSize: 15,
        color: Colors.black38,
        fontWeight: FontWeight.w500,
        fontFamily: "Poppins");
  }
  static TextStyle semiBoldTextFieldStyle(){
    return TextStyle(
        fontSize: 16,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
        fontFamily: "Poppins");
  }
}
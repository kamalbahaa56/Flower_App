import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget DefultBouttomn({
// ignore: non_constant_identifier_names
required VoidCallback OnPressed,
required String text,
})=>SizedBox(
  width: double.infinity,
  height: 40,
  child:   ElevatedButton(
  
    onPressed: OnPressed, 
  
    child: Text(text)
  
    ),
);
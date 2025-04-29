import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({this.labelText});
  String? labelText;
  @override
  Widget build(BuildContext context) {

    return TextField(
      cursorColor: Colors.white,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white, width: 1),
          )),
    );
  }
}

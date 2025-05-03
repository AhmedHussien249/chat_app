import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField({ this.labelText, this.onChanged, this.obscureText = false});

  String? labelText;
  Function(String)? onChanged;
  bool obscureText ;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data){
        if (data!.isEmpty) {
          return 'Please enter your $labelText';
        }
      },
      onChanged: onChanged,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      obscureText: obscureText,
      cursorColor: Colors.white,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white, width: 1),
          )),
    );
  }
}

import 'package:bsims/const/colors.dart';
import 'package:flutter/material.dart';

class WhiteTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  
  const WhiteTextfield(
      {super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(cursorColor: Colors.black,
    
      controller: controller,
      decoration:  InputDecoration(fillColor: white, filled: true,
     border: OutlineInputBorder(borderSide: BorderSide.none), hintText: label
      ),
    );
  }
}

import 'package:bsims/const/textstyle.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  
  const TextFieldWidget(
      {super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:20.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
          ),
          const SizedBox(height: 20,),
          SizedBox(width: 250, height: 40,
            child: TextField(cursorColor: Colors.black,
              controller: controller,
              decoration:  InputDecoration(filled: false, hintText: 'Enter $label',hintStyle: bodyText(Colors.grey, 14),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 0.5, color: Colors.grey)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  
  const TextFieldWidget(
      {super.key, required this.controller, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
        ),
        const SizedBox(height: 10,),
        TextField(cursorColor: Colors.black,
          controller: controller,
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.5, color: Colors.black)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.black)),
          ),
        ),
      ],
    );
  }
}

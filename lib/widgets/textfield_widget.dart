import 'package:bsims/const/colors.dart';
import 'package:bsims/const/textstyle.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  bool? isObscure;
  double? width;

  TextFieldWidget(
      {super.key,
      required this.controller,
      required this.label, this.width=600,
      this.isObscure = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: headline(black, 14),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            cursorColor: Colors.black,
            controller: controller,
            obscureText: isObscure!,
            decoration: InputDecoration(
              filled: false,
              hintText: 'Enter $label',
              hintStyle: bodyText(Colors.grey, 14),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 0.5, color: Color.fromARGB(255, 224, 215, 215))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: purple!)),
            ),
          ),
        ],
      ),
    );
  }
}

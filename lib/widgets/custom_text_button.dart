import 'package:bsims/const/colors.dart';
import 'package:bsims/const/textstyle.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final text;
  final onPressed;
  const CustomTextButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text, style: bodyText(black, 12),),
    );
  }
}

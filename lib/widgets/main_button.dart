import 'package:flutter/material.dart';

class CustomMainButton extends StatelessWidget {
  final double  width;
  final double height;
  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  const CustomMainButton(
      {super.key,
      required this.width,
      required this.height,
      required this.onPressed,
      required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

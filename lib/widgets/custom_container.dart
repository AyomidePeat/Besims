import 'package:bsims/const/colors.dart';
import 'package:bsims/const/textstyle.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final String label;

  final String quantity;
  const CustomContainer({
    super.key,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    required this.label,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(right: 20),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(5), color: white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                label,
                style: headline(bgColor, 14),
              ),
              const SizedBox(width: 7),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: iconColor),
                child: Icon(
                  icon,
                  color: white,
                  size: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            '₦ ${quantity.toString()}',
            style: headline(black, 20),
          )
        ],
      ),
    );
  }
}

import 'package:bsims/const/colors.dart';
import 'package:bsims/const/textstyle.dart';
import 'package:bsims/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final String label;

  final quantity;
  const CustomContainer(
      {super.key,
      required this.icon,
      required this.bgColor,
      required this.iconColor,
      required this.label,
      required this.quantity,});

  @override
  Widget build(BuildContext context) {
    
    return Container(padding: const EdgeInsets.all(10),margin: const EdgeInsets.only(right:20),
      
       decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: bgColor),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: iconColor),
            child: Icon(icon, color: white, size: 20,),
          ),const SizedBox(width:7),
          Column(
            children: [
              Text(
                label,
                style: headline(black, 12),
              ),
              const SizedBox(height:5),
              Text(
                quantity.toString(),
                style: bodyText(black, 12),
              ),
              CustomTextButton(
                onPressed: () {},
                text: 'View',
              )
            ],
          )
        ],
      ),
    );
  }
}

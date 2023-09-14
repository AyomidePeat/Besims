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
    
    return Container(padding: EdgeInsets.all(10),margin: EdgeInsets.only(right:20),
      
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
          ),SizedBox(width:7),
          Column(
            children: [
              Text(
                label,
                style: headline(black, 12),
              ),
              SizedBox(height:5),
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

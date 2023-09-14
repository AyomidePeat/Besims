import 'package:bsims/const/colors.dart';
import 'package:bsims/const/textstyle.dart';
import 'package:flutter/material.dart';

class StandardContainer extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
 
  final quantity;
  const StandardContainer(
      {super.key,
      required this.icon,
    
      required this.iconColor,
      required this.label,
      required this.quantity, });

  @override
  Widget build(BuildContext context) {
    
    return Container(padding: const EdgeInsets.all(10),margin: const EdgeInsets.only(right:20),
      
       decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: white),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: bodyText(black, 12),
              ),
              const SizedBox(height:5),
              Text(
                quantity.toString(),
                style: headline(black, 12),
              ),
              
            ],
          ),Icon(icon, color: iconColor, size: 20,),
        ],
      ),
    );
  }
}

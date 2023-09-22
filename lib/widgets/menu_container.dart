import 'package:bsims/const/colors.dart';
import 'package:bsims/const/textstyle.dart';
import 'package:flutter/material.dart';

class MenuContainer extends StatelessWidget {
  MenuContainer({super.key});
  List icons = [
    Icons.home,
    Icons.store,
    Icons.person,
    Icons.supervised_user_circle_sharp,
    Icons.category_outlined,
    Icons.shopify_rounded,
    Icons.delivery_dining,
    Icons.bar_chart
  ];
  List screens = [
    'DashBoard',
    'Stores',
    'Users',
    'Suppliers',
    'Category',
    'Products',
    'Orders',
    'Reports'
  ];
  @override
  Widget build(BuildContext context) {

    return Container(
      width: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: green,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text('BESIMS', style: headline(white, 20),),
         const SizedBox(height:40),
          Flexible(
            child: ListView.builder(
                itemCount: screens.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom:30.0),
                    child: Row( 
                      children: [
                        Icon(icons[index], color: white,),
                        const SizedBox(width:10),
                        Text(screens[index], style: bodyText(white, 14),)
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

import 'package:bsims/const/colors.dart';
import 'package:bsims/const/textstyle.dart';

import 'package:bsims/widgets/drawer_pane.dart';

import 'package:flutter/material.dart';

class MenuContainer extends StatefulWidget {
  final double screenWidth;
  final MenuStuff currentItem;
  final Size size;
  final ValueChanged<MenuStuff> onSelectedItem;

  MenuContainer(
      {super.key,
      required this.screenWidth,
      required this.size,
      required this.onSelectedItem,
      required this.currentItem});

  @override
  State<MenuContainer> createState() => _MenuContainerState();
}

class _MenuContainerState extends State<MenuContainer> {
  List icons = [
    Icons.home,
    Icons.store,
    Icons.person,
    Icons.supervised_user_circle_sharp,
    Icons.category_outlined,
    Icons.shopify_rounded,
    Icons.delivery_dining,
    Icons.business,
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
    'Point of Sales',
    'Reports'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Be Seamless',
                style: headline(purple!, 20),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.show_chart_sharp,
                color: Colors.purple[900],
              ),
            ],
          ),
          const SizedBox(height: 40),
          Flexible(
              child: NavigationPane(
                  currentItem: widget.currentItem,
                  onSelectedItem: widget.onSelectedItem)),
        ],
      ),
    );
  }
}

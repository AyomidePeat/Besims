import 'package:bsims/const/colors.dart';
import 'package:bsims/const/textstyle.dart';

import 'package:bsims/screens/admin_dashboard/widgets/drawer_pane.dart';

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
          Text(
            'Be Seamless',
            style: headline(white, 20),
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

import 'package:bsims/const/colors.dart';
import 'package:bsims/const/textstyle.dart';

import 'package:bsims/screens/cashier_dashboard/widgets/cashier_drawer.dart';

import 'package:flutter/material.dart';

class CashierMenuContainer extends StatefulWidget {
  final double screenWidth;
  final MenuStuff currentItem;
  final Size size;
  final ValueChanged<MenuStuff> onSelectedItem;

  CashierMenuContainer(
      {super.key,
      required this.screenWidth,
      required this.size,
      required this.onSelectedItem,
      required this.currentItem});

  @override
  State<CashierMenuContainer> createState() => _CashierMenuContainerState();
}

class _CashierMenuContainerState extends State<CashierMenuContainer> {
  List icons = [
    Icons.home,
    Icons.category_outlined,
    Icons.shopify_rounded,
    Icons.shopping_cart_checkout,
    Icons.delivery_dining,
    Icons.bar_chart
  ];

  List screens = [
    'DashBoard',
    'Category',
    'Products',
    'Sales'
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
              child: CashierNavigationPane(
                  currentItem: widget.currentItem,
                  onSelectedItem: widget.onSelectedItem)),
        ],
      ),
    );
  }
}

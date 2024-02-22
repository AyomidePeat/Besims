import 'package:bsims/const/colors.dart';
import 'package:bsims/const/textstyle.dart';
import 'package:bsims/screens/cashier_dashboard/widgets/cashier_drawer_pane.dart';
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
    Icons.delivery_dining,
    Icons.business,
   
  ];

  List screens = [
    'DashBoard',
    'Category',
    'Products',
    'Orders',
    'Point of Sales',
    
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
              child: CashierNavigationPane(
                  currentItem: widget.currentItem,
                  onSelectedItem: widget.onSelectedItem)),
        ],
      ),
    );
  }
}

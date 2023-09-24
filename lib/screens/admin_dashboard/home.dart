import 'package:bsims/const/textstyle.dart';
import 'package:bsims/screens/admin_dashboard/category.dart';
import 'package:bsims/screens/admin_dashboard/dashboard.dart';
import 'package:bsims/screens/admin_dashboard/sales.dart';
import 'package:bsims/screens/admin_dashboard/stock_inventory.dart';
import 'package:bsims/screens/admin_dashboard/store.dart';
import 'package:bsims/screens/admin_dashboard/supplier.dart';
import 'package:bsims/screens/admin_dashboard/users.dart';
import 'package:bsims/widgets/drawer_pane.dart';

import 'package:bsims/widgets/menu_container.dart';
import 'package:flutter/material.dart';

import '../../const/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double screenWidth = 0;
  Size size = Size(0, 0);
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
  
  Widget getScreen() {
    switch (currentItem) {
      case MenuItems.dashboard:
        return Dashboard(
          screenWidth: screenWidth,
          size: size,
        );
      case MenuItems.category:
        return ProductCategoryList(
          screenWidth: screenWidth,
        );
      case MenuItems.orders:
        return ProductCategoryList(
          screenWidth: screenWidth,
        );
      case MenuItems.products:
        return StockInventory(
          screenWidth: screenWidth,
        );
      case MenuItems.reports:
        return Sales(
          screenWidth: screenWidth,
          size: size,
        );
      case MenuItems.suppliers:
        return Supplier(screenWidth: screenWidth);
      case MenuItems.users:
        return Users(screenWidth: screenWidth);
      case MenuItems.stores:
        return Store(
          screenWidth: screenWidth,
        );

      default:
        return Dashboard(
          screenWidth: screenWidth,
          size: size,
        );
    }
  }

  MenuStuff currentItem = MenuItems.dashboard;

  @override
  Widget build(BuildContext context) {
     size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 221, 221),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
         screenWidth = constraints.maxWidth;

//double containerWidth =
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              MenuContainer(onSelectedItem: (item) {
                    setState(() => currentItem = item);
                    
                  },currentItem: currentItem,
                screenWidth: screenWidth,
                size: size,
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(screenWidth: screenWidth),
                  const SizedBox(
                    height: 30,
                  ),
                  getScreen()

                  // SellProduct (screenWidth: screenWidth, size:size)
                  // Dashboard(screenWidth: screenWidth, size: size, )
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: green),
          child: Text(
            'BESIMS (Business Enterprise Sales and Inventory Management System)',
            style: headline(white, screenWidth * 0.015),
          ),
        ),
        SizedBox(width: screenWidth * 0.005),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Admin Name',
                style: headline(black, 10),
              ),
              Text(
                'Admin@email.com',
                style: bodyText(green, 8),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        CircleAvatar(
          backgroundColor: green,
        )
      ],
    );
  }
}

import 'package:bsims/const/textstyle.dart';
import 'package:bsims/screens/admin_dashboard/category.dart';
import 'package:bsims/screens/admin_dashboard/dashboard.dart';
import 'package:bsims/screens/admin_dashboard/sales.dart';
import 'package:bsims/screens/admin_dashboard/stock_inventory.dart';
import 'package:bsims/screens/admin_dashboard/store.dart';
import 'package:bsims/screens/admin_dashboard/supplier.dart';
import 'package:bsims/screens/admin_dashboard/users.dart';
import 'package:bsims/screens/admin_dashboard/widgets/drawer_pane.dart';

import 'package:bsims/screens/admin_dashboard/widgets/menu_container.dart';
import 'package:bsims/widgets/textfield_widget.dart';
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
      backgroundColor: Colors.grey[200],
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        screenWidth = constraints.maxWidth;

//double containerWidth =
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              MenuContainer(
                onSelectedItem: (item) {
                  setState(() => currentItem = item);
                },
                currentItem: currentItem,
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
    this.searchController,
  });

  final double screenWidth;
  final searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: screenWidth - 293,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              height: 30,
              width: (screenWidth - 293)/3,
              child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(filled: false,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              color: grey)),
                      label: Text(
                        'Search product, supplier, order',
                        style: bodyText(Colors.grey[400]!, 17),
                      ),
                      prefixIcon: Icon(Icons.search)))),
          //SizedBox(width: screenWidth * 0.005),
      
          Row(
            children: [    Padding(
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
                  style: bodyText(purple!, 8),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
              CircleAvatar(
                backgroundColor: purple,
              ),
            ],
          )
        ],
      ),
    );
  }
}

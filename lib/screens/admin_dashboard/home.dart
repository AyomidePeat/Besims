import 'package:bsims/const/textstyle.dart';
import 'package:bsims/screens/admin_dashboard/category.dart';
import 'package:bsims/screens/admin_dashboard/dashboard.dart';
import 'package:bsims/screens/admin_dashboard/orders.dart';
import 'package:bsims/screens/admin_dashboard/point_of_sales.dart';
import 'package:bsims/screens/admin_dashboard/reports.dart';
import 'package:bsims/screens/admin_dashboard/stock_inventory.dart';
import 'package:bsims/screens/admin_dashboard/store.dart';
import 'package:bsims/screens/admin_dashboard/supplier.dart';
import 'package:bsims/screens/admin_dashboard/users.dart';
import 'package:bsims/widgets/drawer_pane.dart';
import 'package:bsims/widgets/menu_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../const/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double screenWidth = 0;
  Size size = const Size(0, 0);
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

  Widget getScreen() {
    switch (currentItem) {
      case MenuItems.dashboard:
        return Row(
          children: [
            SingleChildScrollView(
              child: Dashboard(
                screenWidth: screenWidth,
                size: size,
              ),
            ),
          ],
        );
      case MenuItems.category:
        return ProductCategoryList(
          screenWidth: screenWidth,
        );
      case MenuItems.orders:
        return Orders(
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
      case MenuItems.pointOfSales:
        return PointofSales(screenWidth: screenWidth);
      default:
        return Dashboard(
          screenWidth: screenWidth,
          size: size,
        );
    }
  }

  MenuStuff currentItem = MenuItems.dashboard;
  final searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    print(size.width);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        screenWidth = constraints.maxWidth;

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
                  Header(
                      screenWidth: screenWidth,
                      searchController: searchController),
                  const SizedBox(
                    height: 30,
                  ),
                  getScreen()
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
    required this.searchController,
  });

  final double screenWidth;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final size = MediaQuery.of(context).size;
    String currentDate = DateFormat('EEEE, MMMM dd, yyyy').format(now);
    return Container(
      padding: const EdgeInsets.all(10),
      width: size.width < 1000 ? screenWidth - 270 : screenWidth - 293,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              height: 40,
              width: (screenWidth - 293) / 3,
              child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                      filled: false,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: grey)),
                      label: Text(
                        'Search product, supplier, order',
                        style: bodyText(Colors.grey[400]!, 14),
                      ),
                      prefixIcon: const Icon(Icons.search)))),
          Row(
            children: [
              Text(currentDate),
              const SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Admin Name',
                      style: headline(black, 14),
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

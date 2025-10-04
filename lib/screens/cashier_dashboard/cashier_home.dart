import 'package:bsims/const/textstyle.dart';
import 'package:bsims/firebase_repos/cloud_firestore.dart';
import 'package:bsims/models/user_model.dart';
import 'package:bsims/screens/admin_dashboard/category.dart';
import 'package:bsims/screens/admin_dashboard/dashboard.dart';
import 'package:bsims/screens/admin_dashboard/point_of_sales.dart';
import 'package:bsims/screens/admin_dashboard/stock_inventory.dart';
import 'package:bsims/screens/cashier_dashboard/cashier_dashboard.dart';
import 'package:bsims/screens/cashier_dashboard/cashier_orders.dart';
import 'package:bsims/screens/cashier_dashboard/widgets/cashier_drawer_pane.dart';
import 'package:bsims/screens/cashier_dashboard/widgets/cashier_menu_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../const/colors.dart';

final userDetailsProvider = FutureProvider<UserModel?>((ref) async {
  final cloudStoreRef = ref.read(cloudStoreProvider);
  return cloudStoreRef.getUserDetails();
});

class CashierHome extends ConsumerStatefulWidget {
  const CashierHome({super.key});

  @override
  ConsumerState<CashierHome> createState() => _CashierHomeState();
}

class _CashierHomeState extends ConsumerState<CashierHome> {
  double screenWidth = 0;
  Size size = const Size(0, 0);
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
  String name = '';
  String email = '';
  String username = '';
  String image = '';

  Widget getScreen() {
    switch (currentItem) {
      case MenuItems.dashboard:
        return Row(
          children: [
            SingleChildScrollView(
              child: CashierDashboard(
                fullName: name,
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
        return CashierOrders(name: name,
          screenWidth: screenWidth,
        );
      case MenuItems.products:
        return StockInventory(
          screenWidth: screenWidth,
        );

      case MenuItems.pointOfSales:
        return PointofSales(screenWidth: screenWidth);
      default:
        return Dashboard(
       
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
    final userDetailsAsyncValue = ref.watch(userDetailsProvider);
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        screenWidth = constraints.maxWidth;

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CashierMenuContainer(
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
                  userDetailsAsyncValue.when(
                    data: (userDetails) {
                      if (userDetails != null) {
                        name = userDetails.name;
                        email = userDetails.email;
                        image = userDetails.image;

                        return Header(
                            image: image,
                            email: email,
                            name: name,
                            screenWidth: screenWidth,
                            searchController: searchController);
                      } else {
                        return Header(
                            image:
                                'https://img.freepik.com/premium-vector/anonymous-user-circle-icon-vector-illustration-flat-style-with-long-shadow_520826-1931.jpg',
                            email: 'cashier@gmail.com',
                            name: 'Cashier',
                            screenWidth: screenWidth,
                            searchController: searchController);
                      }
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stackTrace) => Text('Error: $error'),
                  ),
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
  const Header(
      {super.key,
      required this.screenWidth,
      required this.searchController,
      required this.name,
      required this.email,
      required this.image});
  final String name;
  final String email;
  final double screenWidth;
  final String image;
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
                      name,
                      style: headline(black, 14),
                    ),
                    Text(
                      email,
                      style: bodyText(purple!, 8),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(image),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:bsims/const/colors.dart';
import 'package:bsims/const/textstyle.dart';
import 'package:bsims/screens/admin_dashboard/dashboard.dart';
import 'package:flutter/material.dart';

class MenuStuff {
  final String title;
  final IconData icon;

  const MenuStuff(this.title, this.icon);
}

class MenuItems {
  static const dashboard = MenuStuff(
    'DashBoard',
    Icons.home,
  );
  static const stores = MenuStuff(
    'Stores',
    Icons.store,
  );
  static const users = MenuStuff(
    'Users',
    Icons.person,
  );
  static const suppliers = MenuStuff(
    'Suppliers',
    Icons.supervised_user_circle_sharp,
  );
  static const category = MenuStuff(
    'Category',
    Icons.category_outlined,
  );
  static const products = MenuStuff(
    'Products',
    Icons.shopify_rounded,
  );
  static const orders = MenuStuff(
    'Orders',
    Icons.delivery_dining,
  );
  static const reports = MenuStuff('Reports', Icons.bar_chart);
  static const sales = MenuStuff(
    'Sales',
    Icons.shopping_cart_checkout,
  );
  static final all = <MenuStuff>[
    dashboard,
    stores,
    users,
    suppliers,
    category,
    products,
    orders,
    reports,
  ];
}

class NavigationPane extends StatelessWidget {
  final MenuStuff currentItem;
  final ValueChanged<MenuStuff> onSelectedItem;
  const NavigationPane({
    required this.currentItem,
    required this.onSelectedItem,
  });
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Spacer(),

          ...MenuItems.all.map(buildMenuItem).toList(),

          Spacer(flex: 2),
        ],
      );
  Widget buildMenuItem(MenuStuff item) => ListTileTheme(
        selectedColor: black,
        selectedTileColor: green,
        child: ListTile(
          //selectedTileColor: Colors.black26,
          selected: currentItem == item,
          minLeadingWidth: 20, hoverColor: red,
          leading: Icon(item.icon, color: white),
          title: Text(
            item.title,
          ),
          onTap: () {
            onSelectedItem(item);
          },
        ),
      );
}
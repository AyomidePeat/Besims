import 'package:bsims/const/colors.dart';

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
  static const pointOfSales = MenuStuff(
    'Point of Sales',
    Icons.business,
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
    pointOfSales,
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
          ...MenuItems.all.map(buildMenuItem).toList(),
          const Spacer(flex: 2),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Row(
              children: [
                Icon(Icons.logout_rounded, color: Colors.grey),
                Text(
                  'Log Out',
                ),
              ],
            ),
          )
        ],
      );
  Widget buildMenuItem(MenuStuff item) => Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: ListTile(
          selectedColor: purple,
          contentPadding: const EdgeInsets.all(0),
          selected: currentItem == item,
          minLeadingWidth: 20,
          hoverColor: Colors.red[600],
          leading: Icon(
            item.icon,
          ),
          title: Text(
            item.title,
          ),
          onTap: () {
            onSelectedItem(item);
          },
        ),
      );
}

import 'package:bsims/screens/admin_dashboard/dashboard.dart';
import 'package:flutter/material.dart';

class MenuStuff {
  final String title;

  const MenuStuff( this.title,);
}


class MenuItems {
  static const Dashboard = MenuStuff('DashBoard' );
  static const Stores = MenuStuff('Stores', );
  static const Users = MenuStuff( 'Users',);
  static const Suppliers = MenuStuff('Suppliers');
  static const Category = MenuStuff('Category');
  static const Products = MenuStuff('Products' );
  static const Orders = MenuStuff('Orders');
  static const Reports = MenuStuff('Reports');
 
  static const all = <MenuStuff>[
    Dashboard,
    Stores,
   Users,
    Suppliers,
    Category,
    Products,
    Orders,
    Reports,
    
  ];
}

class NavigationPane extends StatelessWidget {
  final MenuStuff currentItem;
  final ValueChanged<MenuStuff> onSelectedItem;
  const NavigationPane({
   
    required this.currentItem,
     required this.onSelectedItem,
  }) ;
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
        selectedColor: Colors.white,
        child: ListTile(
          selectedTileColor: Colors.black26,
          selected: currentItem == item,
          minLeadingWidth: 20,
        
          title: Text(item.title),
          onTap: () {
            onSelectedItem(item);
          },
        ),
      );
}

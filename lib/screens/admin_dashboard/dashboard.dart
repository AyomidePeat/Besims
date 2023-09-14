import 'package:bsims/const/textstyle.dart';
import 'package:bsims/widgets/standard_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../const/colors.dart';
import '../../widgets/custom_container.dart';

class Dashboard extends StatelessWidget {
  Dashboard({
    super.key,
    required this.screenWidth,
    required this.size,
  });

  final double screenWidth;
  final Size size;
  List labels = [
    'Today\'s Sales',
    'Expired',
    'Today\'s Invoice',
    'New Products'
  ];
  List standardLabel = [
    'Suppliers',
    'Invoices',
    'Current Month Sales',
    'Last 3 Months Record',
    'Last 6 Months Record Sales',
    'Users',
    'Available Products',
    'Current Year Revenue',
    'Scores'
  ];

  List icons = [
    Icons.attach_money_outlined,
    Icons.credit_card,
    Icons.inventory_outlined,
    Icons.shopping_bag_rounded
  ];
  List iconColors = [green, red, yellow, Colors.blue];
  List standardIcons = [
    Icons.person, Icons.shopping_cart, Icons.sell, Icons.calculate, Icons.receipt_rounded, Icons.supervised_user_circle_sharp, Icons.shopping_bag_rounded, Icons.star, Icons.auto_graph_outlined
  ];
  List bgColors = [
    Colors.green[300],
    Colors.pink[300],
    Colors.yellow[300],
    Colors.blue[300]
  ];
  List standardIconColors=[Colors.pink, Colors.indigo, Colors.teal, Colors.indigoAccent, Colors.blue, Color.fromARGB(255, 34, 155, 60), Colors.pink, Colors.yellow, Colors.indigo];
String currentDate = DateFormat(' EEEE,  MMMM dd, yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: 100, maxWidth: size.width - 293),
          child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                mainAxisExtent: 90,
              ),
              itemCount: labels.length,
              itemBuilder: (BuildContext context, int index) {
                return CustomContainer(
                    icon: icons[index],
                    bgColor: bgColors[index],
                    iconColor: iconColors[index],
                    label: labels[index],
                    quantity: 0);
              }),
        ),
        ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: 250, maxWidth: size.width - 293),
          child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 15,
                mainAxisExtent: 70,
              ),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return StandardContainer(
                    icon: standardIcons[index],
                    iconColor: standardIconColors[index],
                    label: standardLabel[index],
                    quantity: 0);
              }),
        ),
      SizedBox(height:20),
        Text('Today\'s ($currentDate) Transactions', style: headline(green, screenWidth*0.015),),
      ],
    );
  }
}

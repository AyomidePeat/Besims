import 'package:bsims/const/textstyle.dart';
import 'package:bsims/screens/admin_dashboard/dashboard.dart';
import 'package:bsims/screens/sales.dart';
import 'package:bsims/screens/stock_inventory.dart';
import 'package:bsims/screens/store.dart';
import 'package:bsims/screens/supplier.dart';
import 'package:bsims/screens/users.dart';
import 'package:bsims/widgets/custom_container.dart';
import 'package:bsims/widgets/menu_container.dart';
import 'package:flutter/material.dart';

import '../../const/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(backgroundColor: Color.fromARGB(255, 230, 221, 221),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
       double screenWidth = constraints.maxWidth;
        double screenHeight = constraints.maxHeight;
//double containerWidth = 
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              MenuContainer(),
              
              SizedBox(width: 20),
               Column(crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Header(screenWidth: screenWidth),
                     const SizedBox(
          height: 30,
        ),
        Supplier(screenWidth: screenWidth)
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
              padding: EdgeInsets.all(10),
            
              decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(10),
       color: green),
              child: Text(
     'BESIMS (Business Enterprise Sales and Inventory Management System)',
     style: headline(white, screenWidth*0.015),
              ),
            ),  SizedBox(width:screenWidth*0.005 ),
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
            SizedBox(
              width: 10,
            ),
            CircleAvatar(
              backgroundColor: green,
            )
          ],
        );
  }
}

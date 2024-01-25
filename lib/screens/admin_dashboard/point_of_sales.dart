import 'package:bsims/const/colors.dart';
import 'package:bsims/const/textstyle.dart';
import 'package:bsims/firebase_repos/cloud_firestore.dart';
import 'package:bsims/models/stock_inventory_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PointofSales extends ConsumerStatefulWidget {
  final double screenWidth;
  const PointofSales({super.key, required this.screenWidth});

  @override
  ConsumerState<PointofSales> createState() => _PointofSalesState();
}

class _PointofSalesState extends ConsumerState<PointofSales> {
  @override
  Widget build(BuildContext context) {
    final cloudStoreRef = ref.watch(cloudStoreProvider);
    return StreamBuilder(
      stream: cloudStoreRef.getStocks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(child: CircularProgressIndicator(color: purple))
          ]);
        } else {
          final List<StockInventoryModel> stocks = snapshot.data!;
          final totalProducts = stocks.length;
          return SizedBox(
            width: widget.screenWidth - 280,
            height: 446,
            child: ListView.builder(
                itemCount: stocks.length,
                itemBuilder: (context, index) {
                  String productName = stocks[index].name;
                  String category = stocks[index].category;
                  //String costPrice = stocks[index].costPrice;
                  String sellingPrice = stocks[index].sellingPrice;
                  String quantity = stocks[index].quantity;

                  String expiryDate = stocks[index].expiryDate;
                  String status = stocks[index].status;

                  return ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: ProductList(
                      screenWidth: widget.screenWidth,
                      sn: index + 1,
                      category: category,
                      expiryDate: expiryDate,
                      price: sellingPrice,
                      productName: productName,
                      status: status,
                      quantity: quantity,
                    ),
                  );
                }),
          );
        }
      },
    );
  }
}

class ProductList extends StatefulWidget {
  final String productName;
  final String category;
  final String expiryDate;
  final String price;
  final String status;
  final double screenWidth;
  final String quantity;
  final int sn;
  const ProductList(
      {super.key,
      required this.category,
      required this.price,
      required this.expiryDate,
      required this.productName,
      required this.screenWidth,
      required this.sn,
      required this.quantity,
      required this.status});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final firestore = FirestoreClass();
  int counter = 1;
  void incrementer() {
    setState(() {
      counter++;
    });
  }

  void decrementer() {
    setState(() {
      if (counter > 0) {
        counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final widgetSize = (widget.screenWidth - 293) / 12;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            widget.sn.toString(),
            style: bodyText(black, 14),
          ),
          Text(
            widget.productName,
            style: bodyText(black, 14),
          ),
          Text(
            widget.category,
            style: bodyText(black, 14),
          ),
          Text(
            widget.expiryDate,
            style: bodyText(black, 14),
          ),
          Text(
            widget.price,
            style: bodyText(black, 14),
          ),
          Text(
            widget.status,
            style: bodyText(
                widget.status == 'Unavailable' ||
                        widget.status == 'unavailable'
                    ? red
                    : green,
                13),
          ),
          Row(
            children: [
              InkWell(
                  onTap: incrementer,
                  child: Container(
                      color: purple,
                      child: Icon(Icons.add, size: 15, color: white))),
              const SizedBox(
                width: 8,
              ),
              Text(
                ' $counter',
                style: bodyText(black, 13),
              ),
              InkWell(
                  onTap: decrementer,
                  child: Container(
                      color: purple,
                      child: Icon(Icons.remove, size: 15, color: white))),
            ],
          ),
        ]),
       
      ],
    );
  }
}

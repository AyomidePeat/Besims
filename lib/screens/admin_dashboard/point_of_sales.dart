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
  final firestore = FirestoreClass();
  List<StockInventoryModel> selectedItems = [];
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cloudStoreRef = ref.watch(cloudStoreProvider);
    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: (widget.screenWidth - 293) / 2,
            child: Column(
              children: [
              //    Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: TextField(
              //     controller: searchController,
              //     onChanged: (query) {
              //       // Call a function to filter items based on the search query
              //       filterItems(query);
              //     },
              //     decoration: InputDecoration(
              //       labelText: 'Search',
              //       hintText: 'Type to search...',
              //       prefixIcon: Icon(Icons.search),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10.0),
              //       ),
              //     ),
              //   ),
              // ),
                StreamBuilder(
                  stream: cloudStoreRef.getStocks(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: CircularProgressIndicator(color: purple))
                          ]);
                    } else {
                      final List<StockInventoryModel> stocks = snapshot.data!;
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
                                title: Container(
                                  child: ProductList(
                                    screenWidth: widget.screenWidth,
                                    sn: index + 1,
                                    category: category,
                                    expiryDate: expiryDate,
                                    price: sellingPrice,
                                    productName: productName,
                                    status: status,
                                    quantity: quantity,
                                    onTap: () {
                                      setState(() {
                                        selectedItems.add(stocks[index]);
                                      });
                                    },
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            width: (widget.screenWidth - 293) / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected Items:',
                  style: bodyText(black, 16),
                ),
                SizedBox(
                  height: 600,
                  child: ListView.builder(
                    itemCount: selectedItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(selectedItems[index].name),
                        subtitle: Text(selectedItems[index].sellingPrice),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Total Price: \$${calculateTotal()}',
                  style: bodyText(black, 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
 void filterItems(String query) {
    // Implement the logic to filter items based on the search query
    // Use the new filterStocksByName method in FirestoreClass
    firestore.filterStocksByName(query);
  }
  double calculateTotal() {
    return selectedItems.fold(
        0, (total, product) => total + num.parse(product.sellingPrice));
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
  final VoidCallback onTap;
  const ProductList(
      {super.key,
      required this.category,
      required this.price,
      required this.expiryDate,
      required this.productName,
      required this.screenWidth,
      required this.sn,
      required this.quantity,
      required this.onTap,
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
      if (counter >= 1) {
        counter--;
      }
    });
  }
  // List<StockInventoryModel> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              Text(
                '${widget.sn}. ',
                style: bodyText(black, 14),
              ),
              Text(
                widget.productName,
                style: bodyText(black, 14),
              ),
            ],
          ),
          Text(
            widget.price,
            style: bodyText(black, 14),
          ),
          InkWell(
            onTap: widget.onTap,
            child: Container(
              padding: EdgeInsets.all(10),
              color: purple,
              child: Icon(Icons.add, size: 15, color: white),
            ),
          )
          // Row(
          //   children: [
          //     InkWell(
          //         onTap: decrementer,
          //         child: Container(
          //             padding: EdgeInsets.all(10),
          //             color: purple,
          //             child: Icon(Icons.remove, size: 15, color: white))),
          //     const SizedBox(
          //       width: 8,
          //     ),
          //     Text(
          //       ' $counter',
          //       style: bodyText(black, 16),
          //     ),
          //     const SizedBox(
          //       width: 8,
          //     ),
          //     InkWell(
          //         onTap: incrementer,
          //         child: Container(
          //             padding: EdgeInsets.all(10),
          //             color: purple,
          //             child: Icon(Icons.add, size: 15, color: white))),
          //   ],
          // ),
        ]),
      ],
    );
  }
}

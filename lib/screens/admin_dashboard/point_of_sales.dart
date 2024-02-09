import 'package:bsims/const/colors.dart';
import 'package:bsims/const/textstyle.dart';
import 'package:bsims/firebase_repos/cloud_firestore.dart';
import 'package:bsims/models/stock_inventory_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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

  List paymentOption = ['Cash', 'Transfer', 'POS', 'Cheque'];
  String? payment;
  @override
  Widget build(BuildContext context) {
    final cloudStoreRef = ref.watch(cloudStoreProvider);
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: (widget.screenWidth - 293) / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: purple,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Product',
                            style: bodyText(white, 14),
                          ),
                          Text(
                            'Price',
                            style: bodyText(white, 14),
                          ),
                          Text(
                            'Quantity',
                            style: bodyText(white, 14),
                          ),
                          Text(
                            'Sub-Total',
                            style: bodyText(white, 14),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 600,
                    child: ListView.builder(
                      itemCount: selectedItems.length,
                      itemBuilder: (context, index) {
                        int price =
                            int.parse(selectedItems[index].sellingPrice);
                        final formattedPrice =
                            NumberFormat('#,###').format(price);
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(selectedItems[index].name),
                              Text(formattedPrice),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: black)),
                                width: 60,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '$counter',
                                        style: bodyText(black, 15),
                                      ),
                                      Column(
                                        children: [
                                          InkWell(
                                              onTap: incrementer,
                                              child: const Icon(
                                                  Icons.arrow_drop_up,
                                                  size: 25)),
                                          InkWell(
                                              onTap: decrementer,
                                              child: const Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 25)),
                                        ],
                                      ),
                                    ]),
                              ),
                              Text('${getTotal(price)}'),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal:10, vertical: 5),
                    decoration: BoxDecoration(
                      color: purple,
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Items: ${selectedItems.length}',
                              style: bodyText(white, 16),
                            ),
                            Text(
                              'Total Price:  ₦${formatTotal(calculateTotal())}',
                              style: bodyText(white, 16),
                            ),
                          ],
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                 height:37,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                              child: DropdownButtonFormField(dropdownColor:purple ,
                                hint:  Text('Cash', style:bodyText(white, 16)),
                                value: payment,
                                onChanged: (value) {
                                  setState(() {
                                    payment = value as String;
                                  });
                                },
                                items: paymentOption
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e.toString(),style:bodyText(white, 16) ),
                                        ))
                                    .toList(),
                                decoration:  InputDecoration(fillColor: purple,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Text('Print Receipt',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: white,
                                    fontSize: 16))
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: ((widget.screenWidth - 293) / 2) - 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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

                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                    stream: cloudStoreRef.getStocks(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child:
                                      CircularProgressIndicator(color: purple))
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
                                String sellingPrice =
                                    stocks[index].sellingPrice;
                                String quantity = stocks[index].quantity;

                                String expiryDate = stocks[index].expiryDate;
                                String status = stocks[index].status;

                                return Container(
                                  color: grey,
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    title: Padding(
                                      padding: const EdgeInsets.all(8.0),
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
          ],
        ),
      ),
    );
  }

  void filterItems(String query) {
    firestore.filterStocksByName(query);
  }

  double calculateTotal() {
    return selectedItems.fold(
        0, (total, product) => total + num.parse(product.sellingPrice));
  }

  String formatTotal(double total) {
    final formattedPrice = NumberFormat('#,###').format(total);
    return formattedPrice;
  }

  int counter = 1;

  void incrementer() {
    setState(() {
      counter++;
    });
  }

  void decrementer() {
    setState(() {
      if (counter > 1) {
        counter--;
      }
    });
  }

  double getTotal(total) {
    return total * counter;
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

  @override
  Widget build(BuildContext context) {
    return Column(
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
              padding: const EdgeInsets.all(10),
              color: purple,
              child: Icon(Icons.add, size: 15, color: white),
            ),
          ),
          const Divider()
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

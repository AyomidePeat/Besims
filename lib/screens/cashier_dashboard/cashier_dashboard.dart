import 'package:bsims/const/textstyle.dart';
import 'package:bsims/firebase_repos/cloud_firestore.dart';
import 'package:bsims/models/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../const/colors.dart';


class CashierDashboard extends ConsumerWidget {
  CashierDashboard(
      {super.key,
      required this.screenWidth,
      required this.size,
      required this.fullName});

  final double screenWidth;
  final Size size;

  final String currentDate = DateFormat('dd MMMM, yyyy').format(DateTime.now());
  final String shortCurrentDate = DateFormat('dd-MM-yy').format(DateTime.now());
  final now = DateTime.now();
  Stream<DateTime> currentTimeStream() {
    return Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
  }

  List<ProductModel> getBestPerformers(List<ProductModel> allProducts) {
    // Count occurrences of each product
    Map<String, int> productOccurrences = {};

    for (var product in allProducts) {
      productOccurrences[product.productName] =
          (productOccurrences[product.productName] ?? 0) + 1;
    }

    // Sort products by occurrences in descending order
    allProducts.sort((a, b) => productOccurrences[b.productName]!
        .compareTo(productOccurrences[a.productName]!));

    return allProducts.take(3).toList();
  }

  
  final String fullName;
  
  @override
  Widget build(BuildContext context, ref) {
    final size = MediaQuery.of(context).size;
   

    if (kIsWeb) {
      final cloudstoreRef = ref.watch(cloudStoreProvider);
      return SizedBox(
        width: size.width < 1000 ? screenWidth - 270 : size.width - 293,
        child: StreamBuilder(
            stream: cloudstoreRef.getCashierProducts(seller: fullName),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [CircularProgressIndicator(color: purple)]);
              } else {
                final stocks = snapshot.data!;
                int totalSales = 0;
                int costPrice = 0;
                int profits = 0;
                String dateAdded = '';
                for (int index = 0; index < stocks.length; index++) {
                  totalSales += int.parse(stocks[index].unitPrice);
                  costPrice += int.parse(stocks[index].costPrice);
                  dateAdded = stocks[index].dateAdded.toString();
                }
                String currentDates = DateFormat('EEEE').format(now);
                profits = totalSales - costPrice;

                int returnedCount = 0;
                int returnedprice = 0;

                for (int index = 0; index < stocks.length; index++) {
                  if (stocks[index].status == "Returned") {
                    returnedCount++;
                    returnedprice += int.parse(stocks[index].unitPrice);
                  }
                }
                String formattedTotalSales =
                    NumberFormat('#,###').format(totalSales);
                String formattedProfits = NumberFormat('#,###').format(profits);
                String formattedReturnedPrice =
                    NumberFormat('#,###').format(returnedprice);
                List<ProductModel> bestPerformers = getBestPerformers(stocks);

                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              height: 135,
                              width: size.width < 1000 ? 350 : 700,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: white,
                                border:
                                    Border.all(width: 0.5, color: Colors.grey),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Estimate',
                                    style: bodyText(
                                        black, size.width < 1000 ? 13 : 16),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      EstimateTexts(
                                        amount: formattedTotalSales,
                                        color: blue,
                                        text: 'Sales',
                                      ),
                                      verticalLine(),
                                      EstimateTexts(
                                        amount: formattedProfits,
                                        color: green,
                                        text: 'Profits',
                                      ),
                                      verticalLine(),
                                      EstimateTexts(
                                        amount: formattedReturnedPrice,
                                        color: red,
                                        text: 'Returned',
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 18.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            StreamBuilder<DateTime>(
                                              stream: currentTimeStream(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  DateTime currentTime =
                                                      snapshot.data!;
                                                  String formattedTime =
                                                      DateFormat.Hm()
                                                          .format(currentTime);

                                                  return Text(
                                                    formattedTime,
                                                    style: headline(
                                                        black,
                                                        size.width < 1000
                                                            ? 11
                                                            : 14),
                                                  );
                                                } else {
                                                  return const SizedBox(); // Display a loading indicator while waiting for the first data.
                                                }
                                              },
                                            ),
                                            Text(
                                              size.width < 1000
                                                  ? shortCurrentDate
                                                  : currentDate,
                                              style: bodyText(Colors.grey,
                                                  size.width > 600 ? 11 : 14),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: size.width < 1000 ? 10 : 30),
                            StreamBuilder(
                                stream: cloudstoreRef.getStocks(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator(
                                        color: purple);
                                  } else {
                                    final stocks = snapshot.data!;
                                    final totalStocks = stocks.length;

                                    return Container(
                                        padding: const EdgeInsets.all(20),
                                        height: 135,
                                        width: size.width < 1000 ? 140 : 400,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: white,
                                          border: Border.all(
                                              width: 0.5, color: Colors.grey),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Total Products',
                                              style: bodyText(black,
                                                  size.width < 1000 ? 13 : 16),
                                            ),
                                            const SizedBox(height: 25),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(totalStocks.toString(),
                                                    style: headline(
                                                        black,
                                                        size.width < 1000
                                                            ? 15
                                                            : 23)),
                                                Container(
                                                  height: size.width < 1000
                                                      ? 20
                                                      : 35,
                                                  width: 35,
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors.green[50]),
                                                  child: Text(
                                                    '+13%',
                                                    style: headline(
                                                        green,
                                                        size.width < 1000
                                                            ? 10
                                                            : 14),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ));
                                  }
                                }),
                            SizedBox(width: size.width < 1000 ? 10 : 30),
                            StreamBuilder(
                                stream: cloudstoreRef.getStores(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator(
                                        color: purple);
                                  } else {
                                    final stores = snapshot.data!;
                                    final totalStores = stores.length;
                                    return Container(
                                        padding: const EdgeInsets.all(20),
                                        height: 135,
                                        width: size.width < 1000 ? 178 : 400,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: white,
                                          border: Border.all(
                                              width: 0.5, color: Colors.grey),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  size.width < 1000
                                                      ? 'Stores'
                                                      : "Total Stores",
                                                  style: bodyText(
                                                      black,
                                                      size.width < 1000
                                                          ? 13
                                                          : 16),
                                                ),
                                                const SizedBox(height: 25),
                                                Row(
                                                  children: [
                                                    Text(totalStores.toString(),
                                                        style: headline(
                                                            black,
                                                            size.width < 1000
                                                                ? 15
                                                                : 23)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  size.width < 1000
                                                      ? 'Staff'
                                                      : "Total Staff",
                                                  style: bodyText(
                                                      black,
                                                      size.width < 1000
                                                          ? 13
                                                          : 16),
                                                ),
                                                const SizedBox(height: 25),
                                                Text('4',
                                                    style: headline(
                                                        black,
                                                        size.width < 1000
                                                            ? 15
                                                            : 23)),
                                              ],
                                            )
                                          ],
                                        ));
                                  }
                                }),
                          ]),
                      const SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: _buildPerformanceList(
                                  context, 'Best Performers', bestPerformers),
                            ),
                            SizedBox(width: 20),
                            Container(
                              child: _buildPerformanceList(
                                  context, 'Worst Performers', bestPerformers),
                            ),
                            SizedBox(width: 20),
                            Container(
                              child: _buildPerformanceList(
                                  context, 'Top Suppliers', bestPerformers),
                            ),
                          ],
                        ),
                      )
                    ]);
              }
            }),
      );
    } else {
      return SizedBox(
          width: size.width < 1000 ? screenWidth - 270 : size.width - 293,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                padding: const EdgeInsets.all(20),
                height: 135,
                width: size.width < 1000 ? 350 : 700,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: white,
                  border: Border.all(width: 0.5, color: Colors.grey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Estimate',
                      style: bodyText(black, size.width < 1000 ? 13 : 16),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        EstimateTexts(
                          amount: '10000',
                          color: blue,
                          text: 'Sales',
                        ),
                        verticalLine(),
                        EstimateTexts(
                          amount: '5000',
                          color: green,
                          text: 'Profits',
                        ),
                        verticalLine(),
                        EstimateTexts(
                          amount: '1000',
                          color: red,
                          text: 'Returned',
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StreamBuilder<DateTime>(
                                stream: currentTimeStream(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    DateTime currentTime = snapshot.data!;
                                    String formattedTime =
                                        DateFormat.Hm().format(currentTime);

                                    return Text(
                                      formattedTime,
                                      style: headline(
                                          black, size.width < 1000 ? 11 : 14),
                                    );
                                  } else {
                                    return const SizedBox(); // Display a loading indicator while waiting for the first data.
                                  }
                                },
                              ),
                              Text(
                                size.width < 1000
                                    ? shortCurrentDate
                                    : currentDate,
                                style: bodyText(
                                    Colors.grey, size.width > 600 ? 11 : 14),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: size.width < 1000 ? 10 : 30),
              Container(
                  padding: const EdgeInsets.all(20),
                  height: 135,
                  width: size.width < 1000 ? 140 : 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: white,
                    border: Border.all(width: 0.5, color: Colors.grey),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Products',
                        style: bodyText(black, size.width < 1000 ? 13 : 16),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('15',
                              //totalStocks.toString(),
                              style:
                                  headline(black, size.width < 1000 ? 15 : 23)),
                          Container(
                            height: size.width < 1000 ? 20 : 35,
                            width: 35,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.green[50]),
                            child: Text(
                              '+13%',
                              style:
                                  headline(green, size.width < 1000 ? 10 : 14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
              SizedBox(width: size.width < 1000 ? 10 : 30),
              Container(
                  padding: const EdgeInsets.all(20),
                  height: 135,
                  width: size.width < 1000 ? 178 : 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: white,
                    border: Border.all(width: 0.5, color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            size.width < 1000 ? 'Stores' : "Total Stores",
                            style: bodyText(black, size.width < 1000 ? 13 : 16),
                          ),
                          const SizedBox(height: 25),
                          Row(
                            children: [
                              Text('20',
                                  //totalStores.toString(),
                                  style: headline(
                                      black, size.width < 1000 ? 15 : 23)),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            size.width < 1000 ? 'Staff' : "Total Staff",
                            style: bodyText(black, size.width < 1000 ? 13 : 16),
                          ),
                          const SizedBox(height: 25),
                          Text('4',
                              style:
                                  headline(black, size.width < 1000 ? 15 : 23)),
                        ],
                      )
                    ],
                  ))
            ]),
            const SizedBox(height: 20),
            // SingleChildScrollView(scrollDirection: Axis.horizontal,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Container(
            //         child: _buildPerformanceList(
            //          context,   'Best Performers', bestPerformers),
            //       ),
            //       SizedBox(width: 20),
            //       Container(
            //         child: _buildPerformanceList(
            //            context, 'Worst Performers', bestPerformers),
            //       ),
            //       SizedBox(width: 20),
            //       Container(
            //         child: _buildPerformanceList(
            //        context,     'Top Suppliers', bestPerformers),
            //       ),
            //     ],
            //   ),
            // )
          ]));
    }
  }

  Widget verticalLine() {
    return Container(height: 40, width: 2, color: grey);
  }

  Widget _buildPerformanceList(
      BuildContext context, String title, List<ProductModel> products) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width < 1000 ? 250 : 510,
      padding: EdgeInsets.all(20),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: bodyText(black, size.width < 1000 ? 15 : 18),
          ),
          SizedBox(height: 10),
          for (var product in products)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.productName),
                    Text(product.unitPrice)
                  ]),
            ),
        ],
      ),
    );
  }
}

class EstimateTexts extends StatelessWidget {
  const EstimateTexts({
    super.key,
    required this.amount,
    required this.text,
    required this.color,
  });
  final String amount;
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('₦ ${amount}',
            style: headline(black, size.width < 1000 ? 15 : 23)),
        Text(
          '• $text',
          style: headline(color, size.width < 1000 ? 12 : 16),
        ),
      ],
    );
  }
}

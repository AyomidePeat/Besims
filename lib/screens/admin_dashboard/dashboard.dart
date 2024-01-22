import 'package:bsims/const/textstyle.dart';
import 'package:bsims/firebase_repos/cloud_firestore.dart';
import 'package:bsims/models/product_model.dart';
import 'package:bsims/models/product_sale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../const/colors.dart';

class Dashboard extends ConsumerWidget {
  Dashboard({
    super.key,
    required this.screenWidth,
    required this.size,
  });

  final double screenWidth;
  final Size size;

  final String currentDate = DateFormat('dd MMMM, yyyy').format(DateTime.now());
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

  @override
  Widget build(BuildContext context, ref) {
    final cloudstoreRef = ref.watch(cloudStoreProvider);
    return StreamBuilder(
        stream: cloudstoreRef.getProducts(),
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
                          width: 700,
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
                                style: bodyText(black, 16),
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
                                    padding: const EdgeInsets.only(top: 18.0),
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
                                                style: headline(black, 14),
                                              );
                                            } else {
                                              return const SizedBox(); // Display a loading indicator while waiting for the first data.
                                            }
                                          },
                                        ),
                                        Text(
                                          currentDate,
                                          style: bodyText(Colors.grey, 14),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 30),
                        StreamBuilder(
                            stream: cloudstoreRef.getStocks(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator(color: purple);
                              } else {
                                final stocks = snapshot.data!;
                                final totalStocks = stocks.length;

                                return Container(
                                    padding: const EdgeInsets.all(20),
                                    height: 135,
                                    width: 400,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
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
                                          style: bodyText(black, 16),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(totalStocks.toString(),
                                                style: headline(black, 23)),
                                            Container(
                                              height: 20,
                                              width: 35,
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.green[50]),
                                              child: Text(
                                                '+13%',
                                                style: headline(green, 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ));
                              }
                            }),
                        SizedBox(width: 30),
                        StreamBuilder(
                            stream: cloudstoreRef.getStores(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator(color: purple);
                              } else {
                                final stores = snapshot.data!;
                                final totalStores = stores.length;
                                return Container(
                                    padding: const EdgeInsets.all(20),
                                    height: 135,
                                    width: 400,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
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
                                              'Total Stores',
                                              style: bodyText(black, 16),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Text(totalStores.toString(),
                                                    style: headline(black, 23)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Total Staff',
                                              style: bodyText(black, 16),
                                            ),
                                            const SizedBox(height: 10),
                                            Text('100',
                                                style: headline(black, 23)),
                                          ],
                                        )
                                      ],
                                    ));
                              }
                            }),
                      ]),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: _buildPerformanceList(
                            'Best Performers', bestPerformers),
                      ),
                      SizedBox(width: 20),
                      Container(
                        child: _buildPerformanceList(
                            'Worst Performers', bestPerformers),
                      ),
                      SizedBox(width: 20),
                      Container(
                        child: _buildPerformanceList(
                            'Top Suppliers', bestPerformers),
                      ),
                    ],
                  )
                ]);
          }
        });
  }

  Widget verticalLine() {
    return Container(height: 40, width: 2, color: grey);
  }

  Widget _buildPerformanceList(String title, List<ProductModel> products) {
    return Container(
      width: 510,
      padding: EdgeInsets.all(20),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: bodyText(black, 18),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('₦ ${amount}', style: headline(black, 23)),
        Text(
          '• $text',
          style: headline(color, 16),
        ),
      ],
    );
  }
}

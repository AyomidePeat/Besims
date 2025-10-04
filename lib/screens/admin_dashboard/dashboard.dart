import 'package:bsims/const/textstyle.dart';
import 'package:bsims/firebase_repos/cloud_firestore.dart';
import 'package:bsims/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../const/colors.dart';

class Dashboard extends ConsumerWidget {
  Dashboard({super.key});

  final String currentDate = DateFormat('dd MMMM, yyyy').format(DateTime.now());
  final String shortCurrentDate = DateFormat('dd-MM-yy').format(DateTime.now());
  final now = DateTime.now();

  Stream<DateTime> currentTimeStream() {
    return Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
  }

  List<ProductModel> getBestPerformers(List<ProductModel> allProducts) {
    Map<String, int> productOccurrences = {};
    for (var product in allProducts) {
      productOccurrences[product.productName] =
          (productOccurrences[product.productName] ?? 0) + 1;
    }
    allProducts.sort((a, b) => productOccurrences[b.productName]!
        .compareTo(productOccurrences[a.productName]!));
    return allProducts.take(3).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    final isTablet = size.width >= 600 && size.width < 1000;
    final isDesktop = size.width >= 1000;

    // Calculate responsive font sizes
    double headlineFontSize = isMobile ? 14 : isTablet ? 16 : 18;
    double bodyFontSize = isMobile ? 12 : isTablet ? 14 : 16;
    double largeFontSize = isMobile ? 18 : isTablet ? 20 : 24;

    // Calculate container widths
    double totalEstimateWidth = isMobile ? size.width * 0.9 : size.width * 0.45;
    double productsWidth = isMobile ? size.width * 0.4 : size.width * 0.25;
    double storesWidth = isMobile ? size.width * 0.45 : size.width * 0.25;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 8.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Total Estimate, Total Products, Total Stores
            isMobile
                ? Column(
                    children: [
                      _buildTotalEstimate(
                          context, totalEstimateWidth, headlineFontSize, bodyFontSize, largeFontSize),
                      SizedBox(height: isMobile ? 10 : 20),
                      _buildTotalProducts(context, productsWidth, headlineFontSize, bodyFontSize, largeFontSize, ref),
                      SizedBox(height: isMobile ? 10 : 20),
                      _buildTotalStores(context, storesWidth, headlineFontSize, bodyFontSize, largeFontSize, ref),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildTotalEstimate(
                            context, totalEstimateWidth, headlineFontSize, bodyFontSize, largeFontSize),
                      ),
                      SizedBox(width: isTablet ? 10 : 20),
                      Expanded(
                        child: _buildTotalProducts(context, productsWidth, headlineFontSize, bodyFontSize, largeFontSize, ref),
                      ),
                      SizedBox(width: isTablet ? 10 : 20),
                      Expanded(
                        child: _buildTotalStores(context, storesWidth, headlineFontSize, bodyFontSize, largeFontSize, ref),
                      ),
                    ],
                  ),
            SizedBox(height: isMobile ? 10 : 20),
            // Performance Lists
            StreamBuilder(
              stream: ref.watch(cloudStoreProvider).getProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: purple));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final stocks = snapshot.data!;
                  final bestPerformers = getBestPerformers(stocks);
                  return isMobile
                      ? Column(
                          children: [
                            _buildPerformanceList(context, 'Best Performers', bestPerformers, size.width * 0.9, headlineFontSize),
                            SizedBox(height: isMobile ? 10 : 20),
                            _buildPerformanceList(context, 'Worst Performers', bestPerformers, size.width * 0.9, headlineFontSize),
                            SizedBox(height: isMobile ? 10 : 20),
                            _buildPerformanceList(context, 'Top Suppliers', bestPerformers, size.width * 0.9, headlineFontSize),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _buildPerformanceList(context, 'Best Performers', bestPerformers, size.width * 0.3, headlineFontSize),
                            ),
                            SizedBox(width: isTablet ? 10 : 20),
                            Expanded(
                              child: _buildPerformanceList(context, 'Worst Performers', bestPerformers, size.width * 0.3, headlineFontSize),
                            ),
                            SizedBox(width: isTablet ? 10 : 20),
                            Expanded(
                              child: _buildPerformanceList(context, 'Top Suppliers', bestPerformers, size.width * 0.3, headlineFontSize),
                            ),
                          ],
                        );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalEstimate(BuildContext context, double width, double headlineFontSize, double bodyFontSize, double largeFontSize) {
    final size = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, ref, child) {
        return StreamBuilder(
          stream: ref.watch(cloudStoreProvider).getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: purple));
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final stocks = snapshot.data!;
              int totalSales = 0;
              int costPrice = 0;
              int returnedPrice = 0;
              for (var stock in stocks) {
                totalSales += int.parse(stock.unitPrice);
                costPrice += int.parse(stock.costPrice);
                if (stock.status == "Returned") {
                  returnedPrice += int.parse(stock.unitPrice);
                }
              }
              int profits = totalSales - costPrice;
              String formattedTotalSales = NumberFormat('#,###').format(totalSales);
              String formattedProfits = NumberFormat('#,###').format(profits);
              String formattedReturnedPrice = NumberFormat('#,###').format(returnedPrice);

              return Container(
                padding: EdgeInsets.all(size.width < 600 ? 10 : 20),
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: white,
                  border: Border.all(width: 0.5, color: Colors.grey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Estimate', style: bodyText(black, bodyFontSize)),
                    SizedBox(height: size.width < 600 ? 5 : 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        EstimateTexts(
                          amount: formattedTotalSales,
                          color: blue,
                          text: 'Sales',
                          headlineFontSize: largeFontSize,
                          bodyFontSize: bodyFontSize,
                        ),
                        verticalLine(),
                        EstimateTexts(
                          amount: formattedProfits,
                          color: green,
                          text: 'Profits',
                          headlineFontSize: largeFontSize,
                          bodyFontSize: bodyFontSize,
                        ),
                        verticalLine(),
                        EstimateTexts(
                          amount: formattedReturnedPrice,
                          color: red,
                          text: 'Returned',
                          headlineFontSize: largeFontSize,
                          bodyFontSize: bodyFontSize,
                        ),
                        SizedBox(width: size.width < 600 ? 5 : 15),
                        Padding(
                          padding: EdgeInsets.only(top: size.width < 600 ? 8 : 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StreamBuilder<DateTime>(
                                stream: currentTimeStream(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    String formattedTime = DateFormat.Hm().format(snapshot.data!);
                                    return Text(formattedTime, style: headline(black, headlineFontSize));
                                  }
                                  return SizedBox();
                                },
                              ),
                              Text(
                                size.width < 600 ? shortCurrentDate : currentDate,
                                style: bodyText(Colors.grey, bodyFontSize),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }

  Widget _buildTotalProducts(BuildContext context, double width, double headlineFontSize, double bodyFontSize, double largeFontSize, WidgetRef ref) {
    return StreamBuilder(
      stream: ref.watch(cloudStoreProvider).getStocks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: purple));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final stocks = snapshot.data!;
          final totalStocks = stocks.length;
          return Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width < 600 ? 10 : 20),
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: white,
              border: Border.all(width: 0.5, color: Colors.grey),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Products', style: bodyText(black, bodyFontSize)),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(totalStocks.toString(), style: headline(black, largeFontSize)),
                    Container(
                      height: MediaQuery.of(context).size.width < 600 ? 20 : 35,
                      width: 35,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.green[50],
                      ),
                      child: Text('+13%', style: headline(green, headlineFontSize)),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildTotalStores(BuildContext context, double width, double headlineFontSize, double bodyFontSize, double largeFontSize, WidgetRef ref) {
    return StreamBuilder(
      stream: ref.watch(cloudStoreProvider).getStores(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: purple));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final stores = snapshot.data!;
          final totalStores = stores.length;
          return Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width < 600 ? 10 : 20),
            width: width,
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
                      MediaQuery.of(context).size.width < 600 ? 'Stores' : 'Total Stores',
                      style: bodyText(black, bodyFontSize),
                    ),
                    SizedBox(height: 25),
                    Text(totalStores.toString(), style: headline(black, largeFontSize)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      MediaQuery.of(context).size.width < 600 ? 'Staff' : 'Total Staff',
                      style: bodyText(black, bodyFontSize),
                    ),
                    SizedBox(height: 25),
                    Text('4', style: headline(black, largeFontSize)),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildPerformanceList(
      BuildContext context, String title, List<ProductModel> products, double width, double headlineFontSize) {
    return Container(
      width: width,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width < 600 ? 10 : 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: bodyText(black, headlineFontSize)),
          SizedBox(height: 10),
          for (var product in products)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(product.productName, style: bodyText(black, headlineFontSize))),
                  Text(product.unitPrice, style: bodyText(black, headlineFontSize)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget verticalLine() {
    return Container(height: 40, width: 2, color: grey);
  }
}

class EstimateTexts extends StatelessWidget {
  const EstimateTexts({
    super.key,
    required this.amount,
    required this.text,
    required this.color,
    required this.headlineFontSize,
    required this.bodyFontSize,
  });

  final String amount;
  final String text;
  final Color color;
  final double headlineFontSize;
  final double bodyFontSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('₦ $amount', style: headline(black, headlineFontSize)),
        Text('• $text', style: headline(color, bodyFontSize)),
      ],
    );
  }
}
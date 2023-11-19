import 'package:bsims/const/textstyle.dart';
import 'package:bsims/firebase_repos/cloud_firestore.dart';
import 'package:bsims/screens/admin_dashboard/daily_class.dart';
import 'package:fl_chart/fl_chart.dart';
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
  final List<FlSpot> data = [
    const FlSpot(0, 3),
    const FlSpot(1, 4),
    const FlSpot(2, 2),
    const FlSpot(3, 5),
  ];
  final List<FlSpot> data1 = [
    const FlSpot(0, 5),
    const FlSpot(2, 4),
    const FlSpot(2, 2),
    const FlSpot(3, 5),
  ];
  List<DailySalesData> weeklySalesData = [
    DailySalesData('Mon', 150.0),
    DailySalesData('Tue', 200.0),
    DailySalesData('Wed', 180.0),
    DailySalesData('Thu', 220.0),
    DailySalesData('Fri', 250.0),
    DailySalesData('Sat', 300.0),
    DailySalesData('Sun', 280.0),
  ];
  String currentDate = DateFormat('dd MMMM, yyyy').format(DateTime.now());
  final now = DateTime.now();
  Stream<DateTime> currentTimeStream() {
    return Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
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
            return Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                      Text(currentDates),
                      Text(
                        'Total Estimate',
                        style: bodyText(black, 15),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        style: headline(black, 12),
                                      );
                                    } else {
                                      return const SizedBox(); // Display a loading indicator while waiting for the first data.
                                    }
                                  },
                                ),
                                Text(
                                  currentDate,
                                  style: bodyText(Colors.grey, 12),
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
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Products',
                                  style: bodyText(black, 15),
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
                                        style: headline(green, 10),
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
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total Stores',
                                      style: bodyText(black, 15),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total Staff',
                                      style: bodyText(black, 15),
                                    ),
                                    const SizedBox(height: 10),
                                    Text('100', style: headline(black, 23)),
                                  ],
                                )
                              ],
                            ));
                      }
                    }),
              ]),
              const SizedBox(height: 20),
              SizedBox(
                  height: 500,
                  width: 500,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                            color: const Color(0xff37434d), width: 1),
                      ),
                      minX: 0,
                      maxX: weeklySalesData.length.toDouble() - 1,
                      minY: 0,
                      maxY: 350,
                      lineBarsData: [
                        LineChartBarData(
                          spots: weeklySalesData
                              .asMap()
                              .entries
                              .map((entry) => FlSpot(
                                  entry.key.toDouble(), entry.value.sales))
                              .toList(),
                          isCurved: true,
                          color: Colors.blue,
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                    ),
                  ))
            ]);
          }
        });
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
          style: headline(color, 15),
        ),
      ],
    );
  }
}

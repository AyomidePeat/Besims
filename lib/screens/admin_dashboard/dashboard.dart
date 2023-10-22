import 'package:bsims/const/textstyle.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../const/colors.dart';

class Dashboard extends StatelessWidget {
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
  String currentDate = DateFormat('dd MMMM, yyyy').format(DateTime.now());
  final now = DateTime.now();
  Stream<DateTime> currentTimeStream() {
    return Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
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
              Text(
                'Total Estimate',
                style: bodyText(black, 15),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EstimateTexts(
                    amount: '32,100',
                    color: blue,
                    text: 'Sales',
                  ),
                  verticalLine(),
                  EstimateTexts(
                    amount: '16,230',
                    color: green,
                    text: 'Profits',
                  ),
                  verticalLine(),
                  EstimateTexts(
                    amount: '2,508',
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
        Container(
            padding: const EdgeInsets.all(20),
            height: 135,
            width: 400,
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
                  style: bodyText(black, 15),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('829', style: headline(black, 23)),
                    Container(
                      height: 20,
                      width: 35,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.green[50]),
                      child: Text(
                        '+13%',
                        style: headline(green, 10),
                      ),
                    ),
                  ],
                ),
              ],
            )),
        SizedBox(width: 30),
        Container(
            padding: const EdgeInsets.all(20),
            height: 135,
            width: 400,
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
                      'Total Stores',
                      style: bodyText(black, 15),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text('30', style: headline(black, 23)),
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
            )),
      ]),
      const SizedBox(height: 20),
      SizedBox(
        height: 500,
        width: 500,
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(
                leftTitles: AxisTitles(
                    sideTitles: SideTitles(
              showTitles: true,
              
            ))),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: const Color(0xff37434d),
                width: 1,
              ),
            ),
            minX: 0,
            maxX: data.length.toDouble() - 1,
            minY: 0,
            maxY: 10,
            lineBarsData: [
              LineChartBarData(
                spots: data,
                isCurved: true, // Enables curve for wavy effect
                color: Colors.blue, // Line color
                barWidth: 4, // Line width
                isStrokeCapRound: true, // Rounded line ends
                belowBarData: BarAreaData(show: false),
              ),
              LineChartBarData(
                spots: data1,
                isCurved: true, // Enables curve for wavy effect
                color: Colors.red, // Line color
                barWidth: 4, // Line width
                isStrokeCapRound: true, // Rounded line ends
                belowBarData: BarAreaData(show: false),
              ),
            ],
          ),
        ),
      )
    ]);
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

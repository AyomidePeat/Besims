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
    FlSpot(0, 3),
    FlSpot(1, 4),
    FlSpot(2, 2),
    FlSpot(3, 5),
  ];
  final List<FlSpot> data1 = [
    FlSpot(0, 5),
    FlSpot(2, 4),
    FlSpot(2, 2),
    FlSpot(3, 5),
  ];
  String currentDate =
      DateFormat(' EEEE,  MMMM dd, yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: screenWidth - 293,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Box(title: 'Total Sales', total: '\$3,610', percentage: '+12%'),
              Box(title: 'Total Profit', total: '\$1,479', percentage: '+12%'),
              Box(title: 'Total Quantity', total: '620', percentage: '+12%'),
            ],
          ),
        ),
         SizedBox(height: 500, width: 500,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
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
            color: Colors.blue,// Line color
              barWidth: 4, // Line width
              isStrokeCapRound: true, // Rounded line ends
              belowBarData: BarAreaData(show: false),
            ),
            LineChartBarData(
              spots: data1,
              isCurved: true, // Enables curve for wavy effect
            color: Colors.red,// Line color
              barWidth: 4, // Line width
              isStrokeCapRound: true, // Rounded line ends
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    )
      ],
    );
  }
}

class Box extends StatefulWidget {
  Box({
    super.key,
    required this.title,
    required this.total,
    required this.percentage,
  });
  final String title;
  final String total;
  final String percentage;

  @override
  State<Box> createState() => _BoxState();
}

class _BoxState extends State<Box> {
  List timeFrame = [
    'Today',
    'This week',
    'This month',
    'This year',
  ];

  String? time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 100,
      width: 260,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(253, 206, 200, 200),
            offset: Offset(0, 3),
            blurRadius: 3.0,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: bodyText(black, 13),
              ),
              SizedBox(width: 20),
              SizedBox(
                width: 140,
                height: 40,
                child: DropdownButtonFormField(
                  hint: Text(
                    'This month',
                    style: bodyText(Colors.grey, 15),
                  ),
                  value: time,
                  onChanged: (value) {
                    setState(() {
                      time = value as String;
                    });
                  },
                  items: timeFrame
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.toString()),
                          ))
                      .toList(),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.total, style: headline(black, 20)),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  widget.percentage,
                  style: bodyText(Colors.green[500]!, 10),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

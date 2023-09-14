import 'package:bsims/const/textstyle.dart';
import 'package:bsims/widgets/standard_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../const/colors.dart';
import '../../widgets/custom_container.dart';

class Sales extends StatefulWidget {
  Sales({
    super.key,
    required this.screenWidth,
    required this.size,
  });

  final double screenWidth;
  final Size size;

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  List labels = ['Cash ', 'Transfer', 'POS', 'Cheque'];
  List entries = ['10', '15', '20', '25', '30'];
  final fromController = TextEditingController();
  String? sales;
  String? entriesNo;
  final toController = TextEditingController();
  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  List iconColors = [green, red, yellow, Colors.blue];

  List bgColors = [
    Colors.green[300],
    Colors.pink[300],
    Colors.yellow[300],
    Colors.blue[300]
  ];

  String currentDate = DateFormat('MMMM, yyyy').format(DateTime.now());
  List salesOption = ['All Payments', 'Transfer', 'POS', 'Cheque'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.bar_chart,
              color: green,
              size: widget.screenWidth * 0.03,
            ),
            const SizedBox(width: 10),
            Text(
              'Sales Report for the Month of ',
              style: headline(black, widget.screenWidth * 0.013),
            ),
            Text(
              currentDate,
              style: headline(green, widget.screenWidth * 0.013),
            )
          ],
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: 100, maxWidth: widget.size.width - 293),
          child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                mainAxisExtent: 90,
              ),
              itemCount: labels.length,
              itemBuilder: (BuildContext context, int index) {
                return CustomContainer(
                    icon: Icons.credit_card,
                    bgColor: bgColors[index],
                    iconColor: iconColors[index],
                    label: labels[index],
                    quantity: 0);
              }),
        ),
        const SizedBox(height: 20),
        Container(
          width: widget.size.width - 293,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'You can filter sales record by date range',
                style: headline(const Color.fromARGB(255, 230, 221, 221),
                    widget.screenWidth * 0.012),
              ),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(height: 15,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 230, 221, 221),
                      ),
                      child: Text(
                        'From',
                        style: bodyText(black, 12),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 250,
                      height: 40,
                      child: TextField(
                        decoration: const InputDecoration(
                            hintText: 'dd/mm/yyyy', border: InputBorder.none),
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.188,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Kanit',
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                        controller: fromController,
                        onTap: () async {
                          DateTime? pickeddate = await showDatePicker(
                            context: context,
                            initialDate: DateTime
                                .now(), // Initial date when the picker opens
                            firstDate: DateTime(2000),
                            // Minimum selectable date
                            lastDate: DateTime(2100), // Maximum selectable date
                          );

                          if (pickeddate != null) {
                            setState(() {
                              fromController.text =
                                  DateFormat('dd/MM/yyyy').format(pickeddate);
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const Icon(Icons.calendar_month),
                    const SizedBox(
                      width: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 230, 221, 221),
                      ),
                      child: Text(
                        'To',
                        style: bodyText(black, 12),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      width: 250,
                      height: 40,
                      child: TextField(
                        decoration: const InputDecoration(
                            hintText: 'dd/mm/yyyy', border: InputBorder.none),
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.188,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Kanit',
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                        controller: fromController,
                        onTap: () async {
                          DateTime? pickeddate = await showDatePicker(
                            context: context,
                            initialDate: DateTime
                                .now(), // Initial date when the picker opens
                            firstDate: DateTime(2000),
                            // Minimum selectable date
                            lastDate: DateTime(2100), // Maximum selectable date
                          );

                          if (pickeddate != null) {
                            setState(() {
                              fromController.text =
                                  DateFormat('dd/MM/yyyy').format(pickeddate);
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const Icon(Icons.calendar_month),
                    const SizedBox(
                      width: 90,
                    ),
                    Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: DropdownButtonFormField(
                            hint: const Text('All Payments'),
                            value: sales,
                            onChanged: (value) {
                              setState(() {
                                sales = value as String;
                              });
                            },
                            items: salesOption
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e.toString()),
                                    ))
                                .toList(),
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 90),
                    SizedBox(height: 40,
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: black,
                            ),
                            hintText: 'Search for a record',
                            border: InputBorder.none),
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.188,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Kanit',
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                        controller: fromController,
                      ),
                    )
                  ],
                ),
              ),
              
               const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        const SizedBox(
                height: 40,
              ),
        Container(
                width: widget.size.width - 293,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: white),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text('Show'),
                        Container(
                          height: 55,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: DropdownButtonFormField(
                                hint: const Text('10'),
                                value: entriesNo,
                                onChanged: (value) {
                                  setState(() {
                                    entriesNo = value as String;
                                  });
                                },
                                items: entries
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e.toString()),
                                        ))
                                    .toList(),
                                // ignore: prefer_const_constructors
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text('entries'),
                      ],
                    ),
                    const SizedBox(height:20),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text('ORDER ID', style: headline(black, 10),),
                      Text('CUSTOMER', style: headline(black, 10),),
                      Text('SOLD BY', style: headline(black, 10),),
                      Text('AMOUNT', style: headline(black, 10),),
                      Text('TYPE', style: headline(black, 10),),
                    ],),
                    const SizedBox(height: 30,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text('INV-0000001', style: headline(black, 10),),
                      Text('Guest', style: bodyText(black, 10),),
                      Text('Uncle Peace', style: bodyText(black, 10),),
                      Row(
                        children: [

                          Text('N1,300.00', style: bodyText(black, 10),),
                        ],
                      ),
                      Container(padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: green), child: Text('Transfer', style: headline(white, 10),)),
                    ],),
                    const SizedBox(height: 30,),
                    Text('Showing 1 of 1 entries', style: bodyText(black, 10),)
                  ],
                ),
              )
      ],
    );
  }
}

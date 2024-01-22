import 'package:bsims/const/textstyle.dart';
import 'package:bsims/firebase_repos/cloud_firestore.dart';
import 'package:bsims/models/product_model.dart';
import 'package:bsims/screens/admin_dashboard/excel_downloader.dart';
import 'package:bsims/screens/admin_dashboard/filter_sales.dart';
import 'package:bsims/screens/admin_dashboard/orders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../const/colors.dart';
import '../../../widgets/custom_container.dart';

class Sales extends ConsumerStatefulWidget {
  const Sales({
    super.key,
    required this.screenWidth,
    required this.size,
  });

  final double screenWidth;
  final Size size;

  @override
  ConsumerState<Sales> createState() => _SalesState();
}

class _SalesState extends ConsumerState<Sales> {
  List labels = ['Cash ', 'Transfer', 'POS', 'Cheque'];
  List entries = ['10', '15', '20', '25', '30'];
  final fromController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  double? _predictedPrice;
  String? sales;
  String? entriesNo;
  final toController = TextEditingController();
  final searchController = TextEditingController();
  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  List iconColors = [
    green,
    Colors.blue,
    Colors.orange,
    red,
  ];

  List bgColors = [
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.red,
  ];

  String currentDate = DateFormat('MMMM, yyyy').format(DateTime.now());
  List salesOption = ['All Payments', 'Transfer', 'POS', 'Cheque'];
  DateTime? fromDate =
      DateTime(2023, 11, 1); // Replace with your initial from date
  DateTime? toDate = DateTime.now();
  Future<List<ProductModel>> getSales() async {
    return getSalesByDate(fromDate!, toDate!);
  }

  Future<void> _predictPrice(String productName) async {
    // Replace these values with your actual Firebase configuration
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _productsCollection =
        _firestore.collection('stock-inventory');
    try {
      QuerySnapshot productsSnapshot = await _productsCollection.get();
      String lowerCaseProductName = productName.toLowerCase();

      DocumentSnapshot productSnapshot = productsSnapshot.docs.firstWhere(
        (doc) => doc.id.toLowerCase() == lowerCaseProductName,
        orElse: () => throw Exception('Product not found'),
      );
      if (productSnapshot.exists) {
        String price = productSnapshot['costPrice'].trim();
        double historicalPrice = double.parse(price);
        _predictedPrice = historicalPrice * 1.1; // Simple example: 10% markup
      } else {
        print('Product not found');
        _predictedPrice = null;
      }
    } catch (e) {
      print('Error predicting price: $e');
      _predictedPrice = null;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final widgetSize = (widget.screenWidth - 293) / 12;
    final cloudstoreRef = ref.watch(cloudStoreProvider);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.bar_chart,
                color: purple,
                size: widget.screenWidth * 0.03,
              ),
              const SizedBox(width: 10),
              Text(
                'Sales Report for the Month of ',
                style: headline(black, widget.screenWidth * 0.013),
              ),
              Text(
                currentDate,
                style: headline(purple!, widget.screenWidth * 0.013),
              )
            ],
          ),
          StreamBuilder(
              stream: cloudstoreRef.getProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [CircularProgressIndicator(color: purple)]);
                } else {
                  final stocks = snapshot.data!;
                  double cash = 0;
                  double cashPrice = 0;
                  double cheque = 0;
                  double chequePrice = 0;
                  double transfer = 0;
                  double transferPrice = 0;
                  double pos = 0;
                  double posPrice = 0;
                  for (int index = 0; index < stocks.length; index++) {
                    if (stocks[index].paymentMethod == "Cash") {
                      cash++;
                      cashPrice += int.parse(stocks[index].unitPrice);
                    }
                    if (stocks[index].paymentMethod == "Transfer") {
                      transfer++;
                      transferPrice += int.parse(stocks[index].unitPrice);
                    }
                    if (stocks[index].paymentMethod == "Cheque") {
                      cheque++;
                      chequePrice += int.parse(stocks[index].unitPrice);
                    }
                    if (stocks[index].paymentMethod == "POS") {
                      pos++;
                      posPrice += int.parse(stocks[index].unitPrice);
                    }
                  }
                  String formattedCashPrice =
                      NumberFormat('#,###').format(cashPrice);
                  String formattedTransferPrice =
                      NumberFormat('#,###').format(transferPrice);
                  String formattedChequePrice =
                      NumberFormat('#,###').format(chequePrice);
                  String formattedPosPrice =
                      NumberFormat('#,###').format(posPrice);
                  List<String> quantity = [
                    formattedCashPrice,
                    formattedTransferPrice,
                    formattedChequePrice,
                    formattedPosPrice
                  ];
                  return Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: 100, maxWidth: widget.size.width - 293),
                        child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
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
                                  quantity: quantity[index]);
                            }),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: widget.size.width - 293,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'You can filter sales record by date range',
                              style: headline(
                                  const Color.fromARGB(255, 230, 221, 221),
                                  widget.screenWidth * 0.012),
                            ),
                            const Divider(
                              thickness: 2,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color.fromARGB(
                                          255, 230, 221, 221),
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
                                          hintText: 'dd/mm/yyyy',
                                          border: InputBorder.none),
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 1.188,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Kanit',
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      controller: fromController,
                                      onTap: () async {
                                        fromDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2020),
                                          lastDate: DateTime.now(),
                                        );

                                        if (fromDate != null) {
                                          setState(() {
                                            fromController.text =
                                                DateFormat('dd/MM/yyyy')
                                                    .format(fromDate!);
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
                                      color: const Color.fromARGB(
                                          255, 230, 221, 221),
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
                                          hintText: 'dd/mm/yyyy',
                                          border: InputBorder.none),
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 1.188,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Kanit',
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      controller: toController,
                                      onTap: () async {
                                        toDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime
                                              .now(), // Initial date when the picker opens
                                          firstDate: DateTime(2020),
                                          // Minimum selectable date
                                          lastDate: DateTime
                                              .now(), // Maximum selectable date
                                        );

                                        if (toDate != null) {
                                          setState(() {
                                            toController.text =
                                                DateFormat('dd/MM/yyyy')
                                                    .format(toDate!);
                                          });
                                        }
                                        getSales();
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
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
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 90),
                                  SizedBox(
                                    height: 40,
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
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      controller: searchController,
                                    ),
                                  ),
                                  const SizedBox(width: 70),
                                  InkWell(
                                    onTap: excelDownloader,
                                    child: Container(
                                      height: 35,
                                      width: 90,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: purple,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text('Download all',
                                          style: bodyText(white, 10)),
                                    ),
                                  ),
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
                      SaleHeadings(widgetSize: widgetSize),
                      SizedBox(
                        height: 300,
                        width: widget.screenWidth - 290,
                        child: FutureBuilder<List<ProductModel>>(
                          future: getSales(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                    'Error fetching sales: ${snapshot.error}'),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Center(
                                child: Text(
                                    'No sales found for the selected date range.'),
                              );
                            } else {
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  final stocks = snapshot.data![index];
                                  String productName = stocks.productName;
                                  String category = stocks.category;
                                  String sellingPrice = stocks.unitPrice;
                                  String quantity = stocks.quantity;
                                  String seller = stocks.seller;
                                  String stockQty = stocks.stockQty;
                                  String status = stocks.status;
                                  String paymentMethod = stocks.paymentMethod;

                                  return ListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    title: productList(widget.screenWidth,
                                        sn: index + 1,
                                        category: category,
                                        seller: seller,
                                        price: sellingPrice,
                                        productName: productName,
                                        quantity: quantity,
                                        status: status,
                                        stockQty: stockQty,
                                        paymentMethod: paymentMethod),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: widget.screenWidth - 290,
                        child: TextField(
                          controller: _productNameController,
                          decoration:
                              const InputDecoration(labelText: 'Product Name'),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      ElevatedButton(
                        onPressed: () =>
                            _predictPrice(_productNameController.text),
                        child: const Text('Predict Price'),
                      ),
                      const SizedBox(height: 14.0),
                      _predictedPrice != null
                          ? Text(
                              'Predicted Price: \$${_predictedPrice!.toStringAsFixed(2)}')
                          : Container(),
                    ],
                  );
                }
              }),
        ],
      ),
    );
  }
}

class SaleHeadings extends StatelessWidget {
  const SaleHeadings({
    super.key,
    required this.widgetSize,
  });

  final double widgetSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: widgetSize,
          child: Text(
            'S/N',
            style: headline(black, 10),
          ),
        ),
        SizedBox(
          width: widgetSize,
          child: Text(
            'PRODUCTS',
            style: headline(black, 10),
          ),
        ),
        SizedBox(
          width: widgetSize,
          child: Text(
            'CATEGORY',
            style: headline(black, 10),
          ),
        ),
        SizedBox(
          width: widgetSize,
          child: Text(
            'PRICE',
            style: headline(black, 10),
          ),
        ),
        SizedBox(
          width: widgetSize,
          child: Text(
            'STOCK QUANTITY',
            style: headline(black, 10),
          ),
        ),
        SizedBox(
          width: widgetSize,
          child: Text(
            'QUANTITY',
            style: headline(black, 10),
          ),
        ),
        SizedBox(
          width: widgetSize,
          child: Text(
            'SELLER',
            style: headline(black, 10),
          ),
        ),
        SizedBox(
          width: widgetSize,
          child: Text(
            'PAYMENT METHOD',
            style: headline(black, 10),
          ),
        ),
        SizedBox(
          width: widgetSize,
          child: Text(
            'STATUS',
            style: headline(black, 10),
          ),
        ),
      ],
    );
  }
}

excelDownloader() {
  exportReportsExcelFile();
}

import 'package:bsims/const/textstyle.dart';
import 'package:bsims/firebase_repos/cloud_firestore.dart';
import 'package:bsims/screens/admin_dashboard/excel_downloader.dart';
import 'package:bsims/screens/admin_dashboard/excel_picker.dart';
import 'package:bsims/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../const/colors.dart';

class Orders extends ConsumerStatefulWidget {
  final double screenWidth;
  const Orders({super.key, required this.screenWidth});

  @override
  ConsumerState<Orders> createState() => _OrdersState();
}

class _OrdersState extends ConsumerState<Orders> {
  double space = 30;
  bool isLoading = false;

  @override
  @override
  Widget build(BuildContext context) {
    final cloudStoreRef = ref.watch(cloudStoreProvider);
    final widgetSize = (widget.screenWidth - 293) / 12;

    return Column(children: [
      StreamBuilder(
          stream: cloudStoreRef.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator(color: purple)]);
            } else {
              final stocks = snapshot.data!;
              final totalOrders = stocks.length;
              int returnedCount = 0;
              for (int index = 0; index < stocks.length; index++) {
                if (stocks[index].status == "Returned") {
                  returnedCount++;
                }
              }
              int deliveryCount = 0;
              for (int index = 0; index < stocks.length; index++) {
                if (stocks[index].status == "Out for delivery") {
                  deliveryCount++;
                }
              }
              int confirmedCount = 0;
              for (int index = 0; index < stocks.length; index++) {
                if (stocks[index].status == "Confirmed") {
                  confirmedCount++;
                }
              }

              if (stocks.isNotEmpty) {
                return Column(
                  children: [
                    Container(
                      width: widget.screenWidth - 293,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Overall Orders', style: headline(black, 17)),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Boxes(
                                icon: Icons.category,
                                circleColor: Colors.purple[50]!,
                                iconColor:
                                    const Color.fromARGB(255, 146, 71, 188),
                                title: 'Total Orders',
                                total: totalOrders.toString(),
                              ),
                              Boxes(
                                icon: Icons.shopping_cart,
                                circleColor: Colors.green[50]!,
                                iconColor:
                                    const Color.fromARGB(255, 85, 196, 89),
                                title: 'Total Delivered',
                                total: confirmedCount.toString(),
                              ),
                              Boxes(
                                icon: Icons.delivery_dining_sharp,
                                circleColor: Colors.blue[50]!,
                                iconColor: Colors.blue,
                                title: ' In Transit',
                                total: deliveryCount.toString(),
                              ),
                              Boxes(
                                icon: Icons.sell,
                                circleColor: Colors.red[50]!,
                                iconColor: red,
                                title: 'Total Returned',
                                total: returnedCount.toString(),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                        width: widget.screenWidth - 293,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Orders', style: headline(black, 17)),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: addProduct,
                                      child: Container(
                                        height: 35,
                                        width: 90,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: purple),
                                        child: Text('Add Product',
                                            style: bodyText(white, 12)),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    InkWell(
                                      onTap: excelPicker,
                                      child: Container(
                                        height: 35,
                                        width: 90,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.grey[400]!)),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.downloading_rounded,
                                              size: 15,
                                            ),
                                            const SizedBox(width: 5),
                                            Text('Import',
                                                style: bodyText(black, 12)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    InkWell(
                                      onTap: excelDownloader,
                                      child: Container(
                                        height: 35,
                                        width: 90,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.grey[400]!)),
                                        child: Text('Download all',
                                            style: bodyText(black, 12)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Divider(),
                            const SizedBox(height: 10),
                            Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: widgetSize,
                                    child: Text(
                                      'S/N',
                                      style: headline(black, 14),
                                    ),
                                  ),
                                  SizedBox(
                                    width: widgetSize,
                                    child: Text(
                                      'PRODUCTS',
                                      style: headline(black, 14),
                                    ),
                                  ),
                                  SizedBox(
                                    width: widgetSize,
                                    child: Text(
                                      'CATEGORY',
                                      style: headline(black, 14),
                                    ),
                                  ),
                                  SizedBox(
                                    width: widgetSize,
                                    child: Text(
                                      'PRICE',
                                      style: headline(black, 14),
                                    ),
                                  ),
                                  SizedBox(
                                    width: widgetSize,
                                    child: Text(
                                      'STOCK QUANTITY',
                                      style: headline(black, 14),
                                    ),
                                  ),
                                  SizedBox(
                                    width: widgetSize,
                                    child: Text(
                                      'QUANTITY',
                                      style: headline(black, 14),
                                    ),
                                  ),
                                  SizedBox(
                                    width: widgetSize,
                                    child: Text(
                                      'SELLER',
                                      style: headline(black, 14),
                                    ),
                                  ),
                                  SizedBox(
                                    width: widgetSize,
                                    child: Text(
                                      'PAYMENT METHOD',
                                      style: headline(black, 14),
                                    ),
                                  ),
                                  SizedBox(
                                    width: widgetSize,
                                    child: Text(
                                      'STATUS',
                                      style: headline(black, 14),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                            ]),
                            SizedBox(
                              width: widget.screenWidth - 280,
                              height: 446,
                              child: ListView.builder(
                                  itemCount: stocks.length,
                                  itemBuilder: (context, index) {
                                    String productName =
                                        stocks[index].productName;
                                    String category = stocks[index].category;
                                    String sellingPrice =
                                        stocks[index].unitPrice;
                                    String quantity = stocks[index].quantity;
                                    String seller = stocks[index].seller;
                                    String stockQty = stocks[index].stockQty;
                                    String status = stocks[index].status;
                                    String paymentMethod =
                                        stocks[index].paymentMethod;

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
                                  }),
                            ),
                          ],
                        )),
                  ],
                );
              }
            }
            return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(children: [
                  Container(
                    width: widget.screenWidth - 293,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15), color: white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Overall Orders', style: headline(black, 17)),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Boxes(
                              icon: Icons.category,
                              circleColor: Colors.purple[50]!,
                              iconColor:
                                  const Color.fromARGB(255, 146, 71, 188),
                              title: 'Total Orders',
                              total: '0',
                            ),
                            Boxes(
                              icon: Icons.shopping_cart,
                              circleColor: Colors.green[50]!,
                              iconColor: const Color.fromARGB(255, 85, 196, 89),
                              title: 'Total Delivered',
                              total: '0',
                            ),
                            Boxes(
                              icon: Icons.delivery_dining_sharp,
                              circleColor: Colors.blue[50]!,
                              iconColor: Colors.blue,
                              title: ' In Transit',
                              total: '0',
                            ),
                            Boxes(
                              icon: Icons.sell,
                              circleColor: Colors.red[50]!,
                              iconColor: red,
                              title: 'Total Returned',
                              total: '0',
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                      width: widget.screenWidth - 293,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: white),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Orders', style: headline(black, 17)),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: addProduct,
                                      child: Container(
                                        height: 35,
                                        width: 90,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: purple),
                                        child: Text('Add Product',
                                            style: bodyText(white, 14)),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    InkWell(
                                      onTap: excelPicker,
                                      child: Container(
                                        height: 35,
                                        width: 90,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.grey[400]!)),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.downloading_rounded,
                                              size: 15,
                                            ),
                                            const SizedBox(width: 5),
                                            Text('Import',
                                                style: bodyText(black, 14)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    InkWell(
                                      onTap: excelDownloader,
                                      child: Container(
                                        height: 35,
                                        width: 90,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.grey[400]!)),
                                        child: Text('Download all',
                                            style: bodyText(black, 14)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Divider(),
                            const SizedBox(height: 10),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: widgetSize,
                                      child: Text(
                                        'S/N',
                                        style: headline(black, 14),
                                      ),
                                    ),
                                    SizedBox(
                                      width: widgetSize,
                                      child: Text(
                                        'PRODUCTS',
                                        style: headline(black, 14),
                                      ),
                                    ),
                                    SizedBox(
                                      width: widgetSize,
                                      child: Text(
                                        'CATEGORY',
                                        style: headline(black, 14),
                                      ),
                                    ),
                                    SizedBox(
                                      width: widgetSize,
                                      child: Text(
                                        'PRICE',
                                        style: headline(black, 14),
                                      ),
                                    ),
                                    SizedBox(
                                      width: widgetSize,
                                      child: Text(
                                        'STOCK QUANTITY',
                                        style: headline(black, 14),
                                      ),
                                    ),
                                    SizedBox(
                                      width: widgetSize,
                                      child: Text(
                                        'QUANTITY',
                                        style: headline(black, 14),
                                      ),
                                    ),
                                    SizedBox(
                                      width: widgetSize,
                                      child: Text(
                                        'SELLER',
                                        style: headline(black, 14),
                                      ),
                                    ),
                                    SizedBox(
                                      width: widgetSize,
                                      child: Text(
                                        'PAYMENT METHOD',
                                        style: headline(black, 14),
                                      ),
                                    ),
                                    SizedBox(
                                      width: widgetSize,
                                      child: Text(
                                        'STATUS',
                                        style: headline(black, 14),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Center(
                                    child: Text('Your stock inventory is empty',
                                        style: bodyText(black, 16))),
                              ],
                            ),
                          ]))
                ]));
          })
    ]);
  }

  excelPicker() async {
    await importOrderFile(pickExcelFile());
  }

  excelDownloader() {
    exportOrdersExcelFile();
  }

  addProduct() {
    final nameController = TextEditingController();
    FirestoreClass fireStore = FirestoreClass();
    final stockQunatityController = TextEditingController();
    final sellingPriceController = TextEditingController();
    final sellerController = TextEditingController();
    final quantityController = TextEditingController();
    final costPriceController = TextEditingController();
    var isLoading = false;
    String? paymentMethod;
    final paymentMethods = [
      'Cash',
      'Transfer',
      'POS',
      'Cheque',
    ];

    String? category;
    final categoryOptions = [
      'Drug',
      'Foodstuff',
      'Cosmetic',
      'Brevaerage',
      'Skin Care',
      'Baby Products'
    ];
    final statusOptions = ['Confirmed', 'Out for delivery', 'Returned'];
    String? status;
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('New Order', style: headline(black, 20)),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFieldWidget(
                        controller: nameController, label: 'Product Name'),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        controller: sellerController, label: 'Seller'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        controller: sellingPriceController,
                        label: 'Selling price'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        controller: costPriceController, label: 'Cost price'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        controller: quantityController, label: 'Qty(Carton)'),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        controller: stockQunatityController,
                        label: 'Stock Qty(Carton)'),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                      hint: const Text('Status'),
                      value: status,
                      onChanged: (value) {
                        setState(() {
                          status = value as String;
                        });
                      },
                      items: statusOptions
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.toString()),
                              ))
                          .toList(),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                      hint: const Text('Category'),
                      value: category,
                      onChanged: (value) {
                        setState(() {
                          category = value as String;
                        });
                      },
                      items: categoryOptions
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.toString()),
                              ))
                          .toList(),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                      hint: const Text('Payment Method'),
                      value: paymentMethod,
                      onChanged: (value) {
                        setState(() {
                          paymentMethod = value as String;
                        });
                      },
                      items: paymentMethods
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.toString()),
                              ))
                          .toList(),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 103,
                            height: 40,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey)),
                            child: Center(
                                child: Text(
                              'Discard',
                              style: bodyText(black, 14),
                            )),
                          ),
                        ),
                        const SizedBox(width: 30),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            final uploadSuccess = await fireStore.addProduct(
                                category: category!,
                                paymentMethod: paymentMethod!,
                                status: status!,
                                productName: nameController.text,
                                stockQty: stockQunatityController.text,
                                unitPrice: sellingPriceController.text,
                                costPrice: costPriceController.text,
                                quantity: quantityController.text,
                                seller: sellerController.text);
                            if (uploadSuccess == 'Added') {
                              setState(() {
                                isLoading = false;
                              });

                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: purple,
                                      content: Text(
                                          uploadSuccess,
                                          textAlign: TextAlign.center,
                                          style:
                                              const TextStyle(fontSize: 16))));
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: purple,
                                      content: const Text('An error occured',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 16))));
                            }
                          },
                          child: Container(
                            width: 103,
                            height: 40,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: purple),
                            child: Center(
                                child: isLoading
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        'Add Product',
                                        style: bodyText(white, 14),
                                      )),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ]);
        });
  }
}

class Boxes extends StatelessWidget {
  const Boxes({
    super.key,
    required this.title,
    required this.total,
    required this.iconColor,
    required this.circleColor,
    required this.icon,
  });
  final String title;
  final String total;
  final Color iconColor;
  final Color circleColor;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 104,
      width: 300,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: bodyText(black, 14),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(total, style: headline(black, 20)),
              CircleAvatar(
                  radius: 20,
                  backgroundColor: circleColor,
                  child: Icon(icon, color: iconColor))
            ],
          ),
          Text(
            'Last 7 days',
            style: headline(iconColor, 14),
          )
        ],
      ),
    );
  }
}

Widget productList(
  screenWidth, {
  sn,
  productName,
  category,
  price,
  stockQty,
  paymentMethod,
  quantity,
  seller,
  status,
}) {
  final widgetSize = (screenWidth - 293) / 12;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
          width: widgetSize,
          child: Text(
            sn.toString(),
            style: bodyText(black, 14),
          ),
        ),
        SizedBox(
          width: widgetSize,
          child: Text(
            productName,
            style: bodyText(black, 14),
          ),
        ),
        SizedBox(
          width: widgetSize,
          child: Text(
            category,
            style: bodyText(black, 14),
          ),
        ),
        SizedBox(
          width: widgetSize,
          child: Text(
            price,
            style: bodyText(black, 14),
          ),
        ),
        SizedBox(
          width: widgetSize,
          child: Text(
            stockQty,
            style: bodyText(black, 14),
          ),
        ),
        SizedBox(
          width: widgetSize,
          child: Text(
            quantity,
            style: bodyText(black, 14),
          ),
        ),
        SizedBox(
          width: widgetSize,
          child: Text(
            seller,
            style: bodyText(black, 14),
          ),
        ),
        SizedBox(
          width: widgetSize,
          child: Text(
            paymentMethod,
            style: bodyText(black, 14),
          ),
        ),
        SizedBox(
          width: widgetSize,
          child: Text(
            status,
            style: bodyText(
                status == 'Returned'
                    ? red
                    : status == 'Confirmed'
                        ? green
                        : blue,
                13),
          ),
        ),
      ]),
      const Divider()
    ],
  );
}

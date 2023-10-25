import 'package:bsims/const/textstyle.dart';
import 'package:bsims/firebase_repos/cloud_firestore.dart';
import 'package:bsims/screens/admin_dashboard/excel_downloader.dart';
import 'package:bsims/screens/admin_dashboard/excel_picker.dart';
import 'package:bsims/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../const/colors.dart';

class StockInventory extends ConsumerStatefulWidget {
  final double screenWidth;
  const StockInventory({super.key, required this.screenWidth});

  @override
  ConsumerState<StockInventory> createState() => _StockInventoryState();
}

class _StockInventoryState extends ConsumerState<StockInventory> {
  double space = 30;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cloudStoreRef = ref.watch(cloudStoreProvider);
    final widgetSize = (widget.screenWidth - 293) / 12;

    return Column(children: [
      Container(
        width: widget.screenWidth - 293,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Overall Inventory', style: headline(black, 17)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Boxes(
                  icon: Icons.category,
                  circleColor: Colors.purple[50]!,
                  iconColor: const Color.fromARGB(255, 106, 71, 188),
                  title: 'Categories',
                  total: '14',
                ),
                Boxes(
                  icon: Icons.shopping_cart,
                  circleColor: Colors.green[50]!,
                  iconColor: const Color.fromARGB(255, 85, 196, 89),
                  title: 'Total Products',
                  total: '110',
                ),
                Boxes(
                  icon: Icons.sell,
                  circleColor: Colors.blue[50]!,
                  iconColor: Colors.blue,
                  title: 'Top Selling',
                  total: '5',
                ),
                Boxes(
                  icon: Icons.production_quantity_limits,
                  circleColor: Colors.red[50]!,
                  iconColor: Colors.red,
                  title: 'Low Stocks',
                  total: '12',
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
              borderRadius: BorderRadius.circular(15), color: white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Products', style: headline(black, 17)),
                  Row(
                    children: [
                      InkWell(
                        onTap: addProduct,
                        child: Container(
                          height: 35,
                          width: 90,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: purple),
                          child:
                              Text('Add Product', style: bodyText(white, 10)),
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
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey[400]!)),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.downloading_rounded,
                                size: 15,
                              ),
                              const SizedBox(width: 5),
                              Text('Import', style: bodyText(black, 10)),
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
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey[400]!)),
                          child:
                              Text('Download all', style: bodyText(black, 10)),
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
                          'EXPIRY DATE',
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
                          'SUPPLIER',
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
                          'STATUS',
                          style: headline(black, 10),
                        ),
                      ),
                      SizedBox(
                        width: widgetSize,
                        child: Text(
                          'ACTIONS',
                          style: headline(black, 10),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  StreamBuilder(
                      stream: cloudStoreRef.getStocks(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(color: purple);
                        } else {
                          final stocks = snapshot.data!;
                          if (stocks.isNotEmpty) {
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
                                    String supplier = stocks[index].supplier;
                                    String expiryDate =
                                        stocks[index].expiryDate;
                                    String status = stocks[index].status;

                                    return ListTile(
                                      contentPadding: const EdgeInsets.all(0),
                                      title: productList(widget.screenWidth,
                                          sn: index + 1,
                                          category: category,
                                          expiryDate: expiryDate,
                                          price: sellingPrice,
                                          productName: productName,
                                          quantity: quantity,
                                          status: status,
                                          supplier: supplier),
                                    );
                                  }),
                            );
                          }
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Center(
                              child: Text('Your stock inventory is empty',
                                  style: bodyText(black, 15))),
                        );
                      })
                ],
              ),
            ],
          ))
    ]);
  }

  addProduct() {
    final nameController = TextEditingController();
    FirestoreClass fireStore = FirestoreClass();
    final expiryDateController = TextEditingController();
    final sellingPriceController = TextEditingController();
    final costPriceController = TextEditingController();
    final quantityController = TextEditingController();
    var isLoading = false;
    String? supplier;

    final supplierOptions = ['A&B', 'SamDech', 'T&D'];
    String? category;
    final categoryOptions = [
      'Drug',
      'Foodstuff',
      'Cosmetic',
      'Brevaerage',
      'Skin Care',
      'Baby Products'
    ];
    final statusOptions = ['Available', 'Unavailable'];
    String? status;
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('New Product', style: headline(black, 20)),
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
                      controller: costPriceController, label: 'Cost price'),
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
                      controller: quantityController, label: 'Qty(Carton)'),
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
                    hint: const Text('Supplier'),
                    value: supplier,
                    onChanged: (value) {
                      setState(() {
                        supplier = value as String;
                      });
                    },
                    items: supplierOptions
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
                  TextField(
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.calendar_month),
                        hintText: 'Expiry Date',
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
                    controller: expiryDateController,
                    onTap: () async {
                      DateTime? pickeddate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );

                      if (pickeddate != null) {
                        setState(() {
                          expiryDateController.text =
                              DateFormat('dd/MM/yyyy').format(pickeddate);
                        });
                      }
                    },
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
                            style: bodyText(black, 10),
                          )),
                        ),
                      ),
                      const SizedBox(width: 30),
                      InkWell(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          final uploadSuccess =
                              await fireStore.addStockInventory(
                                  name: nameController.text,
                                  expiryDate: expiryDateController.text,
                                  sellingPrice: sellingPriceController.text,
                                  costPrice: costPriceController.text,
                                  quantity: quantityController.text,
                                  supplier: supplier!,
                                  category: category!,
                                  status: status!);
                          if (uploadSuccess == 'Added') {
                            setState(() {
                              isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: purple,
                                content: Text(uploadSuccess,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 16))));
                            Navigator.pop(context);
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                                      style: bodyText(white, 10),
                                    )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ]);
        });
  }

  Widget productList(
    screenWidth, {
    sn,
    productName,
    category,
    expiryDate,
    price,
    supplier,
    quantity,
    status,
  }) {
    final widgetSize = (screenWidth - 293) / 12;
    final firestore = FirestoreClass();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: widgetSize,
            child: Text(
              sn.toString(),
              style: bodyText(black, 13),
            ),
          ),
          SizedBox(
            width: widgetSize,
            child: Text(
              productName,
              style: bodyText(black, 13),
            ),
          ),
          SizedBox(
            width: widgetSize,
            child: Text(
              category,
              style: bodyText(black, 13),
            ),
          ),
          SizedBox(
            width: widgetSize,
            child: Text(
              expiryDate,
              style: bodyText(black, 13),
            ),
          ),
          SizedBox(
            width: widgetSize,
            child: Text(
              price,
              style: bodyText(black, 13),
            ),
          ),
          SizedBox(
            width: widgetSize,
            child: Text(
              supplier,
              style: bodyText(black, 13),
            ),
          ),
          SizedBox(
            width: widgetSize,
            child: Text(
              quantity,
              style: bodyText(black, 13),
            ),
          ),
          SizedBox(
            width: widgetSize,
            child: Text(
              status,
              style: bodyText(
                  status == 'Unavailable' || status == 'unavailable'
                      ? red
                      : green,
                  13),
            ),
          ),
          SizedBox(
            width: widgetSize,
            child: Row(
              children: [
                InkWell(
                    onTap: () {},
                    child: Icon(Icons.edit, size: 15, color: purple)),
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                    onTap: () {
                      firestore.deleteStock(productName);
                    },
                    child: Icon(Icons.delete_outlined, size: 15, color: red)),
              ],
            ),
          ),
        ]),
        const Divider()
      ],
    );
  }

  excelPicker() {
    importInventoryFile(pickExcelFile());
  }

  excelDownloader() {
    exportInventoryExcelFile();
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
      height: 100,
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
            style: bodyText(black, 13),
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
            style: headline(iconColor, 13),
          )
        ],
      ),
    );
  }
}

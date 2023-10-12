import 'package:bsims/const/textstyle.dart';
import 'package:bsims/firebase_repos/cloud_firestore.dart';
import 'package:bsims/models/stock_inventory_model.dart';
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Stock Inventory',
              style: headline(black, widget.screenWidth * 0.013),
            ),
            SizedBox(
              width: widget.screenWidth * 0.5,
            ),
            InkWell(
              onTap: addProduct,
              child: Container(
                height: 40,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: green),
                child: Row(
                  children: [
                    Icon(
                      Icons.add_circle_sharp,
                      size: 20,
                      color: white,
                    ),
                    const SizedBox(width: 5),
                    Text('Add New Product', style: bodyText(black, 10))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        StreamBuilder(
            stream: cloudStoreRef.getStocks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(color: Colors.green);
              } else {
                final stocks = snapshot.data!;
                if (stocks.isNotEmpty) {
                  int index = 0;
                  for (; index >= 0 && index < stocks.length;) {
                    index++;
                    String productName = stocks[index].name;
                    String category = stocks[index].category;
                    String costPrice = stocks[index].costPrice;
                    String sellingPrice = stocks[index].sellingPrice;
                    String quantity = stocks[index].quantity;
                    String supplier = stocks[index].supplier;
                    String expiryDate = stocks[index].expiryDate;
                    String status = stocks[index].status;

                    return Container(
                      width: widget.screenWidth - 293,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5), color: white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'S/N',
                                style: headline(black, 10),
                              ),
                              SizedBox(
                                height: space,
                              ),
                              SizedBox(
                                height: 300,
                                width: 70,
                                child: ListView.builder(
                                    itemCount: stocks.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Text(
                                          '${index + 1}',
                                          style: bodyText(black, 10),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PRODUCTS',
                                style: headline(black, 10),
                              ),
                              SizedBox(
                                height: space,
                              ),
                              SizedBox(
                                height: 300,
                                width: 70,
                                child: ListView.builder(
                                    itemCount: stocks.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Text(
                                          productName,
                                          style: bodyText(black, 10),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CATEGORY',
                                style: headline(black, 10),
                              ),
                              SizedBox(
                                height: space,
                              ),
                              SizedBox(
                                height: 300,
                                width: 70,
                                child: ListView.builder(
                                    itemCount: stocks.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Text(
                                          category,
                                          style: bodyText(black, 10),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'EXPIRE',
                                style: headline(black, 10),
                              ),
                              SizedBox(
                                height: space,
                              ),
                              SizedBox(
                                height: 300,
                                width: 70,
                                child: ListView.builder(
                                    itemCount: stocks.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Text(
                                          expiryDate,
                                          style: bodyText(black, 10),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PRICE',
                                style: headline(black, 10),
                              ),
                              SizedBox(
                                height: space,
                              ),
                              SizedBox(
                                height: 300,
                                width: 70,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: ListView.builder(
                                      itemCount: stocks.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 20),
                                          child: Text(
                                            sellingPrice,
                                            style: bodyText(black, 10),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'STATUS',
                                style: headline(black, 10),
                              ),
                              SizedBox(
                                height: space,
                              ),
                              SizedBox(
                                height: 300,
                                width: 70,
                                child: ListView.builder(
                                    itemCount: stocks.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Text(
                                          status,
                                          style: bodyText(black, 10),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SUPPLIER',
                                style: headline(black, 10),
                              ),
                              SizedBox(
                                height: space,
                              ),
                              SizedBox(
                                height: 300,
                                width: 70,
                                child: ListView.builder(
                                    itemCount: stocks.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Text(
                                          supplier,
                                          style: bodyText(black, 10),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'QUANTITY',
                                style: headline(black, 10),
                              ),
                              SizedBox(
                                height: space,
                              ),
                              SizedBox(
                                height: 300,
                                width: 70,
                                child: ListView.builder(
                                    itemCount: stocks.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Text(
                                          quantity,
                                          style: bodyText(black, 10),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ACTIONS',
                                style: headline(black, 10),
                              ),
                              SizedBox(
                                height: space,
                              ),
                              SizedBox(
                                height: 300,
                                width: 50,
                                child: ListView.builder(
                                    itemCount: stocks.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Row(
                                          children: [
                                            InkWell(
                                                onTap: () {},
                                                child: Icon(Icons.edit_document,
                                                    size: 15, color: green)),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            InkWell(
                                                onTap: () {},
                                                child: Icon(
                                                    Icons.delete_outlined,
                                                    size: 15,
                                                    color: red)),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                }
              }
              return SizedBox();
            }),
      ],
    );
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
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Add Product', style: headline(black, 20)),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.cancel_outlined))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                      controller: nameController, label: 'Product Name'),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 250,
                          child: TextFieldWidget(
                              controller: costPriceController,
                              label: 'Cost price')),
                      const SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                          width: 250,
                          child: TextFieldWidget(
                              controller: sellingPriceController,
                              label: 'Selling price')),
                      const SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                          width: 250,
                          child: TextFieldWidget(
                              controller: quantityController,
                              label: 'Qty(Carton)')),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Center(
                            child: DropdownButtonFormField(
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
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Center(
                            child: DropdownButtonFormField(
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
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          height: 50,
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Center(
                              child: DropdownButtonFormField(
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
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 400,
                        height: 50,
                        child: TextField(
                          decoration: const InputDecoration(
                              hintText: 'Expiry Date',
                              border: InputBorder.none),
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.188,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Kanit',
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                          controller: expiryDateController,
                          onTap: () async {
                            DateTime? pickeddate = await showDatePicker(
                              context: context,
                              initialDate: DateTime
                                  .now(), // Initial date when the picker opens
                              firstDate: DateTime(2000),
                              // Minimum selectable date
                              lastDate:
                                  DateTime(2100), // Maximum selectable date
                            );

                            if (pickeddate != null) {
                              setState(() {
                                expiryDateController.text =
                                    DateFormat('dd/MM/yyyy').format(pickeddate);
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.calendar_month),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                                backgroundColor: Colors.green,
                                content: Text(uploadSuccess,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 16))));
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(uploadSuccess,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 16))));
                          }
                        },
                        child: Container(
                          width: 103,
                          height: 40,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: green),
                          child: Center(
                              child: isLoading
                                  ? const CircularProgressIndicator()
                                  : Text(
                                      'Submit',
                                      style: headline(white, 15),
                                    )),
                        ),
                      ),
                      const SizedBox(width: 30),
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
                              color: Colors.grey),
                          child: Center(
                              child: Text(
                            'Dismiss',
                            style: headline(white, 15),
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
}

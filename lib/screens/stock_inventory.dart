import 'package:bsims/const/textstyle.dart';
import 'package:bsims/screens/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../const/colors.dart';

class StockInventory extends StatefulWidget {
  final double screenWidth;
  const StockInventory({super.key, required this.screenWidth});

  @override
  State<StockInventory> createState() => _StockInventoryState();
}

class _StockInventoryState extends State<StockInventory> {
  double space = 10;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                     Text('Add New Product', style:bodyText(black, 10))
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
        Container(
          width: widget.screenWidth - 293,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: white),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                    Text(
                      'Product One',
                      style: headline(black, 10),
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Text(
                      'Product Two',
                      style: headline(black, 10),
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Text(
                      'Product Three',
                      style: headline(black, 10),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Breverage',
                      style: headline(black, 10),
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Text(
                      'Food',
                      style: bodyText(black, 10),
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Text(
                      'Drug',
                      style: bodyText(black, 10),
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Text(
                      'Timothy',
                      style: bodyText(black, 10),
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
                    Text(
                      '04/06/2025',
                      style: bodyText(black, 10),
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Text(
                      '04/05/2025',
                      style: bodyText(black, 10),
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Text(
                      '04/09/2024',
                      style: bodyText(black, 10),
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
                    Text(
                      '200',
                      style: bodyText(black, 10),
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Text(
                      '5000',
                      style: bodyText(black, 10),
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Text(
                      '2500',
                      style: bodyText(black, 10),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'IN STOCK',
                      style: headline(black, 10),
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Text(
                      'YES',
                      style: bodyText(black, 10),
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Text(
                      'YES',
                      style: bodyText(black, 10),
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Text(
                      'YES',
                      style: bodyText(black, 10),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Supplier',
                      style: headline(black, 10),
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Text(
                      'T&D',
                      style: bodyText(black, 10),
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Text(
                      'SamDech',
                      style: bodyText(black, 10),
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Text(
                      'PerPee',
                      style: bodyText(black, 10),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quantity',
                      style: headline(black, 10),
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Text(
                      '1',
                      style: bodyText(black, 10),
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Text(
                      '1',
                      style: bodyText(black, 10),
                    ),
                    SizedBox(
                      height: space,
                    ),
                    Text(
                      '1',
                      style: bodyText(black, 10),
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
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: green, borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Available',
                        style: bodyText(white, 10),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: green,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Available',
                        style: bodyText(white, 10),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: red,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Unavailble',
                        style: bodyText(white, 10),
                      ),
                    ),
                  ],
                ),
                
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ACTIONS',
                        style: headline(black, 10),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          InkWell(
                              onTap: () {},
                              child: Icon(Icons.edit_document,
                                  size: 15, color: green)),
                          SizedBox(
                            width: 8,
                          ),
                          InkWell(
                              onTap: () {},
                              child: Icon(Icons.delete_outlined,
                                  size: 15, color: red)),
                        ],
                      ),
                      SizedBox(
                        height: space,
                      ),
                      Row(
                        children: [
                          InkWell(
                              onTap: () {},
                              child: Icon(Icons.edit_document,
                                  size: 15, color: green)),
                          SizedBox(
                            width: 8,
                          ),
                          InkWell(
                              onTap: () {},
                              child: Icon(Icons.delete_outlined,
                                  size: 15, color: red)),
                        ],
                      ),
                      SizedBox(
                        height: space,
                      ),
                      Row(
                        children: [
                          InkWell(
                              onTap: () {},
                              child: Icon(Icons.edit_document,
                                  size: 15, color: green)),
                          SizedBox(
                            width: 8,
                          ),
                          InkWell(
                              onTap: () {},
                              child: Icon(Icons.delete_outlined,
                                  size: 15, color: red)),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ]),
        )
      ],
    );
  }

  void addProduct() {
    final nameController = TextEditingController();
    final categoryController = TextEditingController();
    final expiryDateController = TextEditingController();
    final priceController = TextEditingController();
    String? supplier;
    final supplierOptions = ['A&B', 'SamDech', 'T&D'];
    String? category;
    final categoryOptions = ['Drug', 'Foodstuff', 'Cosmetic', 'Brevaerage', 'Skin Care', 'Baby Products'];
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
                    children: [

        
                      SizedBox(width:300,
                        child: TextFieldWidget(controller: priceController, label: 'Price')),
                     const SizedBox(
                    width: 10,
                  ),
                     Padding(
                       padding: const EdgeInsets.symmetric(vertical:20),
                       child: Container(
                          height: 60,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, ),
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
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                     ),],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [ 
                      Container(
                        height: 50,
                        width: 250,
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
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                     
                      Container(
                        height: 40,
                        width: 250,
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
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: TextField(
                          decoration: const InputDecoration(
                              hintText: 'Expiry Date', border: InputBorder.none),
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
                              initialDate: DateTime
                                  .now(), // Initial date when the picker opens
                              firstDate: DateTime(2000),
                              // Minimum selectable date
                              lastDate: DateTime(2100), // Maximum selectable date
                            );

                            if (pickeddate != null) {
                              setState(() {
                                expiryDateController.text =
                                    DateFormat('dd/MM/yyyy').format(pickeddate);
                              });
                            }
                          },
                        ),
                      ),const SizedBox(
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
                        onTap: () {},
                        child: Container(
                          width: 103,
                          height: 40,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: green),
                          child: Center(
                              child: Text(
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

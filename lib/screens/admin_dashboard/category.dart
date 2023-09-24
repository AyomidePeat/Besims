import 'package:bsims/const/textstyle.dart';
import 'package:bsims/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

import '../../const/colors.dart';

class ProductCategoryList extends StatefulWidget {
  final double screenWidth;
  const ProductCategoryList({super.key, required this.screenWidth});

  @override
  State<ProductCategoryList> createState() => _ProductCategoryListState();
}

class _ProductCategoryListState extends State<ProductCategoryList> {
  @override
  Widget build(BuildContext context) {
    const double space = 30;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Product Category List',
              style: headline(black, widget.screenWidth * 0.013),
            ),
            SizedBox(
              width: widget.screenWidth * 0.3,
            ),
            InkWell(
              onTap: addStore,
              child: Container(
                height: 40,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: green),
                child: Row(
                  children: [
                    Icon(
                      Icons.add_circle_sharp,
                      size: 15,
                      color: white,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Add Category',
                      style: bodyText(black, 12),
                    )
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
          padding: const EdgeInsets.all(20),
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
                      'S/N',
                      style: headline(black, 10),
                    ),
                    const SizedBox(
                      height: space,
                    ),
                    Text(
                      '1',
                      style: bodyText(black, 10),
                    ),
                    const SizedBox(
                      height: space,
                    ),
                    Text(
                      '2',
                      style: bodyText(black, 10),
                    ),
                    const SizedBox(
                      height: space,
                    ),
                    Text(
                      '3',
                      style: bodyText(black, 10),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CATEGORY NAME',
                      style: headline(black, 10),
                    ),
                    const SizedBox(
                      height: space,
                    ),
                    Text(
                      'Beverage',
                      style: bodyText(black, 10),
                    ),
                    const SizedBox(
                      height: space,
                    ),
                    Text(
                      'Tablet',
                      style: bodyText(black, 10),
                    ),
                    const SizedBox(
                      height: space,
                    ),
                    Text(
                      'Syrup',
                      style: bodyText(black, 10),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CREATED ON',
                      style: headline(black, 10),
                    ),
                    const SizedBox(
                      height: space,
                    ),
                    Text(
                      'May 31st, 2022',
                      style: bodyText(black, 10),
                    ),
                    const SizedBox(
                      height: space,
                    ),
                    Text(
                      ' April 2nd, 2022',
                      style: bodyText(black, 10),
                    ),
                    const SizedBox(
                      height: space,
                    ),
                    Text(
                      ' April 4th, 2022',
                      style: bodyText(black, 10),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'STATUS',
                        style: headline(black, 10),
                      ),
                      const SizedBox(
                        height: space-10,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: green,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          'ACTIVE',
                          style: bodyText(white, 10),
                        ),
                      ),
                      const SizedBox(
                        height: space - 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: red, borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          'INACTIVE',
                          style: bodyText(white, 10),
                        ),
                      ),
                      const SizedBox(
                        height: space - 10
                        ,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: green,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          'ACTIVE',
                          style: bodyText(white, 10),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ACTIONS',
                      style: headline(black, 10),
                    ),
                    const SizedBox(height: space),
                    Row(
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
                            child: Icon(Icons.delete_outlined,
                                size: 15, color: red)),
                      ],
                    ),
                    const SizedBox(height: space),
                    Row(
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
                            child: Icon(Icons.delete_outlined,
                                size: 15, color: red)),
                      ],
                    ),
                    const SizedBox(height: space),
                    Row(
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
                            child: Icon(Icons.delete_outlined,
                                size: 15, color: red)),
                      ],
                    ),
                  ],
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

  void addStore() {
    final nameController = TextEditingController();
    final companyController = TextEditingController();
    final addressController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    const double space = 10;
    showDialog(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 700,
            width: 700,
            child: SimpleDialog(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Add Suppliers', style: headline(black, 20)),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.cancel_outlined))
                      ],
                    ),
                    const SizedBox(
                      height: space,
                    ),
                    TextFieldWidget(
                        controller: nameController, label: 'Supplier Name'),
                    const SizedBox(
                      height: space,
                    ),
                    TextFieldWidget(
                        controller: companyController, label: 'Company Name'),
                    const SizedBox(
                      height: space,
                    ),
                    TextFieldWidget(
                        controller: emailController, label: 'E-mail'),
                    const SizedBox(
                      height: space,
                    ),
                    TextFieldWidget(
                        controller: phoneController, label: 'Supplier Phone'),
                    const SizedBox(
                      height: space,
                    ),
                    TextFieldWidget(
                        controller: addressController,
                        label: 'Supplier Address'),
                    const SizedBox(
                      height: space,
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
                              'Create',
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
            ]),
          );
        });
  }
}

import 'package:bsims/const/textstyle.dart';
import 'package:bsims/screens/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

import '../const/colors.dart';

class Supplier extends StatefulWidget {
  final double screenWidth;
  const Supplier({super.key, required this.screenWidth});

  @override
  State<Supplier> createState() => _SupplierState();
}

class _SupplierState extends State<Supplier> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Suppliers Information',
              style: headline(black, widget.screenWidth * 0.013),
            ),
            SizedBox(
              width: widget.screenWidth * 0.5,
            ),
            InkWell(
              onTap: addStore,
              child: Container(
                width: 103,
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
                      'Add Supplier',
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
                      'S/N',
                      style: headline(black, 10),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '1',
                      style: bodyText(black, 10),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '2',
                      style: bodyText(black, 10),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'COMPANY',
                      style: headline(black, 10),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Supplier company',
                      style: bodyText(black, 10),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Supplier company',
                      style: bodyText(black, 10),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'REGDATE',
                      style: headline(black, 10),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Fri, Jun 2nd 2023',
                      style: bodyText(black, 10),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Fri, Jun 2nd 2023',
                      style: bodyText(black, 10),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'E-MAIL',
                      style: headline(black, 10),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'peat@gmail.com',
                      style: bodyText(black, 10),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'tim@gmail.com',
                      style: bodyText(black, 10),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PHONE',
                      style: headline(black, 10),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '090234566',
                      style: bodyText(white, 10),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '90909999',
                      style: bodyText(white, 10),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ADDRESS',
                      style: headline(black, 10),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Supplier Address',
                      style: bodyText(white, 10),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Supplier Address',
                      style: bodyText(white, 10),
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
                    SizedBox(height: 5),
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
                      height: 10,
                    ),
                    TextFieldWidget(
                        controller: nameController, label: 'Supplier Name'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        controller: companyController, label: 'Company Name'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        controller: emailController, label: 'E-mail'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        controller: phoneController, label: 'Supplier Phone'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        controller: addressController,
                        label: 'Supplier Address'),
                    const SizedBox(
                      height: 10,
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

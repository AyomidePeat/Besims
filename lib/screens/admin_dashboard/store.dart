import 'package:bsims/const/textstyle.dart';
import 'package:bsims/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

import '../../const/colors.dart';

class Store extends StatefulWidget {
  final double screenWidth;
  const Store({super.key, required this.screenWidth});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Stores',
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
                      'Add Store',
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
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NAME',
                      style: headline(black, 10),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'First store',
                      style: bodyText(black, 10),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Second store',
                      style: bodyText(black, 10),
                    ),
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LOCATION',
                      style: headline(black, 10),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Sample address',
                      style: bodyText(black, 10),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Second address',
                      style: bodyText(black, 10),
                    ),
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MANAGER',
                      style: headline(black, 10),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'John Doe',
                      style: bodyText(black, 10),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Alex Walker',
                      style: bodyText(black, 10),
                    ),
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PHONE',
                      style: headline(black, 10),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '11234567',
                      style: bodyText(black, 10),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '1234567',
                      style: bodyText(black, 10),
                    ),
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'STATUS',
                      style: headline(black, 10),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: green,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Open',
                        style: bodyText(white, 10),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: red, borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Closed',
                        style: bodyText(white, 10),
                      ),
                    ),
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ACTIONS',
                      style: headline(black, 10),
                    ),
                    const SizedBox(height:5),
                    Row(
                      children: [
                         InkWell(
                            onTap: () {},
                            child: Icon(Icons.edit_document,size: 15, color: green)),
                        const SizedBox(
                      width: 8,
                    ), InkWell(
                            onTap: () {},
                            child: Icon(Icons.delete_outlined,size: 15, color: red)),
                      ],
                    ),
                    const SizedBox(height:10),
                    Row(
                      children: [
                        InkWell(
                            onTap: () {},
                            child: Icon(Icons.edit_document, size: 15, color: green)),
                       const SizedBox(
                      width: 8,
                    ),   InkWell(
                            onTap: () {},
                            child: Icon(Icons.delete_outlined,size: 15, color: red)),
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
    final managerController = TextEditingController();
    final locationController = TextEditingController();
    final phoneController = TextEditingController();
    final statusOptions = ['Open', 'Closed'];
    String? status;
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
                        Text('Create User Account', style: headline(black, 20)),
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
                    TextFieldWidget(controller: nameController, label: 'Name'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        controller: managerController, label: 'Manager'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        controller: locationController, label: 'Location'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        controller: phoneController, label: 'Store Phone'),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      width: 700,
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

import 'package:bsims/const/textstyle.dart';
import 'package:bsims/firebase_repos/cloud_firestore.dart';
import 'package:bsims/screens/admin_dashboard/excel_downloader.dart';
import 'package:bsims/screens/admin_dashboard/excel_picker.dart';
import 'package:bsims/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../const/colors.dart';

class Store extends ConsumerStatefulWidget {
  final double screenWidth;
  const Store({super.key, required this.screenWidth});

  @override
  ConsumerState<Store> createState() => _StoreState();
}

class _StoreState extends ConsumerState<Store> {
  @override
  Widget build(BuildContext context) {
    final cloudStoreRef = ref.watch(cloudStoreProvider);
    final widgetSize = (widget.screenWidth - 293) / 10;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: widget.screenWidth - 293,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Stores',
                style: headline(black, widget.screenWidth * 0.013),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: addStore,
                    child: Container(
                      height: 35,
                      width: 90,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: purple),
                      child: Text('Add Store', style: bodyText(white, 10)),
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
                      child: Text('Download all', style: bodyText(black, 10)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Container(
          width: widget.screenWidth - 293,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: white),
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
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
                    'NAME',
                    style: headline(black, 10),
                  ),
                ),
                SizedBox(
                  width: widgetSize,
                  child: Text(
                    'LOCATION',
                    style: headline(black, 10),
                  ),
                ),
                SizedBox(
                  width: widgetSize,
                  child: Text(
                    'MANAGER',
                    style: headline(black, 10),
                  ),
                ),
                SizedBox(
                  width: widgetSize,
                  child: Text(
                    'PHONE',
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
                stream: cloudStoreRef.getStores(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
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
                              String name = stocks[index].name;
                              String location = stocks[index].location;
                              String manager = stocks[index].manager;
                              String phone = stocks[index].phone;
                              String status = stocks[index].status;

                              return ListTile(
                                contentPadding: const EdgeInsets.all(0),
                                title: productList(
                                  widget.screenWidth,
                                  sn: index + 1,
                                  name: name,
                                  status: status,
                                  manager: manager,
                                  location: location,
                                  phone: phone,
                                ),
                              );
                            }),
                      );
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                        child: Text('You have not added any store yet!',
                            style: bodyText(black, 15))),
                  );
                }),
            const SizedBox(
              height: 20,
            ),
          ]),
        )
      ],
    );
  }

  excelPicker() {
    importStoreFile(pickExcelFile());
  }

  excelDownloader() {
    exportStoreExcelFile();
  }

  Widget productList(
    screenWidth, {
    sn,
    name,
    location,
    manager,
    phone,
    status,
  }) {
    final widgetSize = (screenWidth - 293) / 10;
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
              name,
              style: bodyText(black, 13),
            ),
          ),
          SizedBox(
            width: widgetSize,
            child: Text(
              location,
              style: bodyText(black, 13),
            ),
          ),
          SizedBox(
            width: widgetSize,
            child: Text(
              manager,
              style: bodyText(black, 13),
            ),
          ),
          SizedBox(
            width: widgetSize,
            child: Text(
              phone,
              style: bodyText(black, 13),
            ),
          ),
          SizedBox(
            width: widgetSize,
            child: Text(
              status,
              style: bodyText(black, 13),
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
                    onTap: () async {
                      await firestore.deleteStore(name);
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

  void addStore() {
    FirestoreClass fireStore = FirestoreClass();
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
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('New Store', style: headline(black, 20)),
                    const SizedBox(
                      height: 40,
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
                    Center(
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
                            width: 110,
                            height: 40,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey)),
                            child: Center(
                                child: Text(
                              'Discard',
                              style: bodyText(Colors.black, 10),
                            )),
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () async {
                            final uploadSuccess = await fireStore.addStore(
                                name: nameController.text,
                                manager: managerController.text,
                                location: locationController.text,
                                phone: phoneController.text,
                                status: status!);

                            if (uploadSuccess == 'Added') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: purple,
                                      content: Text(
                                          uploadSuccess,
                                          textAlign: TextAlign.center,
                                          style:
                                              const TextStyle(fontSize: 16))));
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.purple,
                                      content: Text(
                                          uploadSuccess,
                                          textAlign: TextAlign.center,
                                          style:
                                              const TextStyle(fontSize: 16))));
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 110,
                                height: 40,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: purple),
                                child: Center(
                                    child: Text(
                                  'Add Store',
                                  style: bodyText(white, 10),
                                )),
                              ),
                            ],
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

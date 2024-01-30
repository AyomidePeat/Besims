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
  bool isLoading = false;
  Widget build(BuildContext context) {
    final cloudStoreRef = ref.watch(cloudStoreProvider);
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: widget.screenWidth - 293,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Manage Stores',
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
                      child: Center(
                          child: Text('Add Store', style: bodyText(white, 12))),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: excelPicker,
                    child: Container(
                      height: 35,
                      width: 90,
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 10),
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
                          Text('Import', style: bodyText(black, 12)),
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
                      child: Text('Download all', style: bodyText(black, 12)),
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
            StreamBuilder(
                stream: cloudStoreRef.getStores(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(color: purple);
                  } else {
                    final stores = snapshot.data!;
                    if (stores.isNotEmpty) {
                      return SizedBox(
                        width: widget.screenWidth - 280,
                        height: size.height - 320,
                        child: ListView.builder(
                            itemCount: stores.length,
                            itemBuilder: (context, index) {
                              String name = stores[index].name;
                              String location = stores[index].location;
                              String manager = stores[index].manager;
                              String phone = stores[index].phone;
                              String status = stores[index].status;

                              return ListTile(
                                contentPadding: const EdgeInsets.all(0),
                                title: productList(
                                  widget.screenWidth,
                                  sn: index + 1,
                                  name: name,
                                  status: status,
                                  manager: manager,
                                  location: location,
                                  phone: phone,isLoading: isLoading
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
                            style: bodyText(black, 16))),
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

  Widget productList(screenWidth,
      {sn, name, location, manager, phone, status, isLoading}) {
    final firestore = FirestoreClass();

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFF0F1F3), width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                height: 150,
                width: 290,
                decoration: BoxDecoration(
                    color: const Color(0xFFF0F1F3),
                    borderRadius: BorderRadius.circular(6)),
                child: Center(
                  child: Text(
                    '$name Branch',
                    style: headline(black, 16),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      'Managed by $location',
                      style: headline(black, 16),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      manager,
                      style: bodyText(black, 14),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      phone,
                      style: bodyText(black, 14),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      status,
                      style: bodyText(black, 14),
                    ),
                  ),
                  const Divider()
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                InkWell(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      FirestoreClass fireStore = FirestoreClass();
                      final nameController = TextEditingController();
                      final managerController = TextEditingController();
                      final locationController = TextEditingController();
                      final phoneController = TextEditingController();
                      final statusOptions = ['Open', 'Closed'];
                      String? status;
                      final storeDetails =
                          await firestore.getStoreDetails(name);
                      nameController.text = storeDetails['name'] as String;
                      managerController.text =
                          storeDetails['manager'] as String;
                      locationController.text =
                          storeDetails['location'] as String;
                      phoneController.text = storeDetails['phone'] as String;
                      status = storeDetails['status'] as String?;
                      editDialog(
                          nameController,
                          managerController,
                          locationController,
                          phoneController,
                          status,
                          statusOptions,
                          fireStore,
                          name);
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : Icon(Icons.edit, size: 20, color: purple)),
                const SizedBox(
                  width: 15,
                ),
                InkWell(
                    onTap: () async {
                      await firestore.deleteStore(name);
                    },
                    child: Icon(Icons.delete_outlined, size: 20, color: red)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> editDialog(
      TextEditingController nameController,
      TextEditingController managerController,
      TextEditingController locationController,
      TextEditingController phoneController,
      String? status,
      List<String> statusOptions,
      FirestoreClass fireStore,
      name) {
    return showDialog(
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
                    Text('Edit Store', style: headline(black, 20)),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFieldWidget(controller: nameController, label: 'Name'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        controller: managerController, label: 'Location'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        controller: locationController, label: 'Manager'),
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
                              style: bodyText(Colors.black, 14),
                            )),
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () async {
                            final updateSuccess = await fireStore.updateStore(
                              originalName: name,
                              newName: nameController.text,
                              manager: managerController.text,
                              location: locationController.text,
                              phone: phoneController.text,
                              status: status!,
                            );

                            if (updateSuccess == 'Updated') {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: purple,
                                content: Text(
                                  updateSuccess,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ));
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  updateSuccess,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ));
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
                                  'Update Store',
                                  style: bodyText(white, 14),
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
                              style: bodyText(Colors.black, 14),
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
                                  style: bodyText(white, 14),
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

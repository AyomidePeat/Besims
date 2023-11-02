import 'package:bsims/const/textstyle.dart';
import 'package:bsims/firebase_repos/cloud_firestore.dart';
import 'package:bsims/screens/admin_dashboard/excel_downloader.dart';
import 'package:bsims/screens/admin_dashboard/excel_picker.dart';
import 'package:bsims/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../const/colors.dart';

class Supplier extends ConsumerStatefulWidget {
  final double screenWidth;
  const Supplier({super.key, required this.screenWidth});

  @override
  ConsumerState<Supplier> createState() => _SupplierState();
}

class _SupplierState extends ConsumerState<Supplier> {
  @override
  Widget build(BuildContext context) {
    final cloudStoreRef = ref.watch(cloudStoreProvider);
    final widgetSize = (widget.screenWidth - 293) / 12;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: widget.screenWidth - 293,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Suppliers', style: headline(black, 17)),
              Row(
                children: [
                  InkWell(
                    onTap: addSupplier,
                    child: Container(
                      height: 35,
                      width: 90,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: purple),
                      child: Text('Add Supplier', style: bodyText(white, 10)),
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
                    'COMPANY',
                    style: headline(black, 10),
                  ),
                ),
                SizedBox(
                  width: widgetSize,
                  child: Text(
                    'REG DATE',
                    style: headline(black, 10),
                  ),
                ),
                SizedBox(
                  width: widgetSize,
                  child: Text(
                    'E-MAIL',
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
                    'ADDRESS',
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
                stream: cloudStoreRef.getSuppliers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(color: purple);
                  } else {
                    final suppliers = snapshot.data!;
                    if (suppliers.isNotEmpty) {
                      return SizedBox(
                        width: widget.screenWidth - 280,
                        height: 446,
                        child: ListView.builder(
                            itemCount: suppliers.length,
                            itemBuilder: (context, index) {
                              String name = suppliers[index].name;
                              String address = suppliers[index].address;
                              String regDate = suppliers[index].date;
                              String email = suppliers[index].email;
                              String phone = suppliers[index].phone;
                              String company = suppliers[index].company;

                              return ListTile(
                                contentPadding: const EdgeInsets.all(0),
                                title: productList(
                                  widget.screenWidth,
                                  sn: index + 1,
                                  name: name,
                                  address: address,
                                  company: company,
                                  email: email,
                                  phone: phone,
                                  regDate: regDate,
                                ),
                              );
                            }),
                      );
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                        child: Text('You have not added supplier yet!',
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

  void addSupplier() {
    final nameController = TextEditingController();
    final companyController = TextEditingController();
    final addressController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    FirestoreClass fireStore = FirestoreClass();
    final now = DateTime.now();
    String regDate = DateFormat('dd-MMMM-yyyy').format(now);
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
                    Text('New Supplier', style: headline(black, 20)),
                    const SizedBox(
                      height: 40,
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
                            final uploadSuccess = await fireStore.addSupplier(
                                name: nameController.text,
                                company: companyController.text,
                                address: addressController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                date: regDate);
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
                                      backgroundColor: purple,
                                      content: const Text('An error occured',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 16))));
                            }
                          },
                          child: Container(
                            width: 110,
                            height: 40,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: purple),
                            child: Center(
                                child: Text(
                              'Add Supplier',
                              style: bodyText(white, 10),
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

  excelPicker() {
    importSupplierFile(pickExcelFile());
  }

  excelDownloader() {
    exportSupplierExcelFile();
  }

  Widget productList(
    screenWidth, {
    sn,
    company,
    regDate,
    email,
    phone,
    address,
    name,
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
              company,
              style: bodyText(black, 13),
            ),
          ),
          SizedBox(
            width: widgetSize,
            child: Text(
              regDate,
              style: bodyText(black, 13),
            ),
          ),
          SizedBox(
            width: widgetSize,
            child: Text(
              email,
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
              address,
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
                      await firestore.deleteSupplier(name);
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
}

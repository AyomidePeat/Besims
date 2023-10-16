import 'package:bsims/const/textstyle.dart';
import 'package:bsims/firebase_repos/cloud_firestore.dart';
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
    const double space = 30;
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
        StreamBuilder(
            stream: cloudStoreRef.getStores(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(color: Colors.green));
              } else {
                final stores = snapshot.data!;
                if (stores.isNotEmpty) {
                  for (int index = 0; index <= 0 && index <= stores.length;) {
                    
                    String storeName = stores[index].name;
                    String location = stores[index].location;
                    String manager = stores[index].manager;
                    String phone = stores[index].phone;
                    String status = stores[index].status;

                    return Container(
                      width: widget.screenWidth - 293,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5), color: white),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
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
                                    SizedBox(
                                      height: 300,
                                      width: 70,
                                      child: ListView.builder(
                                          itemCount: stores.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 25),
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
                                      'NAME',
                                      style: headline(black, 10),
                                    ),
                                    const SizedBox(
                                      height: space,
                                    ),
                                    SizedBox(
                                      height: 300,
                                      width: 70,
                                      child: ListView.builder(
                                          itemCount: stores.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 25),
                                              child: Text(
                                                storeName,
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
                                      'LOCATION',
                                      style: headline(black, 10),
                                    ),
                                    const SizedBox(
                                      height: space,
                                    ),
                                    SizedBox(
                                      height: 300,
                                      width: 70,
                                      child: ListView.builder(
                                          itemCount: stores.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 25),
                                              child: Text(
                                                location,
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
                                      'MANAGER',
                                      style: headline(black, 10),
                                    ),
                                    const SizedBox(
                                      height: space,
                                    ),
                                    SizedBox(
                                      height: 300,
                                      width: 70,
                                      child: ListView.builder(
                                          itemCount: stores.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 25),
                                              child: Text(
                                                manager,
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
                                      'PHONE',
                                      style: headline(black, 10),
                                    ),
                                    const SizedBox(
                                      height: space,
                                    ),
                                    SizedBox(
                                      height: 300,
                                      width: 70,
                                      child: ListView.builder(
                                          itemCount: stores.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 25),
                                              child: Text(
                                                phone,
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
                                      'STATUS',
                                      style: headline(black, 10),
                                    ),
                                    const SizedBox(
                                      height: space,
                                    ),
                                    SizedBox(
                                      height: 300,
                                      width: 70,
                                      child: ListView.builder(
                                          itemCount: stores.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: status == 'Closed'
                                                        ? red
                                                        : green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Center(
                                                  child: Text(
                                                    status,
                                                    style: bodyText(white, 10),
                                                  ),
                                                ),
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
                                    const SizedBox(height: space),
                                    SizedBox(
                                      height: 300,
                                      width: 50,
                                      child: ListView.builder(
                                          itemCount: stores.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 25),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                      onTap: () {},
                                                      child: Icon(
                                                          Icons.edit_document,
                                                          size: 15,
                                                          color: green)),
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
                            const SizedBox(
                              height: 20,
                            ),
                          ]),
                    );
                  }
                }
                return Container(
                    width: widget.screenWidth - 293,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5), color: white),
                    child: const Center(
                        child: Text('You have not added any store yet')));
              }
            })
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
                                      backgroundColor: Colors.green,
                                      content: Text(
                                          uploadSuccess,
                                          textAlign: TextAlign.center,
                                          style:
                                              const TextStyle(fontSize: 16))));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(
                                          uploadSuccess,
                                          textAlign: TextAlign.center,
                                          style:
                                              const TextStyle(fontSize: 16))));
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

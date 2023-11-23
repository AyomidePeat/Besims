import 'package:bsims/const/textstyle.dart';
import 'package:bsims/firebase_repos/cloud_firestore.dart';
import 'package:bsims/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../const/colors.dart';

class ProductCategoryList extends ConsumerStatefulWidget {
  final double screenWidth;
  const ProductCategoryList({super.key, required this.screenWidth});

  @override
  ConsumerState<ProductCategoryList> createState() =>
      _ProductCategoryListState();
}

class _ProductCategoryListState extends ConsumerState<ProductCategoryList> {
  @override
  Widget build(BuildContext context) {
    const double space = 30;
    final cloudStoreRef = ref.watch(cloudStoreProvider);
    final widgetSize = (widget.screenWidth - 293) / 10;
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
                'Categories',
                style: headline(black, widget.screenWidth * 0.013),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: addCategory,
                    child: Container(
                      height: 35,
                      width: 100,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: purple),
                      child: Center(
                          child:
                              Text('Add Category', style: bodyText(white, 10))),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // InkWell(
                  //   onTap: excelPicker,
                  //   child: Container(
                  //     height: 35,
                  //     width: 90,
                  //     padding: const EdgeInsets.all(10),
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(5),
                  //         border: Border.all(color: Colors.grey[400]!)),
                  //     child: Row(
                  //       children: [
                  //         const Icon(
                  //           Icons.downloading_rounded,
                  //           size: 15,
                  //         ),
                  //         const SizedBox(width: 5),
                  //         Text('Import', style: bodyText(black, 10)),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(width: 8),
                  // InkWell(
                  //   onTap: excelDownloader,
                  //   child: Container(
                  //     height: 35,
                  //     width: 90,
                  //     padding: const EdgeInsets.all(10),
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(5),
                  //         border: Border.all(color: Colors.grey[400]!)),
                  //     child: Text('Download all', style: bodyText(black, 10)),
                  //   ),
                  // ),
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
                    'CATEGORY NAME',
                    style: headline(black, 10),
                  ),
                ),
                SizedBox(
                  width: widgetSize,
                  child: Text(
                    'CREATED ON',
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
                stream: cloudStoreRef.getCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(color: purple);
                  } else {
                    final categories = snapshot.data!;
                    if (categories.isNotEmpty) {
                      return SizedBox(
                        width: widget.screenWidth - 280,
                        height: size.height - 320,
                        child: ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                                  final now = DateTime.now();

                              String name = categories[index].categoryName;
                              final dateAdded = categories[index].dateCreated;
                              String date =
                                  DateFormat('dd/mm/yyyy').format(now);

                              return ListTile(
                                contentPadding: const EdgeInsets.all(0),
                                title: categoryList(widget.screenWidth,
                                    sn: index + 1,
                                    name: name,
                                    dateCreated: date),
                              );
                            }),
                      );
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                        child: Text('You have not added any category yet!',
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

  void addCategory() {
    final nameController = TextEditingController();
    FirestoreClass fireStore = FirestoreClass();

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
                        Text('Add Category', style: headline(black, 20)),
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
                        controller: nameController, label: 'Category name'),
                    const SizedBox(
                      height: space,
                    ),
                    const SizedBox(
                      height:30,
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
                                color:  Colors.grey,),
                            child: Center(
                                child: Text(
                              'Discard',
                              style: bodyText(white, 13),
                            )),
                          ),
                        ), const SizedBox(width: 8),
                         InkWell(
                          onTap: () async {
                            final uploadSuccess = await fireStore.addCategory(
                              categoryName: nameController.text,
                            );
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
                                          style:bodyText(black, 13),)));
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
                                child: Text(
                              'Create',
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

  Widget categoryList(screenWidth, {sn, name, dateCreated}) {
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
              dateCreated,
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
                      await firestore.deleteCategory(name);
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

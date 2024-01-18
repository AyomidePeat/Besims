import 'dart:typed_data';

import 'package:bsims/const/textstyle.dart';
import 'package:bsims/firebase_repos/cloud_firestore.dart';
import 'package:bsims/widgets/textfield_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../const/colors.dart';

class Users extends ConsumerStatefulWidget {
  final double screenWidth;
  const Users({super.key, required this.screenWidth});

  @override
  ConsumerState<Users> createState() => _UsersState();
}

class _UsersState extends ConsumerState<Users> {
  double space = 30;

  @override
  Widget build(BuildContext context) {
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
                'User Information',
                style: headline(black, widget.screenWidth * 0.013),
              ),
              InkWell(
                onTap: addUser,
                child: Container(
                  width: 100,
                  height: 35,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: purple),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_circle_sharp,
                        size: 20,
                        color: white,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Add User',
                        style: bodyText(white, 10),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
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
                SizedBox(
                  width: widgetSize,
                  child: Text(
                    '',
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
                    'USERNAME',
                    style: headline(black, 10),
                  ),
                ),
                SizedBox(
                  width: widgetSize,
                  child: Text(
                    'EMAIL',
                    style: headline(black, 10),
                  ),
                ),
                SizedBox(
                  width: widgetSize,
                  child: Text(
                    'ROLE',
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
                stream: cloudStoreRef.getUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(color: purple);
                  } else {
                    final users = snapshot.data!;
                    if (users.isNotEmpty) {
                      return SizedBox(
                        width: widget.screenWidth - 280,
                        height: size.height - 320,
                        child: ListView.builder(
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              final now = DateTime.now();
                              final user = users[index];
                              String name = user.name;
                              String image = user.image;
                              String username = user.username;
                              String email = user.email;
                              String phoneNumber = user.phoneNumber;
                              String role = user.role;

                              String date =
                                  DateFormat('dd/mm/yyyy').format(now);

                              return ListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  title: userList(
                                    widget.screenWidth,
                                    email: email,
                                    image: image,
                                    name: name,
                                    phoneNumber: phoneNumber,
                                    role: role,
                                    username: username,
                                  ));
                            }),
                      );
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                        child: Text('You have not added any user yet!',
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

  void addUser() {
    final fullNameController = TextEditingController();
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final roleOptions = ['Admin', 'Cashier'];
    String? role;
    Uint8List? _imageBytes;

    Future<void> _pickImage() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _imageBytes = result.files[0].bytes!;
        });
      }
      print('image uploaded');
    }

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
                      Text('Create User Account', style: headline(black, 20)),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.cancel_outlined))
                    ],
                  ),
                  GestureDetector(
                    onTap: () async{
                   await   _pickImage();
 
    if (_imageBytes != null) {
      setState(() {
         print("Image Bytes Length: ${_imageBytes!.length}");
      });
     
    }                    },
                    child: Center(
                      child: CircleAvatar(
                        radius: 80,
                        // backgroundColor: const Color.fromRGBO(224, 224, 224, 1),
                        backgroundImage: _imageBytes != null
                            ? MemoryImage(_imageBytes!)
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                      controller: fullNameController, label: 'Full Name'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                      controller: usernameController, label: 'Username'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(controller: emailController, label: 'E-mail'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                      controller: passwordController, label: 'Password'),
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
                          hint: const Text('Choose User Role'),
                          value: role,
                          onChanged: (value) {
                            setState(() {
                              role = value as String;
                            });
                          },
                          items: roleOptions
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.toString()),
                                  ))
                              .toList(),
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
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
                              color: red),
                          child: Center(
                              child: Text(
                            'Cancel',
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

  Widget userList(screenWidth,
      {image, name, username, email, role, phoneNumber}) {
    final widgetSize = (screenWidth - 293) / 10;
    final firestore = FirestoreClass();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            width: widgetSize,
            child: CircleAvatar(child: image),
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
              username,
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
              phoneNumber,
              style: bodyText(black, 13),
            ),
          ),
          SizedBox(
            width: widgetSize,
            child: Text(
              role,
              style: bodyText(role == 'Admin' ? purple! : blue, 13),
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

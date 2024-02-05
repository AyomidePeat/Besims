import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:bsims/const/textstyle.dart';
import 'package:bsims/firebase_repos/authentication.dart';
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
          width: size.width <1000? widget.screenWidth - 270 :widget.screenWidth - 293,
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
                      padding: const EdgeInsets.symmetric(horizontal:10,vertical: 7),
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
                        style: bodyText(white, 12),
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
          width:size.width <1000? widget.screenWidth - 270 : widget.screenWidth - 293,
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
                ),
                SizedBox(
                  width: widgetSize,
                  child: Text(
                    'NAME',
                    style: headline(black,size.width <1000? 12 : 14),
                  ),
                ),
                SizedBox(
                  width: widgetSize,
                  child: Text(
                    'USERNAME',
                    style: headline(black,size.width <1000? 12 : 14),
                  ),
                ),
                SizedBox(
                  width: widgetSize,
                  child: Text(
                    'EMAIL',
                    style: headline(black,size.width <1000? 12 : 14),
                  ),
                ),
                SizedBox(
                  width: widgetSize,
                  child: Text(
                    'PHONE NO.',
                    style: headline(black,size.width <1000? 12 : 14),
                  ),
                ),
                SizedBox(
                  width: widgetSize,
                  child: Text(
                    'ROLE',
                    style: headline(black,size.width <1000? 12 : 14),
                  ),
                ),
                SizedBox(
                  width: widgetSize,
                  child: Text(
                    'ACTIONS',
                    style: headline(black,size.width <1000? 11 : 14),
                  ),
                ),
              ],
            ),
            const Divider(),
            StreamBuilder(
                stream: cloudStoreRef.getUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: SizedBox(height:10, width: 10, child: CircularProgressIndicator(color: purple)));
                  } else {
                    final users = snapshot.data!;
                    if (users.isNotEmpty) {
                      return SizedBox(
                        width: size.width <1000? widget.screenWidth - 270 :widget.screenWidth - 280,
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

  void addUser() {
    final fullNameController = TextEditingController();
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final phoneNumberController = TextEditingController();
    final roleOptions = ['Admin', 'Cashier'];
    final genderOptions = ['Male', 'Female'];
    String? gender;
    String? role;
    AuthenticationMethod auth = AuthenticationMethod();
    Uint8List? imageBytes;
    String fileName = '';
    Future<void> pickImage() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          imageBytes = result.files.first.bytes!;
          fileName = result.files.first.name;
        });
      }
    }

    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return SimpleDialog(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
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
                      onTap: () async {
                        await pickImage();

                        // Update the UI when the image is picked
                        if (imageBytes != null) {
                          setState(() {
                            // No need to create a temporary file, directly use imageBytes
                          });
                        }
                      },
                      child: Center(
                        child: KeyedImage(
                          filename: fileName,
                          key: ValueKey<int>(imageBytes?.length ?? 0),
                          imageBytes: imageBytes,
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
                        controller: emailController, label: 'E-mail'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        controller: phoneNumberController,
                        label: 'Phone Number'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        controller: usernameController, label: 'Username'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        isObscure: true,
                        controller: passwordController,
                        label: 'Password'),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 200,
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
                        Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: DropdownButtonFormField(
                                hint: const Text('Gender'),
                                value: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value as String;
                                  });
                                },
                                items: genderOptions
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
                      ],
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
                            final uploadSuccess = await auth.signUp(
                                email: emailController.text,
                                password: passwordController.text,
                                gender: gender!,
                                username: usernameController.text,
                                role: role!,
                                pickedImage: imageBytes!,
                                phoneNumber: phoneNumberController.text,
                                name: fullNameController.text);
                            if (uploadSuccess == 'Success') {
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
                                      content: Text(
                                          uploadSuccess,
                                          textAlign: TextAlign.center,
                                          style:
                                              const TextStyle(fontSize: 16))));
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
                              'Add User',
                              style: bodyText(white, 14),
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
        });
  }

  Widget userList(screenWidth,
      {image, name, username, email, role, phoneNumber}) {
    Uint8List? downloadedUint8List;

    Future<Uint8List?> fetchImageFromUrl(String url) async {
      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          return response.bodyBytes;
        } else {
          return null;
        }
      } catch (error) {
        return null;
      }
    }

    final widgetSize = (screenWidth - 293) / 10;
    final firestore = FirestoreClass();

    return FutureBuilder<Uint8List?>(
        future: fetchImageFromUrl(image),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Text('Failed to load image');
          } else {
            downloadedUint8List = snapshot.data;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: widgetSize,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: MemoryImage(downloadedUint8List!),
                                  fit: BoxFit.contain)),
                        ),
                      ),
                      SizedBox(
                        width: widgetSize,
                        child: Text(
                          name,
                    style: bodyText(black,widget.screenWidth <1000? 12 : 14),
                        ),
                      ),
                      SizedBox(
                        width: widgetSize,
                        child: Text(
                          username,
                    style: bodyText(black,widget.screenWidth <1000? 12 : 14),
                        ),
                      ),
                      SizedBox(
                        width: widgetSize,
                        child: Text(
                          email,
                    style: bodyText(black,widget.screenWidth <1000? 12 : 14),
                        ),
                      ),
                      SizedBox(
                        width: widgetSize,
                        child: Text(
                          phoneNumber,
                    style: bodyText(black,widget.screenWidth <1000? 12 : 14),
                        ),
                      ),
                      SizedBox(
                        width: widgetSize,
                        child: Text(
                          role,
                          style: headline(
                              role == 'Admin' ? purple! : blue, widget.screenWidth <1000? 12 : 14),
                        ),
                      ),
                      SizedBox(
                        width: widgetSize,
                        child: Row(
                          children: [
                            InkWell(
                                onTap: () {},
                                child:
                                    Icon(Icons.edit, size: 15, color: purple)),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                                onTap: () async {
                                  await firestore.deleteCategory(name);
                                },
                                child: Icon(Icons.delete_outlined,
                                    size: 15, color: red)),
                          ],
                        ),
                      ),
                    ]),
                const Divider()
              ],
            );
          }
        });
  }
}

class KeyedImage extends StatelessWidget {
  final Uint8List? imageBytes;
  final String filename;
  const KeyedImage({Key? key, required this.imageBytes, required this.filename})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 160,
          height: 160,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(224, 224, 224, 1),
          ),
          child: imageBytes != null
              ? ClipOval(
                  child: Image.memory(
                    imageBytes!,
                    fit: BoxFit.cover,
                    width: 160,
                    height: 160,
                  ),
                )
              : const Icon(Icons.add_a_photo, size: 40),
        ),
        Text(filename)
      ],
    );
  }
}

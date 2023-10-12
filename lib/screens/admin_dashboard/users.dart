import 'package:bsims/const/textstyle.dart';
import 'package:bsims/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

import '../../const/colors.dart';

class Users extends StatefulWidget {
  final double screenWidth;
  const Users({super.key, required this.screenWidth});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  double space = 30;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'User Information',
              style: headline(black, widget.screenWidth * 0.013),
            ),
            SizedBox(
              width: widget.screenWidth * 0.5,
            ),
            InkWell(
              onTap: addUser,
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
                      size: 20,
                      color: white,
                    ),
                    const SizedBox(width: 5),
                    const Text('Add user')
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
                      'S/N',
                      style: headline(black, 10),
                    ),
                      SizedBox(
                    height: space,
                  ),
                    Text(
                      '1',
                      style: headline(black, 10),
                    ),SizedBox(
                    height: space,
                  ),
                    Text(
                      '2',
                      style: headline(black, 10),
                    ),SizedBox(
                    height: space,
                  ),
                    Text(
                      '3',
                      style: headline(black, 10),
                    ),
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NAME',
                      style: headline(black, 10),
                    ),
                    SizedBox(
                    height: space,
                  ),
                    Text(
                      'Peace',
                      style: bodyText(black, 10),
                    ),
                    SizedBox(
                    height: space,
                  ),
                    Text(
                      'Peat',
                      style: bodyText(black, 10),
                    ),
                    SizedBox(
                    height: space,
                  ),
                    Text(
                      'Timothy',
                      style: bodyText(black, 10),
                    ),
                    
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'USERNAME',
                      style: headline(black, 10),
                    ),
                    SizedBox(
                    height: space,
                  ),
                    Text(
                      'UnclePeace',
                      style: bodyText(black, 10),
                    ),SizedBox(
                    height: space,
                  ),
                    Text(
                      'AyomidePeat',
                      style: bodyText(black, 10),
                    ),SizedBox(
                    height: space,
                  ),
                    Text(
                      'Timm',
                      style: bodyText(black, 10),
                    ),
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'E-MAIL',
                      style: headline(black, 10),
                    ),SizedBox(
                    height: space,
                  ),
                    Text(
                      'peace@gmail.com',
                      style: bodyText(black, 10),
                    ),SizedBox(
                    height: space,
                  ),
                    Text(
                      'tim@gmail.com',
                      style: bodyText(black, 10),
                    ),SizedBox(
                    height: space,
                  ),
                    Text(
                      'ayo@gmail.com',
                      style: bodyText(black, 10),
                    ),
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ROLE',
                      style: headline(black, 10),
                    ),const SizedBox(
                    height: 15,
                  ),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: green, borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Admin',
                        style: bodyText(white, 10),
                      ),
                    ),
                    const SizedBox(
                    height: 30,
                  ),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: yellow,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Cashier',
                        style: bodyText(white, 10),
                      ),
                    ),const SizedBox(
                    height: 30,
                  ),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: yellow,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Cashier',
                        style: bodyText(white, 10),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ACTIONS',
                        style: headline(black, 10),
                      ),
                      const SizedBox(
                      height: 15,
                    ),
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
                     SizedBox(
                      height: space,
                    ),
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
                     SizedBox(
                      height: space,
                    ),
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
                      const SizedBox(height: 10),
                    ],
                  ),
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

  void addUser() {
    final fullNameController = TextEditingController();
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final roleOptions = ['Admin', 'Cashier'];
    String? role;
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
}

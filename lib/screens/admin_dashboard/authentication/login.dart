import 'package:bsims/const/textstyle.dart';
import 'package:bsims/screens/admin_dashboard/dashboard.dart';
import 'package:bsims/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

import '../../../const/colors.dart';
import '../home.dart';
import '../../../widgets/main_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailAddressController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: [
          SizedBox(width: size.width * 0.5),
          Padding(
            padding: const EdgeInsets.only(top: 250.0),
            child: Container(
              width: 400,
              height: 380,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: const Offset(
                        0, 3), // changes the position of the shadow
                  ),
                ],
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextFieldWidget(
                        controller: emailAddressController,
                        label: 'Email Address'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                        controller: passwordController, label: 'Password'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Show password',
                          style: TextStyle(color: Colors.green),
                        )),
                    CustomMainButton(
                        width: 400,
                        height: 50,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()));
                        },
                        color: Colors.black,
                        child: Text(
                          'Sign in',
                          style: headline(white, 14),
                        ))
                  ]),
            ),
          )
        ],
      ),
    );
  }
}

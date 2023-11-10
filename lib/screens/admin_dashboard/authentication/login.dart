import 'package:bsims/const/textstyle.dart';
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

  bool isObscure = true;
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
              height: 500,
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
                    Text('Login', style: headline(black, 17)),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Be seamless! Get rid of the stress that comes with manual bookkeeping',
                      style:TextStyle(
                                 
                                  fontSize: 10, letterSpacing: 1,
                                  fontWeight: FontWeight.bold),
                    ),
                    
                    
                    const SizedBox(
                      height: 30,
                    ),
                    TextFieldWidget(
                        controller: emailAddressController,
                        label: 'Email Address'),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldWidget(
                        isObscure: isObscure,
                        controller: passwordController,
                        label: 'Password'),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        child: Text(
                          isObscure ? 'Show password' : 'Hide password',
                          style: TextStyle(color: black, fontSize: 10),
                        )),
                    const SizedBox(
                      height: 35,
                    ),
                    CustomMainButton(
                        width: 400,
                        height: 50,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Home()));
                        },
                        color: purple!,
                        child: Text(
                          'Login',
                          style: headline(white, 10),
                        )),
                        const SizedBox(
                      height: 8,
                    ),
                        
                        Row(
                                            children: [
                                              SizedBox(width:64),
                        Text('Don\'t have an account?',
                            style: bodyText(Colors.grey, 12)),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ))
                                            ],
                                          ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:bsims/const/textstyle.dart';
import 'package:bsims/screens/authentication/login.dart';
import 'package:bsims/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';

import '../../const/colors.dart';
import '../admin_dashboard/home.dart';
import '../../widgets/main_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
      backgroundColor: const Color.fromARGB(255, 226, 222, 235),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 100),
          width: size.width * 0.7,
          height: size.height * 0.8,
          decoration: BoxDecoration(
              color: white,
              boxShadow: [
                const BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    offset: Offset.zero,
                    spreadRadius: 0)
              ],
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 50, right: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 35),
                      Row(
                        children: [
                          Text('BeSeamless', style: headline(purple!, 25)),
                          Icon(
                            Icons.show_chart_sharp,
                            color: Colors.purple[900],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFieldWidget(
                          controller: emailAddressController, label: 'Name'),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWidget(
                          controller: emailAddressController,
                          label: 'Business Name'),
                      const SizedBox(
                        height: 20,
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
                            style: TextStyle(color: black, fontSize: 12),
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
                            'Sign Up',
                            style: headline(white, 14),
                          )),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const SizedBox(width: 64),
                          Text('Already have an account?',
                              style: bodyText(Colors.grey, 14)),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              )),

                        ],
                      ),
                                            const SizedBox(height: 20),

                    ]),
              ),
              Container(
                width: (size.width * 0.7) / 2,
                height: size.height * 0.8,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 80, 72, 147),
                  //     image: DecorationImage(
                  //   image: AssetImage('assets/bgg.jpg'),
                  //   fit: BoxFit.contain,
                  // )
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome back to BeSeamless!',
                          style: TextStyle(
                              color: white,
                              fontSize: 30,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.show_chart_sharp,
                          color: Colors.purple[900],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Text(
                      'Get rid of the stress that comes\n with manual bookkeeping',
                      style: TextStyle(
                        color: white,
                        fontSize: 13,
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(height: 550, child: Image.asset('assets/bgg.png')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

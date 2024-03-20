import 'package:bsims/const/textstyle.dart';
import 'package:bsims/screens/authentication/signup.dart';
import 'package:bsims/screens/cashier_dashboard/cashier_home.dart';
import 'package:bsims/widgets/textfield_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bsims/firebase_repos/authentication.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../const/colors.dart';
import '../admin_dashboard/home.dart';
import '../../widgets/main_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  bool isLoading = false;
  bool isObscure = true;
  bool emptyField = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final containerWidth = size.width * 0.7;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 222, 235),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 0),
          width: containerWidth,
          height: size.height * 0.8,
          decoration: BoxDecoration(
              color: white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                    offset: Offset.zero,
                    spreadRadius: 0)
              ],
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: containerWidth / 2,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 30.0,
                    left: 50,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.width * 0.008),
                        Row(
                          children: [
                            Text('BeSeamless',
                                style: headline(
                                    purple!, size.width < 1000 ? 15 : 25)),
                            Icon(
                              Icons.show_chart_sharp,
                              color: Colors.purple[900],
                            ),
                          ],
                        ),
                        SizedBox(
                              height:size.height<500?20:size.height < 700 && size.height > 500 ?30: 50,
                        ),
                        TextFieldWidget(
                            controller: emailAddressController,
                            label: 'Email Address'),
                        SizedBox(
                              height:size.height<500?20:size.height < 700 && size.height > 500 ?30: 50,
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
                        SizedBox(
                          height: size.width < 1500 ? 15 : 20,
                        ),
                        if (emptyField)
                          Text('Please fill all fields',
                              style: bodyText(red, 13)),
                        SizedBox(
                          height: size.width < 1500 ? 20 : 30,
                        ),
                        if (!kIsWeb)
                          CustomMainButton(
                              width: size.width < 1500 ? 200 : 400,
                              height:size.height<500?20:size.height < 700 && size.height > 500 ?30: 50,

                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Home()));
                              },
                              color: purple!,
                              child: isLoading
                                  ? LoadingAnimationWidget.beat(
                                      color: white, size: 20)
                                  : Text(
                                      'Login',
                                      style: headline(
                                          white, size.width < 1500 ? 12 : 14),
                                    )),
                        if (kIsWeb)
                          CustomMainButton(
                              width: size.width < 1500 ? 300 : 400,
                              height: 50,
                              onPressed: () async {
                                AuthenticationMethod auth =
                                    AuthenticationMethod();

                                if (emailAddressController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty) {
                                  setState(() {
                                    emptyField = false;
                                    isLoading = true;
                                  });
                                  final message = await auth.signIn(
                                      email: emailAddressController.text,
                                      password: passwordController.text);
                                  if (message == "Success") {
                                    DocumentSnapshot snapshot =
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .get();
                                    Map<String, dynamic> data =
                                        snapshot.data() as Map<String, dynamic>;
                                    String role = data['role'] ?? '';
                                    setState(() {
                                      isLoading = false;
                                    });
                                    if (role == 'Cashier') {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CashierHome()));
                                    } else {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Home()));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(message,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 16))));

                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                } else {
                                  setState(() {
                                    emptyField = true;
                                  });
                                }
                              },
                              color: purple!,
                              child: isLoading
                                  ? LoadingAnimationWidget.hexagonDots(
                                      color: white, size: 20)
                                  : Text(
                                      'Login',
                                      style: headline(
                                          white, size.width < 1500 ? 12 : 14),
                                    )),
                        SizedBox(height: size.width < 1500 ? 15 : 30),
                        Row(
                          children: [
                            SizedBox(width: size.width < 1500 ? 40 : 64),
                            Text('Don\'t have an account?',
                                style: bodyText(
                                    Colors.grey, size.width < 1500 ? 12 : 14)),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpPage()));
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: size.width < 1500 ? 10 : 12,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                      ]),
                ),
              ),
              Container(
                width: containerWidth / 2,
                height: size.height * 0.8,
                padding: EdgeInsets.only(left: 20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 80, 72, 147),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.width < 1500 ? 30 : 50,
                    ),
                    Text(
                      'Welcome back to BeSeamless!',
                      style: TextStyle(
                          color: white,
                          fontSize: size.width < 1500 ? 15 : 30,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      'Get rid of the stress that comes\n with manual bookkeeping',
                      style: TextStyle(
                        color: white,
                        fontSize: size.width < 1500 ? 10 : 13,
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                        height:size.height<500? 200: size.height < 700 && size.height > 500 ? 300 : 400,
                        child: Image.asset('assets/bgg.png')),
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

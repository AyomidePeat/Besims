import 'package:bsims/screens/admin_dashboard/home.dart';
import 'package:bsims/screens/cashier_dashboard/cashier_home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bsims/screens/authentication/login.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BeSeamless',
      theme: FlexThemeData.light(
          scheme: FlexScheme.deepPurple, fontFamily: 'Kanit'),
      home: Builder(builder: (context) {
        if (kIsWeb) {
          return const CashierHome();
        } else {
          return const LoginPage();
        }
      }),
    );
  }
}

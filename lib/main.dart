import 'package:bsims/screens/admin_dashboard/dashboard.dart';
import 'package:bsims/screens/admin_dashboard/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized(); 

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory app',
      theme: FlexThemeData.light(
        scheme: FlexScheme.green,
       // textTheme: GoogleFonts.sourceSerifProTextTheme(),
      ),      
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('en'), // Inglés
      //   Locale('es'), // Español
      // ],
      home: const Home(),
    );
  }
}

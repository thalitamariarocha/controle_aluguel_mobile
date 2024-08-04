import 'package:controle_aluguel_mobile/firebase_options.dart';
import 'package:controle_aluguel_mobile/pages/home.dart';
import 'package:controle_aluguel_mobile/pages/login/login_page.dart';
import 'package:controle_aluguel_mobile/services/cobranca/cobranca_services.dart';
import 'package:controle_aluguel_mobile/services/contrato/contrato_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('loginBox');

  // const firebaseConfig = FirebaseOptions(
  //   apiKey: "AIzaSyD84IB-XNAB23-23LMOy6wyA1TEyCOrIJk",
  //   projectId: "webback-fb243",
  //   messagingSenderId: "575373742180",
  //   appId: "1:575373742180:web:d48804b4d904abb3d9cf71",
  // );

  // await Firebase.initializeApp(
  //   name: "controle-aluguel",
  //   options: firebaseConfig,
  // );

  // var firebaseApp = await Firebase.initializeApp(
  //     name: "controle-aluguel",
  //     options: const FirebaseOptions(
  //         apiKey: "AIzaSyD84IB-XNAB23-23LMOy6wyA1TEyCOrIJk",
  //         authDomain: "webback-fb243.firebaseapp.com",
  //         projectId: "webback-fb243",
  //         storageBucket: "webback-fb243.appspot.com",
  //         messagingSenderId: "575373742180",
  //         appId: "1:575373742180:web:d48804b4d904abb3d9cf71",
  //         measurementId: "G-NGDJXF0TT8"));

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  WidgetsFlutterBinding.ensureInitialized();

  //------------------se nada der certo, descomentar isso

  // const firebaseConfig = FirebaseOptions(
  //     apiKey: "AIzaSyD84IB-XNAB23-23LMOy6wyA1TEyCOrIJk",
  //     authDomain: "webback-fb243.firebaseapp.com",
  //     projectId: "webback-fb243",
  //     storageBucket: "webback-fb243.appspot.com",
  //     messagingSenderId: "575373742180",
  //     appId: "1:575373742180:web:d48804b4d904abb3d9cf71",
  //     measurementId: "G-NGDJXF0TT8");

  // if (kIsWeb) {
  //   Firebase.initializeApp(options: firebaseConfig);
  // }
  // else {
  //   Firebase.initializeApp(options: firebaseConfig);
  // }
  //---------------------------------------------------------------
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Controle Aluguel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(2, 63, 5, 1),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(4, 121, 9, 1),
          centerTitle: true,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
      home: LoginPage(),
    );
  }
}

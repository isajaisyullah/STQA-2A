import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pawn_book/view/add_daftarbuku.dart';
import 'package:pawn_book/view/add_daftarpeminjam.dart';
import 'package:pawn_book/view/detail_daftarbuku.dart';
import 'package:pawn_book/view/detail_daftarpeminjam.dart';
import 'package:pawn_book/view/edit_daftarbuku.dart';
import 'package:pawn_book/view/edit_daftarpeminjam.dart';
import 'package:pawn_book/view/homepage.dart';
import 'package:pawn_book/view/loginpage.dart';
import 'package:pawn_book/view/splash.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 209, 131, 102)),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}

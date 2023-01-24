import 'package:flutter/material.dart';
import 'package:tugasflutter/screens/home.dart';
import 'package:tugasflutter/screens/login.dart';
import 'package:tugasflutter/screens/register.dart';
import 'package:tugasflutter/screens/tambah.dart';
import 'package:tugasflutter/screens/ubah.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Login(),
        '/register': (context) => const Register(),
        'home': (context) => const Home(),
        '/tambah': (context) => const Tambah(),
        '/ubah': (context) => const Ubah(),
      },
    );
  }
}

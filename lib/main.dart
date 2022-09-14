// ignore_for_file: prefer_const_constructors

import 'package:back_end_nfc/screens/add_matkul.dart';
import 'package:back_end_nfc/screens/dosen_view.dart';
import 'package:back_end_nfc/screens/login_view.dart';
import 'package:back_end_nfc/screens/mahasiswa_view.dart';
import 'package:back_end_nfc/screens/matkul_view.dart';
import 'package:flutter/material.dart';
import 'package:back_end_nfc/widgets/navigation_drawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Back End Presensi NFC',
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: Text(
      //       'Back End Presensi',
      //     ),
      //   ),
      //   drawer: NavigationDrawer(),
      //   body: Text('Hello World!'),
      // ),
      routes: {
        '/': (context) => LoginPage(),
        '/dosen': (context) => DosenPage(),
        '/mahasiswa': (context) => MahasiswaPage(),
        '/matkul': (context) => MatkulPage(),
        // '/addMatkul': (context) => AddMatkul(),
      },
    );
  }
}

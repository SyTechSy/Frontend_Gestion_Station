import 'package:flutter/material.dart';
import 'package:frontend_gestion_station/stationPage/tab_bar_page.dart';

import 'AppHome.dart';
import 'compte/admin_inscription_user.dart';
import 'compte/connexion.dart';

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
        //"/" : (context) => const AppHomes()
        //"/" : (context) => LoginPage()
        "/" : (context) => InscriptionPage()
      },
    );
  }
}

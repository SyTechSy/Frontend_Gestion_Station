import 'package:flutter/material.dart';
import 'package:frontend_gestion_station/services/adminService.dart';
import 'package:frontend_gestion_station/services/utilisateurService.dart';
import 'package:frontend_gestion_station/welcomePage.dart';
import 'package:get_it/get_it.dart';
import 'package:frontend_gestion_station/stationPage/tab_bar_page.dart';

import 'Administrateur/AdminAppHome.dart';
import 'AppHome.dart';
import 'compte/admin_inscription_user.dart';
import 'compte/connexion.dart';


final GetIt locator = GetIt.instance;
//final GetIt sl = GetIt.instance;

void setupLocator() {
  // Enregistrez vos services ici
  locator.registerLazySingleton(() => AdminService());
  //sl.registerLazySingleton<UtilisateurService>(() => UtilisateurService());
}

void main() {
  setupLocator();
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
        //"/" : (context) => InscriptionPage()
        //"/" : (context) => AdminAppHomesPage()
        "/" : (context) => WelcomePage()
      },
    );
  }
}

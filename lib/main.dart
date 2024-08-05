import 'package:flutter/material.dart';
import 'package:frontend_gestion_station/services/adminService.dart';
import 'package:frontend_gestion_station/services/bonService.dart';
import 'package:frontend_gestion_station/services/devisStationGasoilService.dart';
import 'package:frontend_gestion_station/services/devisStationService.dart';
import 'package:frontend_gestion_station/services/utilisateurService.dart';
import 'package:frontend_gestion_station/Utilisateur/welcomePage.dart';
import 'package:get_it/get_it.dart';
import 'package:frontend_gestion_station/stationPage/tab_bar_page.dart';

import 'Administrateur/AdminAppHome.dart';
import 'Administrateur/profileAdmin.dart';
import 'Utilisateur/AppHome.dart';
import 'Utilisateur/homes.dart';
import 'Utilisateur/navBar.dart';
import 'brouillon/admin_inscription_user.txt';
import 'compte/connexion.dart';


final GetIt locator = GetIt.instance;
//final GetIt sl = GetIt.instance;

void setupLocator() {
  // Enregistrez vos services ici
  locator.registerLazySingleton(() => UtilisateurService());
  locator.registerLazySingleton(() => AdminService());
  locator.registerLazySingleton(() => DevisService());
  locator.registerLazySingleton(() => DevisGasoilService());
  locator.registerLazySingleton(() => BonService());
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
        //"/" : (context) => ProfilPageAdmin()
        "/" : (context) => const WelcomeUserPage()
        //"/" : (context) => const HomesSection()
        //"/" : (context) => const NavBarSection()
      },
    );
  }
}

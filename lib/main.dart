import 'package:flutter/material.dart';
import 'package:frontend_gestion_station/services/adminService.dart';
import 'package:frontend_gestion_station/services/bonService.dart';
import 'package:frontend_gestion_station/services/budgetTotalService.dart';
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
import 'models/adminModel.dart';
import 'models/utilisateurModel.dart';


final GetIt locator = GetIt.instance;
//final GetIt sl = GetIt.instance;

void setupLocator() {
  // Enregistrez vos services ici
  locator.registerLazySingleton(() => UtilisateurService());
  locator.registerLazySingleton(() => AdminService());
  locator.registerLazySingleton(() => DevisService());
  locator.registerLazySingleton(() => DevisGasoilService());
  locator.registerLazySingleton(() => BonService());
  locator.registerLazySingleton(() => BudgetTotalService());
  //sl.registerLazySingleton<UtilisateurService>(() => UtilisateurService());
}

/*void main() {
  setupLocator();
  runApp(const MyApp());
}*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  final utilisateurService = GetIt.instance<UtilisateurService>();
  final adminService = GetIt.instance<AdminService>();
  final budgetTotalService = GetIt.instance<BudgetTotalService>();
  await utilisateurService.initialize(); // Charge l'utilisateur stocké
  await adminService.initialize();
  runApp(MyApp(utilisateurService: utilisateurService, adminService: adminService,));
}

class MyApp extends StatelessWidget {
  //final UserModel utilisateur;
  final UtilisateurService utilisateurService;
  final AdminService adminService;
 // final AdminModel admin;
  const MyApp({super.key, required this.utilisateurService, required this.adminService,});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) {
          // Vérifier si un administrateur est connecté
          if (adminService.connectedAdmin != null) {
            return AdminAppHomesPage(admin: adminService.connectedAdmin!);
          }
          // Sinon, vérifier si un utilisateur est connecté
          else if (utilisateurService.connectedUser != null) {
            return NavBarSection();
          }
          // Si aucun des deux n'est connecté, retourner à la page de bienvenue
          else {
            return WelcomeUserPage();
          }
        },
      },

    );
  }
}

/*
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
 */
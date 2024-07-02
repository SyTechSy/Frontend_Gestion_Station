import 'package:flutter/material.dart';
import 'package:frontend_gestion_station/Utilisateur/accueil.dart';
import 'package:frontend_gestion_station/Utilisateur/profilUtilisateur.dart';
import 'package:frontend_gestion_station/models/utilisateurModel.dart';

import '../models/devisStationModel.dart';
import 'bonAccueil.dart';

class AppHomes extends StatefulWidget {
  //final UserModel utilisateur;
  final int initialTabIndex;
  const AppHomes({super.key, this.initialTabIndex = 0});

  @override
  State<AppHomes> createState() => _AppHomesState();
}

class _AppHomesState extends State<AppHomes> {
  int _currentIndex = 0;

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTabIndex;
    screens = [
      AccueilPage(initialTabIndexx: widget.initialTabIndex),
      AccueilBon(),
      Center(child: Text("Historique", style: TextStyle(fontSize: 30))),
      ProfilPageUtilisateur()
    ];
  }



  @override
  Widget build(BuildContext context) => Scaffold(
    body: screens[_currentIndex],
    bottomNavigationBar: BottomNavigationBar(
      backgroundColor: const Color(0xff12343b),
      currentIndex: _currentIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey.shade600,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [

        BottomNavigationBarItem(icon: Icon(Icons.local_gas_station_rounded), label: 'Station'),
        BottomNavigationBarItem(icon: Icon(Icons.screen_rotation_alt), label: 'Bons'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historique'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        /*BottomNavigationBarItem(icon: CircleAvatar(
          backgroundImage: AssetImage(
            'assets/abdoull.jpg',
          ),
          maxRadius: 12,
        ), label: 'Profil'),*/
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    ),
  );
}

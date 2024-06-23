import 'package:flutter/material.dart';
import 'package:frontend_gestion_station/Utilisateur/accueil.dart';
import 'package:frontend_gestion_station/Utilisateur/profilUtilisateur.dart';
import 'package:frontend_gestion_station/models/utilisateurModel.dart';

class AppHomes extends StatefulWidget {
  final UserModel utilisateur;
  const AppHomes({super.key, required this.utilisateur});

  @override
  State<AppHomes> createState() => _AppHomesState();
}

class _AppHomesState extends State<AppHomes> {
  int _currentIndex = 0;

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      AccueilPage(),
      //PageStation(),
      Center(child: Text("Bons", style: TextStyle(fontSize: 30))),
      Center(child: Text("Historique", style: TextStyle(fontSize: 30))),
      ProfilPageUtilisateur(utilisateur: widget.utilisateur,)
    ];
  }



  @override
  Widget build(BuildContext context) => Scaffold(
    body: screens[_currentIndex],
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey.shade700,
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

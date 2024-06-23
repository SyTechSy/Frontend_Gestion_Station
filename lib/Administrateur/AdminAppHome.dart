import 'package:flutter/material.dart';
import 'package:frontend_gestion_station/Administrateur/gestionnaire.dart';
import 'package:frontend_gestion_station/Administrateur/listDesGestionnaire.dart';
import 'package:frontend_gestion_station/Administrateur/profileAdmin.dart';

import '../models/adminModel.dart';

class AdminAppHomesPage extends StatefulWidget {
  final AdminModel admin;

  const AdminAppHomesPage({super.key, required this.admin});

  @override
  State<AdminAppHomesPage> createState() => _AdminAppHomesPageState();
}

class _AdminAppHomesPageState extends State<AdminAppHomesPage> {
  int _currentIndex = 0;

  //late List<Widget> screens;
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      AdminGestionnairePage(),
      //InscriptionPage(),
      ListGestionnairePage(),
      Center(child: Text("Historique", style: TextStyle(fontSize: 30))),
      ProfilPageAdmin(admin: widget.admin), // Pass the admin object here
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
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined, size: 30,), label: 'Station'),
        BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle_outlined), label: 'jout User'),
        BottomNavigationBarItem(icon: Icon(Icons.screen_rotation_alt), label: 'Bons'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    ),
  );
}

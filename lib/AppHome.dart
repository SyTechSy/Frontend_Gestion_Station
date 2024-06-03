import 'package:flutter/material.dart';
import 'package:frontend_gestion_station/accueil.dart';
import 'package:frontend_gestion_station/stationPage/station.dart';

class AppHomes extends StatefulWidget {
  const AppHomes({super.key});

  @override
  State<AppHomes> createState() => _AppHomesState();
}

class _AppHomesState extends State<AppHomes> {
  int _currentIndex = 0;
  final screens = [
    AccueilPage(),
    //PageStation(),
    Center(child: Text("Bons", style: TextStyle(fontSize: 30))),
    Center(child: Text("Historique", style: TextStyle(fontSize: 30))),
    Center(child: Text("Profil", style: TextStyle(fontSize: 30))),
  ];

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

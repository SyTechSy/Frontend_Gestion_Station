import 'package:flutter/material.dart';
import 'package:frontend_gestion_station/Administrateur/gestionnaire.dart';

class AdminAppHomesPage extends StatefulWidget {
  const AdminAppHomesPage({super.key});

  @override
  State<AdminAppHomesPage> createState() => _AdminAppHomesPageState();
}

class _AdminAppHomesPageState extends State<AdminAppHomesPage> {
  int _currentIndex = 0;
  final screens = [
    AdminGestionnairePage(),
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

        BottomNavigationBarItem(icon: Icon(Icons.home_outlined, size: 30,), label: 'Station'),
        BottomNavigationBarItem(icon: Icon(Icons.calculate_outlined), label: 'Calculer'),
        BottomNavigationBarItem(icon: Icon(Icons.screen_rotation_alt), label: 'Bons'),
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

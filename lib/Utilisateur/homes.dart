import 'package:flutter/material.dart';

import '../models/utilisateurModel.dart';
import '../stationPage/essencePage.dart';
import '../stationPage/gasoilPage.dart';
import '../usersCreation/essence.dart';
import '../usersCreation/gasoil.dart';

class HomesSection extends StatelessWidget {
  final UserModel utilisateur;
  const HomesSection({super.key, required this.utilisateur});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomesPageSection(utilisateur: utilisateur,),
    );
  }
}

class HomesPageSection extends StatefulWidget {
  final UserModel utilisateur;
  const HomesPageSection({super.key, required this.utilisateur});

  @override
  State<HomesPageSection> createState() => _HomesPageSectionState();
}

class _HomesPageSectionState extends State<HomesPageSection> {
  int _selectedSegment = 0;

  void _onSegmentSelected(int index) {
    setState(() {
      _selectedSegment = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Devis",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
            )
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline_rounded),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSegmentButton("Devis Essences", 0),
                _buildSegmentButton("Devis Gasoils", 1),
                _buildSegmentButton("Devis Bons", 2),
              ],
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: _selectedSegment,
        children: [
          SectionEssence(utilisateur: widget.utilisateur,),
          SectionGasoil(utilisateur: widget.utilisateur,),
          Center(child: Text("Les devis bons")),
        ],
      ),
    );
  }

  Widget _buildSegmentButton(String text, int index) {
    bool isSelected = _selectedSegment == index;

    return GestureDetector(
      onTap: () => _onSegmentSelected(index),
      child: Container(
        //margin: EdgeInsets.symmetric(horizontal: 0),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff12343b) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: Color(0xff12343b))
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}



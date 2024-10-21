import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:frontend_gestion_station/Utilisateur/profilUtilisateur.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../add/ajouter_devis_bon.dart';
import '../add/ajouter_devis_essence.dart';
import '../add/ajouter_devis_gasoil.dart';
import '../add/bonAjouter.dart';
import '../models/BonDuJourModel.dart';
import '../models/budgetTotalModel.dart';
import '../models/utilisateurModel.dart';
import '../services/BonDuJourService.dart';
import '../services/utilisateurService.dart';
import '../stationPage/sommePage.dart';
import '../usersCreation/budgetSommeTotal.dart';
import '../usersCreation/detailStationBons.dart';
import 'accueil.dart';
import 'homes.dart';

class NavBarSection extends StatefulWidget {
  final int initialTabIndex;
  final BudgetTotalModel? budgetstation;
  //final UserModel utilisateur;

  const NavBarSection({super.key, this.initialTabIndex = 0, this.budgetstation});

  @override
  State<NavBarSection> createState() => _NavBarSectionState();
}

class _NavBarSectionState extends State<NavBarSection> {
  late int _currentIndex;
  late final List<Widget> screens;
  final UtilisateurService utilisateurService = GetIt.instance<UtilisateurService>();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTabIndex;
    screens = [
      //HomesSection(),
      AccueilPage(),
      BudgetSommeTotal(),
      Center(child: Text("")),
      Center(child: Text("Aucun notification", style: TextStyle(fontSize: 20))),
      //SommePage(),
      ProfilPageUtilisateur(utilisateur: utilisateurService.connectedUser!),
    ];
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Color _getIconColor(int index) {
    return _currentIndex == index ? Color(0xff12343b) : Colors.black.withOpacity(0.7);
  }

  final BonDuJourService _bonDuJourService = BonDuJourService();
  final _utilisateurService = GetIt.instance<UtilisateurService>();


  String message = '';
  List<BonDuJourModel> bonDuJourStations = [];
  BonDuJourModel? champsInBonDuJour;

  void _submitForm() async {
    int? idUser = _utilisateurService.connectedUser?.idUser;
    String nomUtilisateur = _utilisateurService.connectedUser?.nomUtilisateur ?? 'N/A';
    String prenomUtilisateur = _utilisateurService.connectedUser?.prenomUtilisateur ?? 'N/A';
    DateTime dateAddBonDuJour = DateTime.now();
    final today = DateTime.now();
    final dayName = getDayName(today);

    // Conversion du DateTime en String au format souhaité (par exemple, 'yyyy-MM-dd HH:mm:ss')
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateAddBonDuJour);

    BonDuJourModel bondujourstation = BonDuJourModel(
        idBonJour: null,
        idUser: idUser,
        nomUtilisateur: nomUtilisateur,
        prenomUtilisateur: prenomUtilisateur,
        dateAddBonDuJour: formattedDate // Utilisez la chaîne formatée ici
    );

    try {
      champsInBonDuJour = await _bonDuJourService.ajouterBonDuJour(bondujourstation);

      if (idUser != null && champsInBonDuJour != null && champsInBonDuJour!.idBonJour != null) {
        setState(() {
          message = 'Bon créé avec succès';
          print("Ajout du bon du jour");
        });

        // Naviguer vers le détail du bon du jour créé
        print("Navigation vers le bon du jour avec ID: ${champsInBonDuJour?.idBonJour}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SectionDetailStationBons(
              dateAddBonDuJour: champsInBonDuJour!.dateAddBonDuJour, // Passer la date du bon
              idBonDuJour: champsInBonDuJour!.idBonJour!, // Passer l'ID du bon
            ),
          ),
        );
      } else {
        setState(() {
          message = 'Bon du jour non cree';
        });
      }

    } catch (e) {
      print('Erreur lors de la création de bon: $e');
      showErrorMessage('Vous avez déjà créé un bon pour aujourd\'hui');
      setState(() {
        message = 'Vous avez déjà créé un bon aujourd\'hui.';
      });
    }
  }


  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.grey[50],
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 5, right: 5, bottom: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Choisis ton devis',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AjouterDevisEssence()));
                },
                child: Card(
                  color: Colors.white,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5, top: 4, bottom: 4),
                        child: Row(
                          children: [
                            Icon(Icons.radio_button_off, size: 20, color: Color(0xff12343b)),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Essence",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Vous pouvez créer un devis essence",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AjouterDevisGasoil()));
                },
                child: Card(
                  color: Colors.white,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5, top: 4, bottom: 4),
                        child: Row(
                          children: [
                            Icon(Icons.radio_button_off, size: 20, color: Color(0xff12343b)),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Gasoil",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Vous pouvez créer un devis gasoil",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ),
              ),
              GestureDetector(
                /*onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddQuoteStationGood()));
                },*/
                onTap: () async {
                  _submitForm();
                  Navigator.pop(context);
                },
                child: Card(
                  color: Colors.white,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5, top: 4, bottom: 4),
                        child: Row(
                          children: [
                            Icon(Icons.radio_button_off, size: 20, color: Color(0xff12343b)),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ajouter le bon du jour",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Vous pouvez créer une seule fois le bon du jour ",
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ),
              ),

            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: screens[_currentIndex],
    extendBody: true,
    floatingActionButton: Container(
      width: 65.0,
      height: 65.0,
      child: FloatingActionButton(
        backgroundColor: Color(0xff12343b),
        onPressed: () => _showBottomSheet(context),
        child: const Icon(Icons.add, color: Colors.white, size: 30,),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
      ),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    bottomNavigationBar: BottomAppBar(
      elevation: 2,
      shadowColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 60,
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.local_gas_station_rounded,
              color: _getIconColor(0),
            ),
            onPressed: () => onTabTapped(0),
          ),
          IconButton(
            icon: Icon(
              Icons.calculate_outlined,
              color: _getIconColor(1),
            ),
            onPressed: () => onTabTapped(1),
          ),
          const SizedBox(width: 40), // Espacement pour le FAB
          IconButton(
            icon: Icon(
              Icons.history,
              color: _getIconColor(3),
            ),
            onPressed: () => onTabTapped(3),
          ),
          IconButton(
            icon: Icon(
              Icons.people,
              color: _getIconColor(4),
            ),
            onPressed: () => onTabTapped(4),
          ),
        ],
      ),
    ),
  );
  // Fonction pour obtenir le nom du jour en français
  String getDayName(DateTime date) {
    final daysOfWeek = [
      'Dimanche',
      'Lundi',
      'Mardi',
      'Mercredi',
      'Jeudi',
      'Vendredi',
      'Samedi',
    ];
    return daysOfWeek[date.weekday % 7];
  }
  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
            color: Colors.white
        ),
      ),
      backgroundColor: Color(0xff12343b),
    );
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
  }
  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
            color: Colors.white
        ),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
  }
}


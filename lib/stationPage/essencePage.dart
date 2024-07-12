import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend_gestion_station/models/devisStationModel.dart';
import 'package:frontend_gestion_station/stationPage/sommePage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../EditPage/editDevisEssence.dart';
import '../Utilisateur/AppHome.dart';
import '../models/utilisateurModel.dart';
import '../services/devisStationService.dart';
import '../services/utilisateurService.dart';

class EssencePage extends StatefulWidget {
  final double budgetObtenu;
  const EssencePage({super.key, this.budgetObtenu = 0});

  @override
  State<EssencePage> createState() => _EssencePageState();
}

class _EssencePageState extends State<EssencePage> {
  final _devisService = GetIt.instance<DevisService>();
  final _utilisateurService = GetIt.instance<UtilisateurService>();
  bool isLoading = true;
  List<DevisModel> devisStations = [];
  //late TextEditingController _budgetController;

  @override
  void initState() {
    super.initState();
    _fetchDevis();
    //_budgetController = TextEditingController(text: widget.budgetObtenu.toString());
  }

  Future<void> _saveBudget(double budget) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('budgetObtenu', budget);
  }

  Future<void> _deleteDevisEssence(int idDevis) async {
    print('Tentative de suppression de l\'essence devis avec ID: $idDevis');
    try {
      await _devisService.deleteDevisEssence(idDevis);
      setState(() {
        devisStations.removeWhere((devis) => devis.id == idDevis);
      });
      showSuccessMessage('Devis supprimé avec succès');
    } catch (e) {
      print('Erreur lors de la suppression de devis essence: $e');
      showErrorMessage('Erreur lors de la suppression de devis essence');
    }
  }

  // Fonction pour les listes d'User
  /*Future<void> _fetchDevis() async {
    try {
      List<DevisModel> devis = await _devisService.fetchDevis();
      setState(() {
        devisStations = devis;
      });

      // Ajout de logs pour vérifier les valeurs récupérées
      for (var devis in devisStations) {
        print('idUser: ${devis.id}');
        print('ValeurArriver: ${devis.valeurArriver}');
        print('ValeurDeDepart: ${devis.valeurDeDepart}');
        print('PrixUnité: ${devis.prixUnite}');
        print('Consommation: ${devis.consommation}');
        print('BudgetObtenu: ${devis.budgetObtenu}');
        print('dateAddDevis: ${devis.dateAddDevis}');
        print('id: ${devis.idUser}');
        print('nomUtilisateur: ${devis.nomUtilisateur}');
        print('prenomUtilisateur: ${devis.prenomUtilisateur}');
      }

    } catch (e) {
      print('Erreur lors du chargement des devis : $e');
    }
    setState(() {
      isLoading = false;
    });
  }*/
  Future<void> _fetchDevis() async {
    try {
      UserModel? connectedUser = _utilisateurService.connectedUser;

      if (connectedUser != null) {
        int? idUser = connectedUser.idUser; // Récupérer l'ID de l'utilisateur connecté

        List<DevisModel> devis = await _devisService.fetchDevis(idUser!);
        setState(() {
          devisStations = devis;
        });

        // Ajout de logs pour vérifier les valeurs récupérées
        for (var devis in devisStations) {
          print('idDevis: ${devis.id}');
          print('ValeurArriver: ${devis.valeurArriver}');
          print('ValeurDeDepart: ${devis.valeurDeDepart}');
          print('PrixUnité: ${devis.prixUnite}');
          print('Consommation: ${devis.consommation}');
          print('BudgetObtenu: ${devis.budgetObtenu}');
          print('dateAddDevis: ${devis.dateAddDevis}');
          print('id: ${devis.idUser}');
          print('nomUtilisateur: ${devis.nomUtilisateur}');
          print('prenomUtilisateur: ${devis.prenomUtilisateur}');
        }
      } else {
        print('Aucun utilisateur connecté');
      }

    } catch (e) {
      print('Erreur lors du chargement des devis : $e');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        padding: const  EdgeInsets.only(left: 10, right: 10),
        child: Visibility(
          visible: isLoading,
          child: Center(child: CircularProgressIndicator()),
          replacement: RefreshIndicator(
            onRefresh: _fetchDevis,
            child: ListView.builder(
              itemCount: devisStations.length,
              itemBuilder: (context, index) {
                final devis = devisStations[index];
                return Transform.translate(
                  offset: Offset(0, -15),
                  child: Container(
                    width: double.infinity,
                    child: Card(
                      color: Colors.white,
                      elevation: 1.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(width: 1, color: Colors.black),
                      ),
                      child: ExpansionTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  //devis.dateAddDevis.toString() ?? 'N/A',
                                  devis.nomUtilisateur.toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  devis.prenomUtilisateur.toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              devis.dateAddDevis.toString(),
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                        shape: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff12343b).withOpacity(0.6)),
                        ),
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 170,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xff12343b).withOpacity(0.6), width: 0.5),
                                  ),
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Valeur Arriver",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${devis.valeurArriver}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Text(
                                              "FCFA",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.orange,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  width: 170,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xff12343b).withOpacity(0.6), width: 0.5),
                                  ),
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Valeur de Départ",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${devis.valeurDeDepart.toString()}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Text(
                                              "FCFA",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.orange,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 110,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xff12343b).withOpacity(0.6), width: 0.5),
                                  ),
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Consommation",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${devis.consommation.toString()}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Text(
                                              "F",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.orange,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  width: 110,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xff12343b).withOpacity(0.6), width: 0.5),
                                  ),
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Prix Unité",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${devis.prixUnite.toString()}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Text(
                                              "FCFA",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.orange,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  width: 110,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xff12343b).withOpacity(0.6), width: 0.5),
                                  ),
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Budget Obtenu",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${devis.budgetObtenu.toString()}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Text(
                                              "F",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.orange,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 2, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (devis.id != null) {
                                      _deleteDevisEssence(devis.id!);
                                    } else {
                                      print('Devis ID is null, cannot delete');
                                    }
                                  },
                                  child: Text(
                                    "Supprimer",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1
                                    ),
                                  ),
                                ),
                                /*GestureDetector(
                                  onTap: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ModifierDevisEssence(devisId: devis.id!, devis: devis,), // Passez le devisId ici
                                      ),
                                    );
                                    if (result != null) {
                                      setState(() {
                                        devisStations[index] = result;
                                      });
                                    }
                                  },
                                  child: Text(
                                    "Modifier",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w500,
                                        letterSpacing: 1
                                    ),
                                  ),
                                ),*/
                                SizedBox(
                                  height: 30,
                                  child: ElevatedButton(
                                    child: Text(
                                      "Modifier",
                                      style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 1,
                                          fontSize: 14
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xff12343b),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () async {
                                      final result = await Navigator.push(
                                        context, MaterialPageRoute(
                                          builder: (context) => ModifierDevisEssence(devisId: devis.id!, devis: devis,), // Passez le devisId ici
                                        ),
                                      );
                                      if (result != null) {
                                        setState(() {
                                          devisStations[index] = result;
                                        });
                                      }
                                    },
                                  ),
                                ),

                                SizedBox(
                                  height: 30,
                                  child: ElevatedButton(
                                    child: Text(
                                      "Enregistrer",
                                      style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 1,
                                          fontSize: 14
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red.withOpacity(0.4),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () async {
                                      await _saveBudget(widget.budgetObtenu);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SommePage(budgetEssence: devis.budgetObtenu),
                                        ),
                                      );
                                    },
                                    /*style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red.withOpacity(0.4),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Confirmer l'enregistrement"),
                                            content: Text("Voulez-vous vraiment enregistrer ?"),
                                            actions: [
                                              TextButton(
                                                child: Text("NON"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              TextButton(
                                                child: Text("OUI"),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => SommePage(budgetObtenu: devis.budgetObtenu),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },*/
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
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



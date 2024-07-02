import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../models/devisStationGasoilModel.dart';
import '../models/utilisateurModel.dart';
import '../services/devisStationGasoilService.dart';
import '../services/utilisateurService.dart';

class GasoilPage extends StatefulWidget {
  const GasoilPage({super.key});

  @override
  State<GasoilPage> createState() => _GasoilPageState();
}

class _GasoilPageState extends State<GasoilPage> {
  final _devisGasoilService = GetIt.instance<DevisGasoilService>();
  final _utilisateurService = GetIt.instance<UtilisateurService>();
  bool isLoading = true;
  List<DevisGasoilModel> devisStationsGasoil = [];

  @override
  void initState() {
    super.initState();
    _fetchDevisGasoil();
  }

  // Suppression function
  Future<void> _deleteDevisGasoil(int idDevisG) async {
    print('Tentative de suppression de l\'essence devis avec ID: $idDevisG');
    try {
      await _devisGasoilService.deleteDevisGasoil(idDevisG);
      setState(() {
        devisStationsGasoil.removeWhere((devis) => devis.id == idDevisG);
      });
      showSuccessMessage('Devis gasoil supprimé avec succès');
    } catch (e) {
      print('Erreur lors de la suppression de devis gasoil : $e');
      showErrorMessage('Erreur lors de la suppression de devis gasoil');
    }
  }

  // List function
  Future<void> _fetchDevisGasoil() async {
    try {
      UserModel? connectedUser = _utilisateurService.connectedUser;

      if (connectedUser != null) {
        int? idUser = connectedUser.idUser; // Récupérer l'ID de l'utilisateur connecté

        List<DevisGasoilModel> devis = await _devisGasoilService.fetchDevis(idUser!);
        setState(() {
          devisStationsGasoil = devis;
        });

        // Ajout de logs pour vérifier les valeurs récupérées
        for (var devis in devisStationsGasoil) {
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
      print('Erreur lors du chargement des devis gasoil : $e');
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
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Visibility(
          visible: isLoading,
          child: Center(child: CircularProgressIndicator()),
          replacement: RefreshIndicator(
            onRefresh: _fetchDevisGasoil,
            child: ListView.builder(
              itemCount: devisStationsGasoil.length,
              itemBuilder: (context, index) {
                final devis = devisStationsGasoil[index];
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
                            margin: EdgeInsets.only(top: 0, bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (devis.id != null) {
                                      _deleteDevisGasoil(devis.id!);
                                    } else {
                                      print('Devis gasoil ID is null, cannot delete');
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
                                Text(
                                  "Modifier",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1
                                  ),
                                ),
                                Text(
                                  "Enregistre",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1
                                  ),
                                ),
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

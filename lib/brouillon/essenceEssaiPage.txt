import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend_gestion_station/models/devisStationModel.dart';
import 'package:get_it/get_it.dart';

import '../services/devisStationService.dart';

class EssencePage extends StatefulWidget {
  const EssencePage({super.key});

  @override
  State<EssencePage> createState() => _EssencePageState();
}

class _EssencePageState extends State<EssencePage> {
  final _devisService = GetIt.instance<DevisService>();
  bool isLoading = true;
  List<DevisModel> devisStations = [];

  @override
  void initState() {
    super.initState();
    _fetchDevis();
  }

  // Fonction pour les listes d'User
  Future<void> _fetchDevis() async {
    try {
      List<DevisModel> devis = await _devisService.fetchDevis();
      setState(() {
        devisStations = devis;
      });

      // Ajout de logs pour vérifier les valeurs récupérées
      for (var devis in devisStations) {
        print('idUser: ${devis.id}');
        print('id: ${devis.idUser}');
        print('ValeurArriver: ${devis.valeurArriver}');
        print('ValeurDeDepart: ${devis.valeurDeDepart}');
        print('PrixUnité: ${devis.prixUnite}');
        print('Consommation: ${devis.consommation}');
        print('BudgetObtenu: ${devis.budgetObtenu}');
        print('dateAddDevis: ${devis.dateAddDevis}');
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
        padding: EdgeInsets.only(left: 10, right: 10),
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
                                  "Mamoutou",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Traore",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              devis.dateAddDevis.toString() ?? 'N/A',
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
                                            '${devis.valeurArriver ?? 'N/A'}',
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
                                            '${devis.valeurDeDepart?.toString() ?? 'N/A'}',
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
                                            '${devis.consommation?.toString() ?? 'N/A'}',
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
                                            '${devis.prixUnite?.toString() ?? 'N/A'}',
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
                                            '${devis.budgetObtenu?.toString() ?? 'N/A'}',
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
}

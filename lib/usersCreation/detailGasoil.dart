import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend_gestion_station/models/devisStationModel.dart';
import 'package:get_it/get_it.dart';

import '../EditPage/editDevisGasoil.dart';
import '../Utilisateur/navBar.dart';
import '../models/devisStationGasoilModel.dart';
import '../models/utilisateurModel.dart';
import '../services/devisStationGasoilService.dart';

class SectionDetailGasoilPage extends StatefulWidget {
  final DevisGasoilModel devis;
  //final UserModel utilisateur;
  const SectionDetailGasoilPage({super.key, required this.devis});

  @override
  State<SectionDetailGasoilPage> createState() => _SectionDetailGasoilPageState();
}

class _SectionDetailGasoilPageState extends State<SectionDetailGasoilPage> {
  final _devisGasoilService = GetIt.instance<DevisGasoilService>();
  List<DevisGasoilModel> devisStationsGasoil = [];

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

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.grey[50],
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 10, right: 5, bottom: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //SizedBox(height: 10),
              // Modifier
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black12
                    ),
                    child: Icon(
                      Icons.edit_road_sharp,
                      size: 22,
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ModifierDevisGasoil(
                            devisId: widget.devis.id!,
                            devis: widget.devis,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Modifier',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  )
                  //SizedBox(height: 100),
                ],
              ),
              SizedBox(height: 15),
              // Supprimer
              GestureDetector(
                onTap: () => _confirmDelete(context, widget.devis.id!),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black12
                      ),
                      child: Icon(
                        Icons.delete_outline,
                        size: 22,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Supprimer',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    )
                    //SizedBox(height: 100),
                  ],
                ),
              ),
              SizedBox(height: 15),
              // Annuler
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black12
                    ),
                    child: Icon(
                      Icons.cancel_outlined,
                      size: 22,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Annuler',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    ),
                  )
                  //SizedBox(height: 100),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, int idDevis) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmer la suppression'),
          content: Text('Voulez-vous vraiment supprimer ce devis?'),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
            ),
            TextButton(
              child: Text('Supprimer'),
              onPressed: () async { // Fermer la boîte de dialogue
                await _deleteDevisGasoil(idDevis);
                Navigator.push(
                    context, MaterialPageRoute(
                  builder: (context) => NavBarSection(),
                )
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      body: Container(
        margin: const EdgeInsets.only(left: 10, top: 40, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios, size: 18,
                          )
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Mon devis gasoil',
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Transform.translate(
                  offset: Offset(15, 0),
                  child: IconButton(
                    icon: Icon(
                      Icons.more_vert,
                      size: 25,
                      color: Colors.black,
                    ),
                    onPressed: () => _showBottomSheet(context),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Valeur d'arriver et valeur de depart
            Card(
              elevation: 0,
              //color: Colors.black.withOpacity(0.2),
              color: Colors.white.withOpacity(0.6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                  child: Column(
                    children: [
                      Container(
                        //color: Colors.blue,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.ac_unit,
                                  size: 18,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Valeur d'arriver",
                                  style: TextStyle(
                                      fontSize: 16
                                  ),
                                )
                              ],
                            ),
                            Text(
                              widget.devis.valeurArriver.toString(),
                              style: TextStyle(
                                  fontSize: 15
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        //color: Colors.red,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.ac_unit,
                                  size: 18,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Valeur de départ",
                                  style: TextStyle(
                                      fontSize: 16
                                  ),
                                )
                              ],
                            ),
                            Text(
                              widget.devis.valeurDeDepart.toString(),
                              style: TextStyle(
                                  fontSize: 15
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
              ),
            ),
            // Consommation
            Card(
              elevation: 0,
              //color: Colors.black.withOpacity(0.2),
              color: Colors.white.withOpacity(0.6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                  child: Column(
                    children: [
                      Container(
                        //color: Colors.red,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.ac_unit,
                                  size: 18,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Consommation",
                                  style: TextStyle(
                                      fontSize: 16
                                  ),
                                )
                              ],
                            ),
                            Text(
                              widget.devis.consommation.toString(),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.red
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
              ),
            ),
            // Prix unité
            Card(
              elevation: 0,
              //color: Colors.black.withOpacity(0.2),
              color: Colors.white.withOpacity(0.6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                  child: Column(
                    children: [
                      Container(
                        //color: Colors.red,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.ac_unit,
                                  size: 18,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Prix unité",
                                  style: TextStyle(
                                      fontSize: 16
                                  ),
                                )
                              ],
                            ),
                            Text(
                              widget.devis.prixUnite.toString(),
                              style: TextStyle(
                                fontSize: 15,
                                //color: Colors.red
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
              ),
            ),
            // Budget obtenu
            Card(
              elevation: 0,
              //color: Colors.black.withOpacity(0.2),
              color: Colors.white.withOpacity(0.6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                  child: Column(
                    children: [
                      Container(
                        //color: Colors.red,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.ac_unit,
                                  size: 18,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Budget obtenu",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff12343b)
                                  ),
                                )
                              ],
                            ),
                            Text(
                              widget.devis.budgetObtenu.toString(),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xff12343b),
                                  fontWeight: FontWeight.w500
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.devis.dateAddDevis.toString(),
            ),
          ],
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
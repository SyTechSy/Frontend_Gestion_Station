import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend_gestion_station/models/devisStationModel.dart';
import 'package:get_it/get_it.dart';

import '../Utilisateur/navBar.dart';
import '../models/utilisateurModel.dart';
import '../services/devisStationService.dart';
import 'essence.dart';

class DetailBudgetSommeTotal extends StatefulWidget {
  const DetailBudgetSommeTotal({super.key});

  @override
  State<DetailBudgetSommeTotal> createState() => _DetailBudgetSommeTotalState();
}

class _DetailBudgetSommeTotalState extends State<DetailBudgetSommeTotal> {

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.grey[50],
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 10, right: 5, bottom: 16.0),
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
                  Text(
                    'Modifier',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  )
                  //SizedBox(height: 100),
                ],
              ),
              SizedBox(height: 15),
              // Supprimer
              GestureDetector(
                onTap: () {},
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
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              // Partager a admin
              GestureDetector(
                onTap: () {},
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
                        Icons.send_outlined,
                        size: 22,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Partager a l'admin",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
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
          content: Text('Voulez-vous vraiment supprimer ce de budget?'),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
            ),
            TextButton(
              child: Text('Supprimer'),
              onPressed: ()  {},
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
                          child: const Icon(
                            Icons.arrow_back_ios, size: 18,
                          )
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        "Mon calcul global",
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
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Text(
                                "Budget total essence",
                                style: TextStyle(
                                    fontSize: 16
                                ),
                              ),
                            ),
                            Text(
                              "500",
                              style: TextStyle(
                                  fontSize: 15
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        //color: Colors.red,
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Text(
                                "Budget total gasoil",
                                style: TextStyle(
                                    fontSize: 16
                                ),
                              ),
                            ),
                            Text(
                              "200",
                              style: TextStyle(
                                  fontSize: 15
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        //color: Colors.red,
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Text(
                                "Somme des budgets",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              "700",
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
            // L'argent reçu au travail
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
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: const Text(
                                "L'argent reçu au travail",
                                style: TextStyle(
                                    fontSize: 16
                                ),
                              ),
                            ),
                            Text(
                              "600",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
              ),
            ),
            // Gagner d'argent
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
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: const Text(
                                "Gagner d'argent",
                                style: TextStyle(
                                    fontSize: 16
                                ),
                              ),
                            ),
                            Text(
                              "00",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
              ),
            ),
            // Perte d'argent
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
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: const Text(
                                "Perte d'argent",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Text(
                              "-100",
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
            SizedBox(height: 10),
            Text(
              'Vendredi à 23h:30m:52sec'
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
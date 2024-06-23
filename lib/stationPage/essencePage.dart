import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend_gestion_station/models/devisStationModel.dart';

class EssencePage extends StatelessWidget {
  EssencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: [
            Transform.translate(
              offset: Offset(0, -15),
              child: Container(
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(width: 1, color: Colors.black)
                  ),
                  child: ExpansionTile(
                    //leading: CircleAvatar(backgroundImage: AssetImage("assets/logoHy.png")),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Mamoutou",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Traore",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Mercredi",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black.withOpacity(0.8)
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "05/06/2024",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black.withOpacity(0.8)
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    shape: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff12343b).withOpacity(0.6)),
                    ),
                    children: [
                      // CONTAINER POUR ESSENCE
                      // VALEUR ARRIVER ET VALEUR DE DEPART
                      Container(
                        margin: EdgeInsets.only(top: 5 ,bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 170,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xff12343b).withOpacity(0.6), width: 0.5)
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
                                        "255650",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            letterSpacing: 1
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Text(
                                          "FCFA",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.orange
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
                                  border: Border.all(color: Color(0xff12343b).withOpacity(0.6), width: 0.5)
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
                                        "255000",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            letterSpacing: 1
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Text(
                                          "FCFA",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.orange
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
                      // CONSOMATION ET PRIX UNITER ET BUDGET OBTENU
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 110,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xff12343b).withOpacity(0.6), width: 0.5)
                              ),
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Consomation",
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
                                        "650",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            letterSpacing: 1
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Text(
                                          "FCFA",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.orange
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
                                  border: Border.all(color: Color(0xff12343b).withOpacity(0.6), width: 0.5)
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
                                        "860",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            letterSpacing: 1
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Text(
                                          "FCFA",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.orange
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
                                  border: Border.all(color: Color(0xff12343b).withOpacity(0.6), width: 0.5)
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
                                        "559000",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            letterSpacing: 1
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Text(
                                          "FCFA",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.orange
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
                      // MODIFIER SUPPRIMER ENREGISTRER
                      Container(
                        margin: EdgeInsets.only(bottom: 10, top: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Modifier",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff12343b),
                                  letterSpacing: 0.6
                              ),
                            ),
                            Text(
                              "Supprimer",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                  letterSpacing: 0.6
                              ),
                            ),
                            Text(
                              "Enregistre chez Admin",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff12343b),
                                  letterSpacing: 0.6
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    iconColor: Color(0xff12343b),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
ListView.builder(
      itemCount: budgetList.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Transform.translate(
                  offset: Offset(0, -20),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5 ,left: 15, right: 15),
                      width: double.infinity,
                      child: Card(
                        color: Color(0xFFDADADA),
                        elevation: 0.1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        "Budget obtenir par Amadou Guitteye",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10, right: 10),
                                    child: Text(
                                      budgetList[index].budgetObtenu,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff12343b),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.alarm,
                                            size: 12,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "Mercredi le 29/05/2024",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),

                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: Text(
                                          "Voir détails",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.red,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }
    );
 */
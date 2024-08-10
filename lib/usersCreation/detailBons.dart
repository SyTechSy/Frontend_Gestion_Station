import 'package:flutter/material.dart';

import '../models/bonModel.dart';

class SectionDetailBonsPage extends StatefulWidget {
  final BonModel bons;
  const SectionDetailBonsPage({super.key, required this.bons});

  @override
  State<SectionDetailBonsPage> createState() => _SectionDetailBonsPageState();
}

class _SectionDetailBonsPageState extends State<SectionDetailBonsPage> {

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
                //onTap: () => _confirmDelete(context, widget.devis.id!),
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
                        'Mon devis bons',
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
            // Destinataire
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
                                Text(
                                  "Destinataire",
                                  style: TextStyle(
                                      fontSize: 14
                                  ),
                                )
                              ],
                            ),
                            Text(
                              widget.bons.nomDestinataire,
                              style: TextStyle(
                                fontSize: 16,
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
            // Prix demander
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
                                Text(
                                  "Prix demander",
                                  style: TextStyle(
                                      fontSize: 14
                                  ),
                                )
                              ],
                            ),
                            Text(
                              widget.bons.prixDemander.toString(),
                              style: TextStyle(
                                fontSize: 16,
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
            // Motif
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
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Motif",
                                style: TextStyle(
                                    fontSize: 14
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                widget.bons.motif,
                                style: TextStyle(
                                    fontSize: 13
                                ),
                              ),
                            ],
                          ),
                        )
                      ),
                    ],
                  )
              ),
            ),

            SizedBox(height: 10),
            Text(
              widget.bons.dateAddBon.toString(),
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

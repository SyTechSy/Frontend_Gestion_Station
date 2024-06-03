import 'package:flutter/material.dart';

import '../add/choix_pour_devis.dart';
import 'essencePage.dart';
import 'gasoilPage.dart';

class AjouterDevis extends StatefulWidget {
  const AjouterDevis({super.key});

  @override
  State<AjouterDevis> createState() => _AjouterDevisState();
}

class _AjouterDevisState extends State<AjouterDevis> {

  int selectedIndex = 0;
  void selectedPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          //height: 60,
          margin: EdgeInsets.only(left: 15, right: 15),
          width: double.infinity,
          child: Card(
            color: Color(0xff12343b),
            elevation: 1.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Créer mon devis",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                        ),
                      ),
                      Text(
                        "Vous avez la possibilité de créer plusieurs devis.",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.white38
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChoixDevisPage()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 15.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0)

                    ),
                    child: Icon(
                        Icons.add
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 10),

        /*Padding(
          padding: EdgeInsets.all(15),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'User Name',
              hintText: 'Enter Your Name',
            ),
          ),
        ),*/
      ],
    );
  }
}
import 'package:flutter/material.dart';

class AjouterDevisGasoil extends StatelessWidget {
  const AjouterDevisGasoil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Color(0xff12343b),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 35, left: 15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 35, right: 35),
                  child: Text(
                    "Ajouter devis gasoil",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                ),

                Container(),
              ],
            ),
          ),

          PageChampsInput()
        ],
      ),
    );
  }
}

class PageChampsInput extends StatelessWidget {
  const PageChampsInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20.0, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Transform.translate(offset: Offset(0, 5),
                  child: Text(
                    "Valeur de d'arriver",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Saisissez le montant trouvé à votre arrivée',
              ),
            ),

            SizedBox(height: 20),

            Stack(
              children: [
                Transform.translate(offset: Offset(0, 5),
                  child: Text(
                    "Valeur de depart",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Saisissez le montant trouvé à votre départ',
              ),
            ),

            SizedBox(height: 20),

            Stack(
              children: [
                Transform.translate(offset: Offset(0, 5),
                  child: Text(
                    "Prix unité",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Saisissez le montant d\'unité gasoil',
              ),
            ),

            SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                child: Text(
                  "Calculer",
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1,
                      fontSize: 18
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff12343b),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        )
    );
  }
}
import 'package:flutter/material.dart';

class AdminGestionnairePage extends StatefulWidget {
  const AdminGestionnairePage({super.key});

  @override
  State<AdminGestionnairePage> createState() => _AdminGestionnairePageState();
}

class _AdminGestionnairePageState extends State<AdminGestionnairePage> {

  String _getGreeting() {
    var hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return "Bonjour,";
    } else if (hour >= 12 && hour < 16) {
      return "Bon après-midi,";
    } else {
      return "Bonsoir,";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff12343b),
        title: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_gas_station_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10,),
                      Row(
                        children: [
                          Text(
                            _getGreeting(),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Diakaridia Sy !',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            // NAME GESTIONNAIRE
            Center(
              child: Text(
                "Mes Gestionnaire",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              child: Card(
                color: Colors.white,
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(width: 1, color: Colors.black)
                ),
                child: ExpansionTile(
                  leading: CircleAvatar(backgroundImage: AssetImage("assets/logoHy.png")),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Amadou",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Quitteye",
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
                    // TITLE
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Essence",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: Color(0xff12343b)
                          ),
                        ),
                      ),
                    ),
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

                    // CONTAINER POUR GASOIL
                    // TITLE
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Gasoil",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: Color(0xff12343b)
                          ),
                        ),
                      ),
                    ),
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
                                      "720",
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
                                      "468000",
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
                  ],

                  iconColor: Color(0xff12343b),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              child: Card(
                color: Colors.white,
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(width: 1, color: Colors.black)
                ),
                child: ExpansionTile(
                  leading: CircleAvatar(backgroundImage: AssetImage("assets/logoHy.png")),
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
                    // TITLE
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Essence",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: Color(0xff12343b)
                          ),
                        ),
                      ),
                    ),
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

                    // CONTAINER POUR GASOIL
                    // TITLE
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Gasoil",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: Color(0xff12343b)
                          ),
                        ),
                      ),
                    ),
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
                                      "720",
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
                                      "468000",
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
                  ],

                  iconColor: Color(0xff12343b),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              child: Card(
                color: Colors.white,
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(width: 1, color: Colors.black)
                ),
                child: ExpansionTile(
                  leading: CircleAvatar(backgroundImage: AssetImage("assets/logoHy.png")),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Amara",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Diagaby",
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
                    // TITLE
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Essence",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: Color(0xff12343b)
                          ),
                        ),
                      ),
                    ),
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

                    // CONTAINER POUR GASOIL
                    // TITLE
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Gasoil",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: Color(0xff12343b)
                          ),
                        ),
                      ),
                    ),
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
                                      "720",
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
                                      "468000",
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
                  ],

                  iconColor: Color(0xff12343b),
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
Container(
        color: Colors.grey[200],
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                title: Text("Exemple title"),
                subtitle: Text("Exemple sous title"),
                trailing: Icon(Icons.arrow_forward_ios),
                leading: Icon(Icons.account_circle_rounded, size: 30),
                //contentPadding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
                //dense: true,
                //enabled: false,
                onTap: () {
                  print('onTap Pressed!');
                },
                onLongPress: () {
                  print('On long Pressed');
                },
              ),
            ),
          ],
        ),
      ),
 */
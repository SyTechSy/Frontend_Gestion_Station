import 'package:flutter/material.dart';
import 'package:frontend_gestion_station/stationPage/tab_bar_page.dart';

import 'ajouter_devis_page.dart';

class PageStation extends StatefulWidget {
  const PageStation({super.key});

  @override
  State<PageStation> createState() => _PageStationState();
}

class _PageStationState extends State<PageStation> {

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
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Color(0xff12343b),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 35, left: 15),
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
          ),
          //AjouterDevis(),
          TabBarPage(),
          //AjouterDevis(),
        ],
      ),
    );
  }
}




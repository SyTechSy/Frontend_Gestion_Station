import 'package:flutter/material.dart';
import 'package:frontend_gestion_station/stationPage/essencePage.dart';
import 'package:frontend_gestion_station/stationPage/gasoilPage.dart';

import '../add/choix_pour_devis.dart';


class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});
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
    return DefaultTabController(
      length: 2,
      child: Container(
        child: Scaffold(
          //backgroundColor: Color(0xFF303151).withOpacity(0.9),
          backgroundColor: const Color.fromARGB(118, 255, 255, 255),

          body: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  collapsedHeight: 120,
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: false,
                  //backgroundColor: Color(0xff12343b),
                  backgroundColor: Colors.white,
                  //expandedHeight: 0,

                  flexibleSpace: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.local_gas_station_rounded,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10,),
                            Row(
                              children: [
                                Text(
                                  _getGreeting(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Diakaridia Sy !',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          //height: 60,
                          margin: EdgeInsets.only(top: 10 ,left: 15, right: 15),
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
                      ],
                    ),
                  ),

                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(kToolbarHeight),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xffffffff).withOpacity(0.3),
                            Color(0xffffffff).withOpacity(0.5),
                            //Color(0xFF303151).withOpacity(1),
                          ], // Vos couleurs de dégradé
                        ),
                      ),
                      child: TabBar(

                        tabAlignment: TabAlignment.start,
                        isScrollable: true,
                        indicatorColor: Color(0xff12343b),
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: Color(0xff12343b),
                        unselectedLabelColor: Colors.black87,
                        tabs: [
                          Tab(child: Text("Essence")),
                          Tab(child: Text("Gasoil")),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                EssencePage(),
                GasoilPage(),
              ],
            ),
          ),

        ),
      ),
    );
  }
}

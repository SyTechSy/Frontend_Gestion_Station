import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../usersCreation/bons.dart';
import '../usersCreation/essence.dart';
import '../usersCreation/gasoil.dart';


class AccueilPage extends StatefulWidget {
  final int initialTabIndexx;

  const AccueilPage({super.key, this.initialTabIndexx = 0});

  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: widget.initialTabIndexx);
  }

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
      backgroundColor: const Color.fromARGB(118, 255, 255, 255),
      //backgroundColor: const Color(0xff12343b),
      body: NestedScrollView(
        headerSliverBuilder: (_, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              collapsedHeight: 80,
              automaticallyImplyLeading: false,
              pinned: true,
              floating: false,
              //backgroundColor: Colors.grey[350],
              backgroundColor: Colors.grey[300],
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
                          color: Color(0xff12343b),
                        ),
                        SizedBox(width: 10,),
                        Row(
                          children: [
                            Text(
                              _getGreeting(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Diakaridia Sy',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        /*Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (context) => SommePage()
                            ));
                          },
                          child: Icon(
                            Icons.calculate_outlined,
                            size: 25,
                            color: Color(0xff12343b),
                          ),
                        )*/
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Devis",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      )
                    ),
                  ],
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Container(
                  decoration: BoxDecoration(
                    /*gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xffffffff).withOpacity(0.6),
                        const Color(0xffffffff).withOpacity(0.9),
                      ],
                    ),*/
                  color: Colors.grey.withOpacity(0.0),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    indicatorColor: Color(0xff12343b),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Color(0xff12343b),
                    unselectedLabelColor: Colors.black87,
                    tabs: [
                      Tab(child: Text("Essence")),
                      Tab(child: Text("Gasoil")),
                      Tab(child: Text("Bons")),
                      //Tab(child: Text("Somme total")),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            //EssencePage(),
            //GasoilPage(),
            //SectionBon(),
            SectionEssence(),
            SectionGasoil(),
            SectionBons(),
            //SommePage(budgetObtenu: 0.0),
          ],
        ),
      ),
    );
  }
}

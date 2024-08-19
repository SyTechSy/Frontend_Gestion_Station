import 'dart:async';

import 'package:flutter/material.dart';

class SectonChoixMethodePage extends StatefulWidget {
  const SectonChoixMethodePage({super.key});

  @override
  State<SectonChoixMethodePage> createState() => _SectonChoixMethodePageState();
}

class _SectonChoixMethodePageState extends State<SectonChoixMethodePage> {
  int _nombreGestionnaires = 6;
  int _montantMensuel = 6000;
  int _montantAnnuel = 150000;
  final int _seuilMax = 30;
  bool _isMensuelSelected = true;
  bool _showPlusOne = false;
  Timer? _timer;

  void _selectMensuel() {
    setState(() {
      _isMensuelSelected = true;
    });
  }

  void _selectAnnuel() {
    setState(() {
      _isMensuelSelected = false;
    });
  }

  void _ajouterGestionnaire() {
    setState(() {
      if (_nombreGestionnaires < _seuilMax) {
        _nombreGestionnaires++;
        _montantMensuel += 2500;
        _montantAnnuel += 25000;
      } else {
        _nombreGestionnaires = 06;
        _montantMensuel = 15000;
        _montantAnnuel = 150000;
      }
      _showPlusOne = true;
    });

    _timer?.cancel();
    _timer = Timer(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _showPlusOne = false;
        });
      }
    });
  }

  String selectedState = 'Mensuel';

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 60, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Choisissez un plan",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                "Vous pouvez augmenter votre gestionnaire à votre choix de 06 jusqu'au 30 membres",
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  //color: Colors.red.shade100,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 1, color: Colors.green)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 48,
                        //color: Colors.red.shade200,
                        child: Row(
                          children: [
                            Icon(Icons.person, color: Colors.black),
                            SizedBox(width: 10),
                            Text(
                              "Gestionnaire",
                              style: TextStyle(color: Colors.black),
                            ),
                            Spacer(),
                            Text(
                              "$_nombreGestionnaires",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(border: Border.symmetric(horizontal: BorderSide(width: 0.2, color: Colors.grey.shade500))),
                      ),
                      Container(
                        width: double.infinity,
                        height: 48,
                        //color: Colors.blue.shade200,
                        child: GestureDetector(
                          onTap: _ajouterGestionnaire,
                          child: Row(
                            children: [
                              Icon(Icons.add, color: Colors.green),
                              SizedBox(width: 10),
                              Text(
                                "Ajouter un nouveau gestionnaire",
                                style: TextStyle(color: Colors.green),
                              ),
                              Spacer(),
                              if (_showPlusOne)
                                Text(
                                  "+1",
                                  style: TextStyle(color: Colors.green),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const
              Text(
                "Tous les mois ou chaque année ? C’est à vous de voir",
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              // MENSUEL
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                //height: 60,
                decoration: BoxDecoration(
                    color: selectedState == 'Mensuel'
                        ? Colors.green.shade50
                        : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    width: 1,
                    color: selectedState == 'Mensuel'
                        ? Colors.green
                        : Colors.black38,
                  )
                ),
                child:  ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                  title: Transform.translate(
                    offset: Offset(-16, 0),
                    child: Text(
                      'Mensuel',
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                  ),
                  subtitle: Transform.translate(
                    offset: Offset(-16, 0),
                    child: Row(
                      children: [
                        Text(
                          "${_montantMensuel / _nombreGestionnaires}f",
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.black45
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "/ mois",
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.black45
                          ),
                        ),

                      ],
                    ),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      "$_montantMensuel XOF / mois",
                      style: TextStyle(
                          fontSize: 13
                      ),
                    ),
                  ),
                  leading: Checkbox(
                    value: selectedState == 'Mensuel',
                    onChanged: (bool? value) {
                      setState(() {
                        selectedState = 'Mensuel';
                      });
                    },
                    shape: CircleBorder(),
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                    side: BorderSide(width: 1.5, color: Colors.black38),
                  ),
                  onTap: () {
                    setState(() {
                      selectedState = 'Mensuel';
                    });
                  },
                ),
              ),
              // ANNUEL
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                //height: 60,
                decoration: BoxDecoration(
                    color: selectedState == 'Annuel'
                        ? Colors.green.shade50
                        : Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      width: 1,
                      color: selectedState == 'Annuel'
                          ? Colors.green
                          : Colors.black38,
                    )
                ),
                child:  ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                  title: Transform.translate(
                    offset: Offset(-16, 0),
                    child: Text(
                      'Annuel',
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                  ),
                  subtitle: Transform.translate(
                    offset: Offset(-16, 0),
                    child: Row(
                      children: [
                        Text(
                          "${_montantAnnuel / _nombreGestionnaires}f",
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.black45
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "/ mois",
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.black45
                          ),
                        ),

                      ],
                    ),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      "$_montantAnnuel XOF / année",
                      style: TextStyle(
                          fontSize: 13
                      ),
                    ),
                  ),
                  leading: Checkbox(
                    value: selectedState == 'Annuel',
                    onChanged: (bool? value) {
                      setState(() {
                        selectedState = 'Annuel';
                      });
                    },
                    shape: CircleBorder(),
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                    side: BorderSide(width: 1.5, color: Colors.black38),
                  ),
                  onTap: () {
                    setState(() {
                      selectedState = 'Annuel';
                    });
                  },
                ),
              ),
              // PARTIE DE MODE DE PAIEMENT
              SectionModeDePaiement(),
            ],
          ),
        ),
      ),
    );
  }

}

class SectionModeDePaiement extends StatefulWidget {
  const SectionModeDePaiement({super.key});

  @override
  State<SectionModeDePaiement> createState() => _SectionModeDePaiementState();
}

class _SectionModeDePaiementState extends State<SectionModeDePaiement> {

  String selectedStatePaiement = 'Orange Money';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          const Text(
            "Mode de paiement",
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            //height: 60,
            decoration: BoxDecoration(
                color: selectedStatePaiement == 'Orange Money'
                    ? Colors.green.shade50
                    : Colors.black.withOpacity(0.0),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  width: 1,
                  color: selectedStatePaiement == 'Orange Money'
                      ? Colors.green
                      : Colors.black38,
                )
            ),
            child:  ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
              title: Transform.translate(
                offset: Offset(15, 0),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/logo/logo_orange_money.png",
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Orange Money',
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                  ],
                ),
              ),
              trailing: Checkbox(
                value: selectedStatePaiement == 'Orange Money',
                onChanged: (bool? value) {
                  setState(() {
                    selectedStatePaiement = 'Orange Money';
                  });
                },
                shape: CircleBorder(),
                activeColor: Colors.green,
                checkColor: Colors.white,
                side: BorderSide(width: 1.5, color: Colors.black38),
              ),
              onTap: () {
                setState(() {
                  selectedStatePaiement = 'Orange Money';
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            //height: 60,
            decoration: BoxDecoration(
                color: selectedStatePaiement == 'Sama Money'
                    ? Colors.green.shade50
                    : Colors.black.withOpacity(0.0),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  width: 1,
                  color: selectedStatePaiement == 'Sama Money'
                      ? Colors.green
                      : Colors.black38,
                )
            ),
            child:  ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
              title: Transform.translate(
                offset: Offset(15, 0),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/logo/logov2_sama.jpg",
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Sama Money',
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                  ],
                ),
              ),
              trailing: Checkbox(
                value: selectedStatePaiement == 'Sama Money',
                onChanged: (bool? value) {
                  setState(() {
                    selectedStatePaiement = 'Sama Money';
                  });
                },
                shape: CircleBorder(),
                activeColor: Colors.green,
                checkColor: Colors.white,
                side: BorderSide(width: 1.5, color: Colors.black38),
              ),
              onTap: () {
                setState(() {
                  selectedStatePaiement = 'Sama Money';
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            //height: 60,
            decoration: BoxDecoration(
                color: selectedStatePaiement == 'Moov Africa'
                    ? Colors.green.shade50
                    : Colors.black.withOpacity(0.0),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  width: 1,
                  color: selectedStatePaiement == 'Moov Africa'
                      ? Colors.green
                      : Colors.black38,
                )
            ),
            child:  ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
              title: Transform.translate(
                offset: Offset(15, 0),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/logo/Moov_Africa_logo_blue.png",
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Moov Africa',
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                  ],
                ),
              ),
              trailing: Checkbox(
                value: selectedStatePaiement == 'Moov Africa',
                onChanged: (bool? value) {
                  setState(() {
                    selectedStatePaiement = 'Moov Africa';
                  });
                },
                shape: CircleBorder(),
                activeColor: Colors.green,
                checkColor: Colors.white,
                side: BorderSide(width: 1.5, color: Colors.black38),
              ),
              onTap: () {
                setState(() {
                  selectedStatePaiement = 'Moov Africa';
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              child: Text(
                "Valider",
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
      ),
    );
  }
}



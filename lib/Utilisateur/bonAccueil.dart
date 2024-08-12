import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';

import '../EditPage/editBon.dart';
import '../add/bonAjouter.dart';
import '../models/bonModel.dart';
import '../models/utilisateurModel.dart';
import '../services/bonService.dart';
import '../services/utilisateurService.dart';

class AccueilBon extends StatefulWidget {
  //final UserModel utilisateur;
  const AccueilBon({super.key,});

  @override
  State<AccueilBon> createState() => _AccueilBonState();
}

class _AccueilBonState extends State<AccueilBon> {
  final _bonService = GetIt.instance<BonService>();
  final _utilisateurService = GetIt.instance<UtilisateurService>();
  bool isLoading = true;
  List<BonModel> bonStations = [];

  @override
  void initState() {
    super.initState();
    _fetchBons();
  }

  // Delete function
  Future<void> _deleteBon(int idBons) async {
    print('Tentative de suppression de l\'essence devis avec ID: $idBons');
    try {
      await _bonService.deleteBon(idBons);
      setState(() {
        bonStations.removeWhere((bon) => bon.idBon == idBons);
      });
      showSuccessMessage('Devis supprimé avec succès');
    } catch (e) {
      print('Erreur lors de la suppression de devis essence: $e');
      showErrorMessage('Erreur lors de la suppression de devis essence');
    }
  }

  // Function list
  Future<void> _fetchBons() async {
    try {
      UserModel? connectedUser = _utilisateurService.connectedUser;

      if (connectedUser != null) {
        int? idUser = connectedUser.idUser; // Récupérer l'ID de l'utilisateur connecté

        List<BonModel> bons = await _bonService.fetchBons(idUser!);
        setState(() {
          bonStations = bons;
        });

        // Ajout de logs pour vérifier les valeurs récupérées
        for (var bons in bonStations) {
          print('idBon: ${bons.idBon}');
          print('nomDestinataire: ${bons.nomDestinataire}');
          print('prixDemander: ${bons.prixDemander}');
          print('dateAddBon: ${bons.dateAddBon}');
          print('id: ${bons.idUser}');
          print('nomUtilisateur: ${bons.nomUtilisateur}');
          print('prenomUtilisateur: ${bons.prenomUtilisateur}');
        }
      } else {
        print('Aucun utilisateur connecté');
      }

    } catch (e) {
      print('Erreur lors du chargement des devis : $e');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //backgroundColor: Color(0xff12343b),
        backgroundColor: Colors.grey[350],
        title: Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(
                builder: (context) => AjouterBonPage(),
              ));
            },
            child: Container(
              child: Text(
                "Ajouter un bon",
                style: TextStyle(
                  color: Color(0xff12343b),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        //color: Colors.transparent,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Visibility(
          visible: isLoading,
          child: Center(child: CircularProgressIndicator()),
          replacement: RefreshIndicator(
            onRefresh: _fetchBons,
            child: ListView.builder(
                itemCount: bonStations.length,
                itemBuilder: (context, index) {
                  final bons = bonStations[index];
                  return Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Slidable(
                      endActionPane: ActionPane(
                          motion: StretchMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: Colors.green,
                              onPressed: (context) async {
                                final result = await Navigator.push(
                                    context, MaterialPageRoute(
                                    builder: (context) => EditBonPage(bonId: bons.idBon!, bon: bons)
                                ));
                                if (result != null) {
                                  setState(() {
                                    bonStations[index] = result;
                                  });
                                }
                              },
                              icon: Icons.edit,
                              label: 'Modifier',
                            ),
                            SlidableAction(
                              backgroundColor: Colors.red,
                              onPressed: (context) {
                                if (bons.idBon != null) {
                                  _deleteBon(bons.idBon!);
                                } else {
                                  print('Devis ID is null, cannot delete');
                                }
                              },
                              icon: Icons.delete,
                              label: 'Supprimer',
                            ),
                          ]),
                      child: Container(
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(5),
                          //color: Color(0xff12343b).withOpacity(0.3),
                          color: Colors.transparent,
                          border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.4), width: 0.2))
                        ),
                        width: double.maxFinite,
                        //height: 80,
                        //margin: EdgeInsets.only(top: 10),
                        //padding: EdgeInsets.only(left: 10, top: 8, bottom: 8),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, top: 8, bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Bon donner à :",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    bons.nomDestinataire,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff12343b),
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Prix demander est :",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          bons.prixDemander,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff12343b),
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Text(
                                        'FCFA',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xff12343b),
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Text(
                                  bons.dateAddBon.toString(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),
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





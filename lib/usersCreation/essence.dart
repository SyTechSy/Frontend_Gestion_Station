import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../EditPage/editDevisEssence.dart';
import '../models/devisStationModel.dart';
import '../models/utilisateurModel.dart';
import '../services/devisStationService.dart';
import '../services/utilisateurService.dart';
import 'detailEssence.dart';

class SectionEssence extends StatefulWidget {
  //final UserModel utilisateur;
  const SectionEssence({super.key});

  static double getLatestBudgetObtenu(List<DevisModel> devisStations) {
    if (devisStations.isNotEmpty) {
      return devisStations.last.budgetObtenu ?? 0.0;
    }
    return 0.0;
  }

  @override
  State<SectionEssence> createState() => _SectionEssenceState();
}

class _SectionEssenceState extends State<SectionEssence> {
  final _devisService = GetIt.instance<DevisService>();
  final _utilisateurService = GetIt.instance<UtilisateurService>();
  bool isLoading = true;
  List<DevisModel> devisStations = [];

  @override
  void initState() {
    super.initState();
    _fetchDevis();
    //_budgetController = TextEditingController(text: widget.budgetObtenu.toString());
  }

  Future<void> _saveBudget(double budget) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('budgetObtenu', budget);
  }

  Future<void> _deleteDevisEssence(int idDevis) async {
    print('Tentative de suppression de l\'essence devis avec ID: $idDevis');
    try {
      await _devisService.deleteDevisEssence(idDevis);
      setState(() {
        devisStations.removeWhere((devis) => devis.id == idDevis);
      });
      showSuccessMessage('Devis supprimé avec succès');
    } catch (e) {
      print('Erreur lors de la suppression de devis essence: $e');
      showErrorMessage('Erreur lors de la suppression de devis essence');
    }
  }

  // Fonction pour les listes d'User
  /*Future<void> _fetchDevis() async {
    try {
      List<DevisModel> devis = await _devisService.fetchDevis();
      setState(() {
        devisStations = devis;
      });

      // Ajout de logs pour vérifier les valeurs récupérées
      for (var devis in devisStations) {
        print('idUser: ${devis.id}');
        print('ValeurArriver: ${devis.valeurArriver}');
        print('ValeurDeDepart: ${devis.valeurDeDepart}');
        print('PrixUnité: ${devis.prixUnite}');
        print('Consommation: ${devis.consommation}');
        print('BudgetObtenu: ${devis.budgetObtenu}');
        print('dateAddDevis: ${devis.dateAddDevis}');
        print('id: ${devis.idUser}');
        print('nomUtilisateur: ${devis.nomUtilisateur}');
        print('prenomUtilisateur: ${devis.prenomUtilisateur}');
      }

    } catch (e) {
      print('Erreur lors du chargement des devis : $e');
    }
    setState(() {
      isLoading = false;
    });
  }*/
  Future<void> _fetchDevis() async {
    try {
      UserModel? connectedUser = _utilisateurService.connectedUser;

      if (connectedUser != null) {
        int? idUser = connectedUser.idUser; // Récupérer l'ID de l'utilisateur connecté

        List<DevisModel> devis = await _devisService.fetchDevis(idUser!);
        setState(() {
          devisStations = devis;
        });

        // Ajout de logs pour vérifier les valeurs récupérées
        for (var devis in devisStations) {
          print('idDevis: ${devis.id}');
          print('ValeurArriver: ${devis.valeurArriver}');
          print('ValeurDeDepart: ${devis.valeurDeDepart}');
          print('PrixUnité: ${devis.prixUnite}');
          print('Consommation: ${devis.consommation}');
          print('BudgetObtenu: ${devis.budgetObtenu}');
          print('dateAddDevis: ${devis.dateAddDevis}');
          print('id: ${devis.idUser}');
          print('nomUtilisateur: ${devis.nomUtilisateur}');
          print('prenomUtilisateur: ${devis.prenomUtilisateur}');
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
    return Transform.translate(
      offset: Offset(0, -30),
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 5),
        child: Visibility(
          visible: isLoading,
          child: Center(child: CircularProgressIndicator()),
          replacement: RefreshIndicator(
            onRefresh: _fetchDevis,
            child: ListView.builder(
                itemCount: devisStations.length,
                itemBuilder: (context, index) {
                  final devis = devisStations[index];
                  return Slidable(
                    endActionPane: ActionPane(
                        motion: StretchMotion(),
                        children: [
                          SlidableAction(
                            backgroundColor: Colors.green,
                            onPressed: (context) async {
                              final result = await Navigator.push(
                                context, MaterialPageRoute(
                                builder: (context) => ModifierDevisEssence(devisId: devis.id!, devis: devis,), // Passez le devisId ici
                              ),);
                              if (result != null) {
                                setState(() {
                                  devisStations[index] = result;
                                });
                              }
                            },
                            icon: Icons.edit,
                            label: 'Modifier',
                          ),
                          SlidableAction(
                            backgroundColor: Colors.red,
                            onPressed: (context) {
                              if (devis.id != null) {
                                _deleteDevisEssence(devis.id!);
                              } else {
                                print('Devis ID is null, cannot delete');
                              }
                            },
                            icon: Icons.delete,
                            label: 'Supprimer',
                          ),
                        ]),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => SectionDetailPage(devis: devis)
                        ));
                      },
                      child: Column(
                        children: [
                          ListTile(
                            leading: Container(
                              height: 17,
                              width: 17,
                              child: const CircleAvatar(
                                backgroundColor: Colors.black12,
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 8
                                  ),
                                ),
                              ),
                            ),
                            title: Transform.translate(
                              offset: Offset(-8, 0),
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                'Budget obtenu',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  devis.dateAddDevis.toString(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black.withOpacity(0.6),
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                Text(
                                  'XOP : ${devis.budgetObtenu.toString()}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff12343b),
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),

                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(width: 1, color: Colors.grey.withOpacity(0.1)))
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
              ),
          ),
        )
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


/*
  Container(
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 1, color: Colors.grey.withOpacity(0.1)))
                          ),
                          child: Card(
                            elevation: 0,
                            //color: Colors.black.withOpacity(0.2),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 17,
                                        width: 17,
                                        child: const CircleAvatar(
                                          backgroundColor: Colors.black12,
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 8
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 7),
                                      const Text(
                                        'Budget obtenu',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16
                                        ),
                                      ),
                                    ],
                                  ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'XOP : ',
                                            style: TextStyle(
                                                color: Color(0xff12343b),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            '${devis.budgetObtenu.toString()}',
                                            style: TextStyle(
                                                color: Color(0xff12343b),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      Transform.translate(
                                        offset: Offset(0, 2),
                                        child: Text(
                                          //"vendredi 19/07/2024 (23:30)",
                                          devis.dateAddDevis.toString(),
                                          style: TextStyle(
                                              color: Colors.black.withOpacity(0.5),
                                              fontSize: 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
 */
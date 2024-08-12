import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../EditPage/editDevisEssence.dart';
import '../EditPage/editDevisGasoil.dart';
import '../models/devisStationGasoilModel.dart';
import '../models/utilisateurModel.dart';
import '../services/devisStationGasoilService.dart';
import '../services/utilisateurService.dart';
import 'detailEssence.dart';
import 'detailGasoil.dart';

class SectionGasoil extends StatefulWidget {
  final UserModel utilisateur;
  const SectionGasoil({super.key, required this.utilisateur});

  @override
  State<SectionGasoil> createState() => _SectionGasoilState();
}

class _SectionGasoilState extends State<SectionGasoil> {
  final _devisGasoilService = GetIt.instance<DevisGasoilService>();
  final _utilisateurService = GetIt.instance<UtilisateurService>();
  bool isLoading = true;
  List<DevisGasoilModel> devisStationsGasoil = [];

  @override
  void initState() {
    super.initState();
    _fetchDevisGasoil();
  }

  Future<void> _saveBudget(double budget) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('budgetObtenu', budget);
  }


  // Suppression function
  Future<void> _deleteDevisGasoil(int idDevisG) async {
    print('Tentative de suppression de l\'essence devis avec ID: $idDevisG');
    try {
      await _devisGasoilService.deleteDevisGasoil(idDevisG);
      setState(() {
        devisStationsGasoil.removeWhere((devis) => devis.id == idDevisG);
      });
      showSuccessMessage('Devis gasoil supprimé avec succès');
    } catch (e) {
      print('Erreur lors de la suppression de devis gasoil : $e');
      showErrorMessage('Erreur lors de la suppression de devis gasoil');
    }
  }

  // List function
  Future<void> _fetchDevisGasoil() async {
    try {
      UserModel? connectedUser = _utilisateurService.connectedUser;

      if (connectedUser != null) {
        int? idUser = connectedUser.idUser; // Récupérer l'ID de l'utilisateur connecté

        List<DevisGasoilModel> devis = await _devisGasoilService.fetchDevis(idUser!);
        setState(() {
          devisStationsGasoil = devis;
        });

        // Ajout de logs pour vérifier les valeurs récupérées
        for (var devis in devisStationsGasoil) {
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
      print('Erreur lors du chargement des devis gasoil : $e');
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
              onRefresh: _fetchDevisGasoil,
              child: ListView.builder(
                  itemCount: devisStationsGasoil.length,
                  itemBuilder: (context, index) {
                    final devis = devisStationsGasoil[index];
                    return Slidable(
                      endActionPane: ActionPane(
                          motion: StretchMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: Colors.green,
                              onPressed: (context) async {
                                final result = await Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (context) => ModifierDevisGasoil(devisId: devis.id!, devis: devis), // Passez le devisId ici
                                ),
                                );
                                if (result != null) {
                                  setState(() {
                                    devisStationsGasoil[index] = result;
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
                                  _deleteDevisGasoil(devis.id!);
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
                              builder: (context) => SectionDetailGasoilPage(devis: devis, utilisateur: widget.utilisateur,)
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

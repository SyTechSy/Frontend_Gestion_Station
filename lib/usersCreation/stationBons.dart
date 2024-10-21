import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

import '../models/BonDuJourModel.dart';
import '../models/bonModel.dart';
import '../models/utilisateurModel.dart';
import '../services/BonDuJourService.dart';
import '../services/bonService.dart';
import '../services/utilisateurService.dart';
import 'detailStationBons.dart';

class SectionStationBons extends StatefulWidget {
  const SectionStationBons({super.key});

  @override
  State<SectionStationBons> createState() => _SectionStationBonsState();
}

class _SectionStationBonsState extends State<SectionStationBons> {
  final _bonService = GetIt.instance<BonService>();
  final _bonDuJourService = GetIt.instance<BonDuJourService>();
  final _utilisateurService = GetIt.instance<UtilisateurService>();

  bool isLoading = true;
  List<BonDuJourModel> bonDuJourStations = [];
  List<BonModel> bonStations = [];
  @override
  void initState() {
    super.initState();
    _fetchDevisBonDuJour();
  }

  // Fonction pour les listes d'User
  Future<void> _fetchDevisBonDuJour() async {
    try {
      UserModel? connectedUser = _utilisateurService.connectedUser;

      if (connectedUser != null) {
        int? idUser = connectedUser.idUser; // Récupérer l'ID de l'utilisateur connecté

        List<BonDuJourModel> bonsdujour = await _bonDuJourService.fetchBonDuJour(idUser!);
        setState(() {
          bonDuJourStations = bonsdujour;
        });

        // Ajout de logs pour vérifier les valeurs récupérées
        for (var bonsdujour in bonDuJourStations) {
          print('idDevis: ${bonsdujour.idUser}');
          print('Jour du bon: ${bonsdujour.dateAddBonDuJour}');
          print('id: ${bonsdujour.idUser}');
          print('nomUtilisateur: ${bonsdujour.nomUtilisateur}');
          print('prenomUtilisateur: ${bonsdujour.prenomUtilisateur}');
        }
      } else {
        print('Aucun utilisateur connecté');
      }

    } catch (e) {
      print('Erreur lors du chargement des bons du jours : $e');
    }
    setState(() {
      isLoading = false;
    });
  }

  // SUPPRESSION D'UN BON
  // Delete function
  Future<void> _deleteBonDuJour(int idBonDuJour) async {
    print('Tentative de suppression du bon du jour avec ID: $idBonDuJour');
    try {
      // Appel du service pour supprimer le bon du jour et ses bons associés
      await _bonDuJourService.deleteBonDuJour(idBonDuJour);
      setState(() {
        // Suppression du bon du jour et des bons associés de la liste locale
        bonDuJourStations.removeWhere((bondujour) => bondujour.idBonJour == idBonDuJour);
      });
      showSuccessMessage('Bon du jour et bons associés supprimés avec succès');
    } catch (e) {
      print('Erreur lors de la suppression du bon du jour et de ses bons associés: $e');
      showErrorMessage('Erreur lors de la suppression du bon du jour et de ses bons associés');
    }
  }

  String message = '';
  //BonModel? champsInBon;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -30),
      child: Container(
          child: Visibility(
            visible: isLoading,
            child: Center(child: CircularProgressIndicator()),
            replacement: RefreshIndicator(
              onRefresh: _fetchDevisBonDuJour,
              child: Visibility(
                visible: bonDuJourStations.isNotEmpty,
                replacement: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/AAAAMessage.svg",
                          width: 100,
                          height: 100,
                          color: Colors.black,
                        ),
                        /*Icon(
                        Icons.add_card_rounded,
                        size: 80,
                      ),*/
                        SizedBox(height: 20),
                        Text(
                          textAlign: TextAlign.center,
                          "Vous n'avez pas encore créé de devis essence",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.red
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          textAlign: TextAlign.center,
                          "Créez votre devis d'essence, et il s'affichera ici. Commencez dès maintenant.",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                child: ListView.builder(
                    itemCount: bonDuJourStations.length,
                    itemBuilder: (context, index) {
                      final bonsdujours = bonDuJourStations[index];
                      return Slidable(
                        endActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                backgroundColor: Colors.green,
                                onPressed: (context) async {},
                                icon: Icons.edit,
                                label: 'Modifier',
                              ),
                              SlidableAction(
                                backgroundColor: Colors.red,
                                onPressed: (context) {
                                  _deleteBonDuJour(bonsdujours.idBonJour!); // Utilisez bonsdujours.idBonJour pour accéder à l'ID correct
                                },
                                icon: Icons.delete,
                                label: 'Supprimer',
                              ),
                            ]),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => SectionDetailStationBons(
                                  dateAddBonDuJour: bonsdujours.dateAddBonDuJour,
                                  idBonDuJour: bonsdujours.idBonJour!,
                                )
                            ));
                          },
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  'Bon pour ${bonsdujours.dateAddBonDuJour}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                subtitle: Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  "Total : 50 000 Fcfa",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                trailing: Text(
                                  "6",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.6),
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                  ),
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

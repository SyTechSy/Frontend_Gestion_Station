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
  final _bonDuJourService = GetIt.instance<BonDuJourService>();
  final _utilisateurService = GetIt.instance<UtilisateurService>();

  bool isLoading = true;
  List<BonDuJourModel> bonDuJourStations = [];
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
          print('ValeurArriver: ${bonsdujour.dateAddBonDuJour}');
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

  String message = '';
  //BonModel? champsInBon;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -30),
      child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 5),
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
                          onPressed: (context) {},
                          icon: Icons.delete,
                          label: 'Supprimer',
                        ),
                      ]),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SectionDetailStationBons(dateAddBonDuJour: bonsdujours.dateAddBonDuJour)
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
                            "3",
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

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

import '../EditPage/editBon.dart';
import '../models/bonModel.dart';
import '../models/utilisateurModel.dart';
import '../services/bonService.dart';
import '../services/utilisateurService.dart';
import 'detailBons.dart';

class SectionBons extends StatefulWidget {
  const SectionBons({super.key});

  @override
  State<SectionBons> createState() => _SectionBonsState();
}

class _SectionBonsState extends State<SectionBons> {
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
      print('Erreur lors de la suppression de devis bonss: $e');
      showErrorMessage('Erreur lors de la suppression de devis bonssss');
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
          //print('nomDestinataire: ${bons.nomDestinataire}');
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
    return Transform.translate(
      offset: Offset(0, -30),
      child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 5),
          child: Visibility(
            visible: isLoading,
            child: Center(child: CircularProgressIndicator()),
            replacement: RefreshIndicator(
              onRefresh: _fetchBons,
              child: Visibility(
                visible: bonStations.isNotEmpty,
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
                        SizedBox(height: 20),
                        Text(
                          textAlign: TextAlign.center,
                          "Vous n'avez pas encore créé de bon",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.red
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          textAlign: TextAlign.center,
                          "Créez votre bon, et il s'affichera ici. Commencez dès maintenant.",
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
                    itemCount: bonStations.length,
                    itemBuilder: (context, index) {
                      final bons = bonStations[index];
                      return Slidable(
                        endActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                backgroundColor: Colors.green,
                                onPressed: (context) async {
                                  final result = await Navigator.push(
                                    context, MaterialPageRoute(
                                    builder: (context) => EditBonPage(bonId: bons.idBon!, bon: bons,), // Passez le devisId ici
                                  ),);
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
                                    print('Bons ID is null, cannot delete');
                                  }
                                },
                                icon: Icons.delete,
                                label: 'Supprimer',
                              ),
                            ]),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => SectionDetailBonsPage(bons: bons)
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
                                      'bons.nomDestinataire',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  subtitle: Transform.translate(
                                    offset: Offset(-8, 0),
                                    child: Text(
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        bons.motif
                                    ),
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        bons.dateAddBon.toString(),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black.withOpacity(0.6),
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      Text(
                                        'XOP : ${bons.prixDemander}',
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

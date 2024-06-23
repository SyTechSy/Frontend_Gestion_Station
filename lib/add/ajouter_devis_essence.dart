import 'package:flutter/material.dart';
import 'package:frontend_gestion_station/services/devisStationService.dart';
import 'package:get_it/get_it.dart';

import '../models/devisStationModel.dart';
import '../services/utilisateurService.dart';

class AjouterDevisEssence extends StatelessWidget {
  const AjouterDevisEssence({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Color(0xff12343b),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 35, left: 15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 35, right: 35),
                  child: Text(
                    "Ajouter devis essence",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                  ),
                ),

                Container(),
              ],
            ),
          ),

          PageChampsInput()
        ],

      ),
    );
  }
}

class PageChampsInput extends StatefulWidget {
  const PageChampsInput({super.key});

  @override
  State<PageChampsInput> createState() => _PageChampsInputState();
}

class _PageChampsInputState extends State<PageChampsInput> {
  final _devisService = GetIt.instance<DevisService>();
  final _utilisateurService = GetIt.instance<UtilisateurService>();
  final TextEditingController valeurArriverController = TextEditingController();
  final TextEditingController valeurDeDepartController = TextEditingController();
  final TextEditingController prixUniteController = TextEditingController();

  String message = '';
  DevisModel? champsInDevis;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20.0, left: 15, right: 15),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Transform.translate(offset: Offset(0, 5),
                    child: Text(
                      "Valeur de d'arriver",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              TextField(
                controller: valeurArriverController,
                decoration: InputDecoration(
                  hintText: 'Saisissez le montant trouvé à votre arrivée',
                ),
              ),
          
              SizedBox(height: 20),
          
              Stack(
                children: [
                  Transform.translate(offset: Offset(0, 5),
                    child: Text(
                      "Valeur de depart",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              TextField(
                controller: valeurDeDepartController,
                decoration: InputDecoration(
                  hintText: 'Saisissez le montant trouvé à votre départ',
                ),
              ),
          
              SizedBox(height: 20),
          
              Stack(
                children: [
                  Transform.translate(offset: Offset(0, 5),
                    child: Text(
                      "Prix unité",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              TextField(
                controller: prixUniteController,
                decoration: InputDecoration(
                  hintText: 'Saisissez le montant d\'unité d\'essence',
                ),
              ),

              SizedBox(height: 10),
              Text(message, style: TextStyle(color: Colors.red)),

              SizedBox(height: 20),
          
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    "Calculer",
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
                    onPressed: () async {
                      // Récupération des champs
                      String valeurArriverStr = valeurArriverController.text.trim();
                      String valeurDeDepartStr = valeurDeDepartController.text.trim();
                      String prixUniteStr = prixUniteController.text.trim();

                      // Convertir les chaînes en double
                      double? valeurArriver = double.tryParse(valeurArriverStr);
                      double? valeurDeDepart = double.tryParse(valeurDeDepartStr);
                      double? prixUnite = double.tryParse(prixUniteStr);

                      // Vérifier si la conversion a réussi
                      if (valeurArriver == null || valeurDeDepart == null || prixUnite == null) {
                        setState(() {
                          message = 'Erreur: veuillez entrer des valeurs numériques valides';
                        });
                        return;
                      }
                      if (valeurArriver <= valeurDeDepart) {
                        setState(() {
                          message = 'La valeur arriver doit être superieur a la valeur de depart';
                        });
                        return;
                      }

                      // obtenir l'ID de l'utilisateur connecté
                      int? idUser = _utilisateurService.connectedUser?.idUser;


                      if (idUser != null) {
                        // création d'un objet
                        DevisModel devis = DevisModel(
                          valeurArriver: valeurArriver,
                          valeurDeDepart: valeurDeDepart,
                          prixUnite: prixUnite,
                          idUser: idUser,
                        );

                        try {
                          champsInDevis = await _devisService.createDevis(devis);
                          print('Création de devis effectuée avec succès: $champsInDevis');
                          showSuccessMessage('Création avec succès');

                          if (champsInDevis != null && champsInDevis!.idDevis != null && champsInDevis!.idUser != null) {
                            setState(() {
                              message = 'Devis créé avec succès';
                            });

                            // Affichez les données de l'administrateur dans la console
                            print('Devis Station créé avec succès:');
                            print('ID: ${champsInDevis!.idDevis}');
                            print('Valeur Arriver: ${champsInDevis!.valeurArriver}');
                            print('Valeur De Depart: ${champsInDevis!.valeurDeDepart}');
                            print('Prix Unité: ${champsInDevis!.prixUnite}');
                            print('Consommation: ${champsInDevis!.consommation}');
                            print('Budget Obtenu: ${champsInDevis!.budgetObtenu}');
                            print('Date de création: ${champsInDevis!.dateAddDevis}');
                          } else {
                            setState(() {
                              message = 'Erreur: données de devis manquantes';
                            });
                          }
                        } catch (e) {
                          // Gérer les erreurs, par exemple email ou mot de passe incorrect
                          print('Erreur lors de la création de devis: $e');
                          showErrorMessage('Erreur de création de devis, vérifiez que les champs ne sont pas vides');
                          setState(() {
                            message = 'Erreur de création: vérifiez vos informations';
                          });
                        }
                      } else {
                        setState(() {
                          message = 'Erreur: utilisateur non connecté';
                        });
                      }
                    }


                ),
              ),
            ],
          ),
        )
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

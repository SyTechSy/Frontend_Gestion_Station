import 'package:flutter/material.dart';
import 'package:frontend_gestion_station/services/devisStationService.dart';
import 'package:get_it/get_it.dart';

import '../Utilisateur/AppHome.dart';
import '../Utilisateur/accueil.dart';
import '../Utilisateur/navBar.dart';
import '../models/devisStationModel.dart';
import '../models/utilisateurModel.dart';
import '../services/utilisateurService.dart';

  class AjouterDevisEssence extends StatelessWidget {
    final UserModel utilisateur;
  const AjouterDevisEssence({super.key, required this.utilisateur});

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

              PageChampsInput(utilisateur: utilisateur)
            ],

          ),
        );
  }
}

class PageChampsInput extends StatefulWidget {
    final UserModel utilisateur;
  const PageChampsInput({super.key, required this.utilisateur});

  @override
  State<PageChampsInput> createState() => _PageChampsInputState();
}

class _PageChampsInputState extends State<PageChampsInput> {
  final _devisService = GetIt.instance<DevisService>();
  final _utilisateurService = GetIt.instance<UtilisateurService>();

  final _valeurArriverController = TextEditingController();
  final _valeurDeDepartController = TextEditingController();
  final _prixUniteController = TextEditingController();

  bool isLoading = true;

  String message = '';
  DevisModel? champsInDevis;

  void _onAddDevis() async {
    String valeurArriverStr = _valeurArriverController.text.trim();
    String valeurDeDepartStr = _valeurDeDepartController.text.trim();
    String prixUniteStr = _prixUniteController.text.trim();

    double? valeurArriver = double.tryParse(valeurArriverStr);
    double? valeurDeDepart = double.tryParse(valeurDeDepartStr);
    double? prixUnite = double.tryParse(prixUniteStr);

    if (valeurArriver == null || valeurDeDepart == null || prixUnite == null) {
      setState(() {
        message = 'Erreur: veuillez entrer des valeurs numériques valides';
      });
      return;
    }
    if (valeurArriver <= valeurDeDepart) {
      setState(() {
        message = 'La valeur d\'arriver doit être supérieure à la valeur de départ';
      });
      return;
    }

    int? idUser = _utilisateurService.connectedUser?.idUser;
    String nomUtilisateur = _utilisateurService.connectedUser?.nomUtilisateur ?? 'N/A';
    String prenomUtilisateur = _utilisateurService.connectedUser?.prenomUtilisateur ?? 'N/A';

    double consommation = valeurArriver - valeurDeDepart;
    double budgetObtenu = consommation * prixUnite;
    DateTime dateAddDevis = DateTime.now();

    DevisModel devisstation = DevisModel(
        id: null,
        valeurArriver: valeurArriver,
        valeurDeDepart: valeurDeDepart,
        prixUnite: prixUnite,
        consommation: consommation,
        budgetObtenu: budgetObtenu,
        dateAddDevis: dateAddDevis,
        idUser: idUser,
        nomUtilisateur: nomUtilisateur,
        prenomUtilisateur: prenomUtilisateur
    );

    try {
      champsInDevis = await _devisService.createDevis(devisstation);

      if (idUser != null && champsInDevis != null && champsInDevis!.id != null) {
        setState(() {
          message = 'Devis créé avec succès';
        });

        print('Devis Station créé avec succès:');
        print('ID: ${champsInDevis!.id}');
        print('Valeur Arriver: ${champsInDevis!.valeurArriver}');
        print('Valeur De Depart: ${champsInDevis!.valeurDeDepart}');
        print('Prix Unité: ${champsInDevis!.prixUnite}');
        print('Consommation: ${champsInDevis!.consommation}');
        print('Budget Obtenu: ${champsInDevis!.budgetObtenu}');
        print('Date de création: ${champsInDevis!.dateAddDevis}');
        print('Id User: ${champsInDevis!.idUser}');
        print('Nom User: ${champsInDevis!.nomUtilisateur}');
        print('Prenom User: ${champsInDevis!.prenomUtilisateur}');
      } else {
        setState(() {
          message = 'Erreur: données de devis manquantes';
        });
      }

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => NavBarSection(
            utilisateur: widget.utilisateur,
            //initialTabIndexx: 0,
            //budgetObtenu: 0.0,
          ),
        ),
            (Route<dynamic> route) => false,
      );

    } catch (e) {
      print('Erreur lors de la création de devis: $e');
      showErrorMessage('Erreur de création de devis, vérifiez que les champs ne sont pas vides');
      setState(() {
        message = 'Erreur de récupérés devis: [] de création: vérifiez vos informations';
      });
    }
  }

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
                controller: _valeurArriverController,
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
                controller: _valeurDeDepartController,
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
                controller: _prixUniteController,
                decoration: InputDecoration(
                  hintText: 'Saisissez le montant d\'unité d\'essence',
                ),
              ),

              SizedBox(height: 10),
              //Text(messageSucces, style: TextStyle(color: Color(0xff12343b))),
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
                  onPressed: _onAddDevis,
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

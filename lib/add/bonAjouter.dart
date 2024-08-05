import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../Utilisateur/AppHome.dart';
import '../Utilisateur/bonAccueil.dart';
import '../Utilisateur/navBar.dart';
import '../models/bonModel.dart';
import '../services/bonService.dart';
import '../services/utilisateurService.dart';

class AjouterBonPage extends StatelessWidget {
  const AjouterBonPage({super.key});

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
                  margin: const EdgeInsets.only(top: 35, left: 15),
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
                    "Ajouter un bon",
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

          PageChampsInputAjouterBon()
        ],

      ),
    );
  }
}

class PageChampsInputAjouterBon extends StatefulWidget {
  const PageChampsInputAjouterBon({super.key});

  @override
  State<PageChampsInputAjouterBon> createState() => _PageChampsInputAjouterBonState();
}

class _PageChampsInputAjouterBonState extends State<PageChampsInputAjouterBon> {
  final _bonService = GetIt.instance<BonService>();
  final _utilisateurService = GetIt.instance<UtilisateurService>();

  final _nomDestinataireController = TextEditingController();
  final _prixDemanderController = TextEditingController();
  final _motifController = TextEditingController();
  bool isLoading = true;

  String message = '';
  BonModel? champsInBon;

  void _onAddBon() async {
    String nomDestinataire = _nomDestinataireController.text.trim();
    String prixDemander = _prixDemanderController.text.trim();
    String motif = _motifController.text.trim();

    int? idUser = _utilisateurService.connectedUser?.idUser;
    String nomUtilisateur = _utilisateurService.connectedUser?.nomUtilisateur ?? 'N/A';
    String prenomUtilisateur = _utilisateurService.connectedUser?.prenomUtilisateur ?? 'N/A';
    DateTime dateAddBon = DateTime.now();

    BonModel bonstation = BonModel(
        idBon: null,
        nomDestinataire: nomDestinataire,
        prixDemander: prixDemander,
        motif: motif,
        idUser: idUser,
        nomUtilisateur: nomUtilisateur,
        prenomUtilisateur: prenomUtilisateur,
        dateAddBon: dateAddBon
    );

    try {
      champsInBon = await _bonService.ajouterBon(bonstation);

      if (idUser != null && champsInBon != null && champsInBon!.idBon != null) {
        setState(() {
          message = 'Bon créé avec succès';
        });

        print('Bon créé avec succès:');
        print('Id Bon: ${champsInBon!.idBon}');
        print('Nom Destinataire: ${champsInBon!.nomDestinataire}');
        print('Prix Demander: ${champsInBon!.prixDemander}');
        print('Motif : ${champsInBon!.motif}');
        print('Date add bon: ${champsInBon!.dateAddBon}');
        print('Id User: ${champsInBon!.idUser}');
        print('Nom Utilisateur: ${champsInBon!.nomUtilisateur}');
        print('Prenom Utilisateur: ${champsInBon!.prenomUtilisateur}');
      } else {
        setState(() {
          message = 'Erreur: données de bon manquantes';
        });
      }

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const NavBarSection(
            //initialTabIndexx: 0,
            //budgetObtenu: 0.0,
          ),
        ),
            (Route<dynamic> route) => false,
      );

    } catch (e) {
      print('Erreur lors de la création de bon: $e');
      showErrorMessage('Erreur de création de bon, vérifiez que les champs ne sont pas vides');
      setState(() {
        message = 'Vérifiez vos informations, les champs ne doivent pas être vides';
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
                      "Nom destinataire",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              TextField(
                controller: _nomDestinataireController,
                decoration: InputDecoration(
                  hintText: 'Saisissez le nom de la personne',
                ),
              ),

              SizedBox(height: 20),

              Stack(
                children: [
                  Transform.translate(offset: Offset(0, 5),
                    child: Text(
                      "Prix à donner",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              TextField(
                controller: _prixDemanderController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Saisissez le prix donner à la personne',
                ),
              ),

              SizedBox(height: 20),

              Stack(
                children: [
                  Transform.translate(offset: Offset(0, 5),
                    child: Text(
                      "Motif",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        letterSpacing: 1
                      ),
                    ),
                  )
                ],
              ),
              TextField(
                controller: _motifController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'La raison de la demande de bon ...',
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
                  onPressed: _onAddBon,
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


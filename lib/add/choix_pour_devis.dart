import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/utilisateurModel.dart';
import '../services/utilisateurService.dart';
import 'ajouter_devis_essence.dart';
import 'ajouter_devis_gasoil.dart';

class ChoixDevisPage extends StatelessWidget {
  //final UserModel utilisateur;
  const ChoixDevisPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UtilisateurService utilisateurService = GetIt.instance<UtilisateurService>();
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
                    "Choix de devis",
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
          
          ImageStation(),
          ChoixDevisEssence(utilisateur: utilisateurService.connectedUser!),
          ChoixDevisGasoil(utilisateur: utilisateurService.connectedUser!),

          Container(
            margin: EdgeInsets.only(top: 15.0),
            child: Text(
              "Sélectionnez votre choix pour \najouter un devis",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

// IMAGE DE STATION
class ImageStation extends StatelessWidget {
  const ImageStation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100,bottom: 100),
      child: Center(
        child: Text(
          "image",
          style: TextStyle(
            fontSize: 50
          ),
        ),
      ),
    );
  }
}

// CHOIX DEVIS ESSENCE
class ChoixDevisEssence extends StatelessWidget {
  final UserModel utilisateur;
  const ChoixDevisEssence({super.key, required this.utilisateur});

  @override
  Widget build(BuildContext context) {

    final UtilisateurService utilisateurService = GetIt.instance<UtilisateurService>();
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AjouterDevisEssence()));
        },
        child: Card(
          color: Color(0xff12343b),
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: Text(
                "Devis essence",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// CHOIX DEVIS GASOIL
class ChoixDevisGasoil extends StatelessWidget {
  final UserModel utilisateur;
  const ChoixDevisGasoil({super.key, required this.utilisateur});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AjouterDevisGasoil()));
        },
        child: Card(
          color: Color(0xff12343b),
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: Text(
                "Devis gasoil",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

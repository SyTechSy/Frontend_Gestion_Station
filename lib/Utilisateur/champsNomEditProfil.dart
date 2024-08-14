import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/utilisateurModel.dart';
import '../services/utilisateurService.dart';

class ChampsEditNomProfil extends StatefulWidget {
  final UtilisateurService utilisateurService;
  final String field;
  const ChampsEditNomProfil({super.key, required this.utilisateurService, required this.field});

  @override
  State<ChampsEditNomProfil> createState() => _ChampsEditNomProfilState();
}

class _ChampsEditNomProfilState extends State<ChampsEditNomProfil> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    UserModel? user = widget.utilisateurService.connectedUser;
    if (widget.field == "nom") {
      _controller.text = user?.nomUtilisateur ?? "";
    } else if (widget.field == "prenom") {
      _controller.text = user?.prenomUtilisateur ?? "";
    } else if (widget.field == "email") {
      _controller.text = user?.emailUtilisateur ?? "";
    }
  }

  Future<void> _saveChanges() async {
    UserModel? user = widget.utilisateurService.connectedUser;
    if (user != null) {
      String url = "${widget.utilisateurService.baseUrl}/edit/user/${user.idUser}";
      Map<String, String> data = {};

      if (widget.field == "nom") {
        data['nomUtilisateur'] = _controller.text;
      } else if (widget.field == "prenom") {
        data['prenomUtilisateur'] = _controller.text;
      } else if (widget.field == "email") {
        data['emailUtilisateur'] = _controller.text;
      }

      // Utilise Dio ou http pour envoyer la requête PUT
      final response = await Dio().put(url, data: jsonEncode(data));

      if (response.statusCode == 200) {
        // Mise à jour du modèle local
        if (widget.field == "nom") {
          user.nomUtilisateur = _controller.text;
        } else if (widget.field == "prenom") {
          user.prenomUtilisateur = _controller.text;
        } else if (widget.field == "email") {
          user.emailUtilisateur = _controller.text;
        }

        // Retourner les données mises à jour à la page précédente
        Navigator.pop(context, user);
      } else {
        // Gérer l'erreur
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur de mise à jour")),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            child: Container(
              margin: EdgeInsets.only(top: 35, left: 10, right: 10),
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    TextButton(
                      onPressed: _saveChanges,
                      child: Text(
                        "Enregistre",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff12343b),
                          letterSpacing: 0.6
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Votre ${widget.field}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _controller,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  decoration: InputDecoration(
                    //labelText: "Ton ${widget.field}",
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff12343b).withOpacity(0.6)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    suffixIconConstraints: BoxConstraints(
                      minWidth: 30,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                  ),
                ),
                //SizedBox(height: 20),

              ],
            ),
          ),
        ],

      ),
    );
  }
}


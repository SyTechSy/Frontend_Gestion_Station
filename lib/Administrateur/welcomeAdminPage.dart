import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../main.dart';
import 'package:frontend_gestion_station/services/adminService.dart';
import 'package:frontend_gestion_station/models/adminModel.dart';
import 'package:frontend_gestion_station/Utilisateur/welcomePage.dart';
import 'package:get_it/get_it.dart';

import '../models/utilisateurModel.dart';
import '../resetPassword/resetKeyOnLigneAdmin/VerifEmailConnexionAdmin.dart';
import 'AdminAppHome.dart';

class WelcomeAdminPage extends StatefulWidget {
  final UserModel utilisateur;
  WelcomeAdminPage({super.key, required this.utilisateur});

  @override
  State<WelcomeAdminPage> createState() => _WelcomeAdminPageState();
}

class _WelcomeAdminPageState extends State<WelcomeAdminPage> {
  final _adminService = GetIt.instance<AdminService>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String message = '';
  AdminModel? loggedInAdmin;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff12343b).withOpacity(0.6),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Transform.translate(
              offset: Offset(-40, 50),
              child: Image.asset(
                "assets/sttt.png",
              ),
            ),
            Transform.translate(
              offset: Offset(110, -140),
              child: Column(
                children: [
                  Text(
                    "Bienvenu",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1),
                  ),
                  Text(
                    "sur la plateforme",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withOpacity(0.6),
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "NameApp",
                    style: TextStyle(
                        fontSize: 28,
                        color: Color(0xfff3a22e),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    "Je suis un gestionnaire ",
                    style: TextStyle(
                        fontSize: 16, color: Colors.white, letterSpacing: 0.5),
                  ),
                  Text(
                    "~",
                    style: TextStyle(
                        fontSize: 16, color: Colors.white, letterSpacing: 0.5),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  WelcomeUserPage(utilisateur: widget.utilisateur,)));
                    },
                    child: Text(
                      " Connectez-vous",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          letterSpacing: 0.5
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Connexion",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(0xfff3a22e),
                              letterSpacing: 0.5),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "administrateur",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.4),
                              letterSpacing: 0.5),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Form(
                      child: Column(
                        children: [
                          Container(
                            width: 250,
                            height: 60,
                            child: TextFormField(
                              controller: emailController,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.6)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.green), // Set your desired color
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: 250,
                            height: 60,
                            child: TextFormField(
                              controller: passwordController,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: 'Mot de passe',
                                hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.6)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.green), // Set your desired color
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Transform.translate(
                            offset: Offset(-65, 0),
                            child: Text(
                              "Mot de passe oublié?",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Transform.translate(
                            offset: Offset(-20, 0),
                            child: ElevatedButton(
                              onPressed: () async {
                                // Récupérer les valeurs des champs email et mot de passe
                                String emailAdmin = emailController.text.trim();
                                String motDePasse = passwordController.text.trim();

                                // Créer un objet AdminModel
                                AdminModel admin = AdminModel(emailAdmin: emailAdmin, motDePasse: motDePasse);

                                try {
                                  // Appeler la méthode de connexion de AdminService
                                  loggedInAdmin = await _adminService.loginAdmin(admin);

                                  if (loggedInAdmin != null && loggedInAdmin!.idAdmin != null) {
                                    setState(() {
                                      message = 'Admin connecté avec succès';
                                    });

                                    // Affichez les données de l'administrateur dans la console
                                    print('Admin connecté avec succès:');
                                    print('ID: ${loggedInAdmin!.idAdmin}');
                                    print('Nom: ${loggedInAdmin!.nomAdmin}');
                                    print('Prénom: ${loggedInAdmin!.prenomAdmin}');
                                    print('email: ${loggedInAdmin!.emailAdmin}');
                                    print('Password: ${loggedInAdmin!.motDePasse}');

                                    // Naviguer vers PageHeaderVerifEmail avec les paramètres requis
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PageHeaderVerifEmail(
                                          admin: loggedInAdmin!,
                                          emailAdmin: emailAdmin,
                                        ),
                                      ),
                                    );
                                  } else {
                                    setState(() {
                                      message = 'Erreur: données de l\'administrateur manquantes';
                                    });
                                  }
                                } catch (e) {
                                  // Gérer les erreurs, par exemple email ou mot de passe incorrect
                                  print('Erreur lors de la connexion: $e');

                                  // Mettre à jour l'état pour afficher un message d'erreur
                                  setState(() {
                                    message = 'Erreur de connexion: vérifiez vos informations';
                                  });
                                }
                              },

                              child: Text(
                                "Se connecter",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  letterSpacing: 1,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30.0),
                                    bottomRight: Radius.circular(30.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(message, style: TextStyle(color: Colors.green)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

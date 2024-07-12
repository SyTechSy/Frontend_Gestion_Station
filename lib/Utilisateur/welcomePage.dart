import 'package:flutter/material.dart';
import 'package:frontend_gestion_station/Administrateur/welcomeAdminPage.dart';
import 'package:frontend_gestion_station/models/utilisateurModel.dart';
import 'package:frontend_gestion_station/services/utilisateurService.dart';
import 'package:get_it/get_it.dart';

import 'AppHome.dart';


class WelcomeUserPage extends StatefulWidget {
  const WelcomeUserPage({super.key});

  @override
  State<WelcomeUserPage> createState() => _WelcomeUserPageState();
}

class _WelcomeUserPageState extends State<WelcomeUserPage> {
  final _utilisateurService = GetIt.instance<UtilisateurService>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String message = '';
  UserModel? loggedInUser;

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
                          letterSpacing: 1
                      ),
                    ),
                    Text(
                      "sur la plateforme",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withOpacity(0.6),
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "NameApp",
                      style: TextStyle(
                          fontSize: 28,
                          color: Color(0xfff3a22e),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Text(
                      "Je suis un administrateur ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          letterSpacing: 0.5
                      ),
                    ),
                    Text(
                      "~",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          letterSpacing: 0.5
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeAdminPage()));
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
                                letterSpacing: 0.5
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "utilisateur",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.4),
                                letterSpacing: 0.5
                            ),
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
                              child: TextField(
                                controller: emailController,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.6)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.green), // Set your desired color
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: 250,
                              height: 60,
                              child: TextField(
                                controller: passwordController,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  hintText: 'Mot de passe',
                                  hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.6)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.green), // Set your desired color
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
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
                                  String emailUtilisateur = emailController.text.trim();
                                  String motDePasse = passwordController.text.trim();

                                  int? idUser = _utilisateurService.connectedUser?.idUser;
                                  String nomUtilisateur = _utilisateurService.connectedUser?.nomUtilisateur ?? 'N/A';
                                  String prenomUtilisateur = _utilisateurService.connectedUser?.prenomUtilisateur ?? 'N/A';

                                  // Créer un objet AdminModel
                                  UserModel utilisateur = UserModel(
                                      idUser: idUser,
                                      emailUtilisateur: emailUtilisateur,
                                      motDePasse: motDePasse,
                                      nomUtilisateur: nomUtilisateur,
                                      prenomUtilisateur: prenomUtilisateur
                                  );

                                  try {
                                    // Appeler la méthode de connexion de UtilisateurService
                                    //UserModel loggedInUser = await _utilisateurService.loginUser(user);
                                    loggedInUser = await _utilisateurService.loginUtilisateur(utilisateur);

                                    if (loggedInUser != null && loggedInUser!.idUser != null) {
                                      setState(() {
                                        message = 'Utilisateur connecté avec succès';
                                      });

                                      // Affichez les données de l'administrateur dans la console
                                      print('User connecté avec succès:');
                                      print('ID: ${loggedInUser!.idUser}');
                                      print('Nom: ${loggedInUser!.nomUtilisateur}');
                                      print('Prénom: ${loggedInUser!.prenomUtilisateur}');
                                      print('Email Utilisateur: ${loggedInUser!.emailUtilisateur}');
                                      print('Mode Passe: ${loggedInUser!.motDePasse}');
                                    } else {
                                      setState(() {
                                        message = 'Erreur: données de l\'utilisateur manquantes';
                                      });
                                    }

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AppHomes(
                                            //initialTabIndexx: 0,
                                            //budgetObtenu: 0.0,
                                          )
                                      ),
                                    );
                                  } catch (e) {
                                    // Gérer les erreurs, par exemple email ou mot de passe incorrect
                                    print('Erreur Utilisateur lors de la connexion: $e');

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
        )
    );
  }
}

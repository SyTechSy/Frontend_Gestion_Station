import 'package:flutter/material.dart';
import 'package:frontend_gestion_station/Utilisateur/welcomePage.dart';
import 'package:frontend_gestion_station/models/utilisateurModel.dart';
import 'package:get_it/get_it.dart';

import '../services/utilisateurService.dart';
import 'changerPassword.dart';

class ProfilPageUtilisateur extends StatefulWidget {
  final UserModel utilisateur;
  const ProfilPageUtilisateur({super.key, required this.utilisateur});

  @override
  State<ProfilPageUtilisateur> createState() => _ProfilPageUtilisateurState();
}

class _ProfilPageUtilisateurState extends State<ProfilPageUtilisateur> {
  final utilisateurService = GetIt.instance<UtilisateurService>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDevis();
  }

  Future<void> _fetchDevis() async {
    try {
      UserModel? connectedUser = utilisateurService.connectedUser;

      if (connectedUser != null) {
        int? idUser = connectedUser.idUser; // Récupérer l'ID de l'utilisateur connecté

        // Récupérer l'utilisateur complet par son ID
        UserModel user = await utilisateurService.getUserById(idUser!);

        // Affichage des informations de l'utilisateur dans le terminal ou dans les logs
        print('Informations de l\'utilisateur:');
        print('id: ${user.idUser}');
        print('nomUtilisateur: ${user.nomUtilisateur}');
        print('prenomUtilisateur: ${user.prenomUtilisateur}');
        print('emailUtilisateur: ${user.emailUtilisateur}');
        print('motDePasse: ${user.motDePasse}');
        print('photoUrl: ${user.photoUrl}');
        // Affichez d'autres informations si nécessaire

      } else {
        print('Aucun utilisateur connecté');
      }
    } catch (e) {
      print('Erreur lors du chargement des profil!: $e');
    }
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    final utilisateur = widget.utilisateur;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff12343b),
        title: Center(
          child: Text(
            'Profil',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 15),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff12343b).withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 1,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(
                          image: AssetImage('assets/logoHy.png'),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color(0xff12343b),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              // INFORMATION PERSONNELS
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Information personnelle',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              // NOM
              Container(
                width: double.maxFinite,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xff12343b).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nom',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      utilisateur.nomUtilisateur ?? 'Aucun Nom',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              // PRENOM
              Container(
                width: double.maxFinite,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xff12343b).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Prénom',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      utilisateur.prenomUtilisateur ?? 'Aucun Nom',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              // EMAIL
              Container(
                width: double.maxFinite,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xff12343b).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      utilisateur.emailUtilisateur ?? 'Aucun Nom',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              // MOT DE PASSE
              Container(
                width: double.maxFinite,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xff12343b).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mot de passe',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      utilisateur.motDePasse ?? 'Aucun Nom',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              // DIVIDER
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Divider(
                  color: Color(0xff12343b).withOpacity(0.1),
                  height: 0.5,
                ),
              ),
              // AUTRES INFORMATIONS
              // Ajoutez ici d'autres informations si nécessaire

              // INFORMATION SUR LE DEV
              ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xff12343b).withOpacity(0.1),
                  ),
                  child: Icon(
                    Icons.info_outline,
                    color: Color(0xff12343b),
                    size: 16,
                  ),
                ),
                title: Text(
                  'Information sur le DEV',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                trailing: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: Color(0xff12343b),
                    size: 16,
                  ),
                ),
              ),
              // CHANGER VOTRE MOT DE PASS
              ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xff12343b).withOpacity(0.1),
                  ),
                  child: Icon(
                    Icons.key,
                    color: Color(0xff12343b),
                    size: 16,
                  ),
                ),
                title: Text(
                  'Changer votre mot de passe',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                trailing: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: Color(0xff12343b),
                      size: 16,
                    ),
                  ),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) => ChangerPasswordPage()
                  ));
                },
              ),
              // DECONNEXION
              ListTile(
                leading: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xff12343b).withOpacity(0.1),
                  ),
                  child: Icon(
                    Icons.exit_to_app,
                    color: Color(0xff12343b),
                    size: 16,
                  ),
                ),
                title: Text(
                  'Déconnectez-vous',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                  ),
                ),
                onTap: () async {
                  bool shouldLogout = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirmation'),
                        content: Text('Voulez-vous vraiment vous déconnecter ?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Annuler'),
                            onPressed: () {
                              Navigator.of(context).pop(false); // Retourner false si l'utilisateur annule
                            },
                          ),
                          TextButton(
                            child: Text('Déconnecter'),
                            onPressed: () {
                              Navigator.of(context).pop(true); // Retourner true si l'utilisateur confirme
                            },
                          ),
                        ],
                      );
                    },
                  );

                  if (shouldLogout == true) {
                    // Appeler la méthode de déconnexion
                    await utilisateurService.logout();

                    // Naviguer vers la page de connexion
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => WelcomeUserPage(utilisateur: widget.utilisateur)),
                    );
                  }
                },

              ),
            ],
          ),
        ),
      ),
    );
  }
}

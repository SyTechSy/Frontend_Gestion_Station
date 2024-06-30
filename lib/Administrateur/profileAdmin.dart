import 'package:flutter/material.dart';
import 'package:frontend_gestion_station/models/adminModel.dart';
import 'package:get_it/get_it.dart';

import '../models/utilisateurModel.dart';
import '../services/utilisateurService.dart';

class ProfilPageAdmin extends StatefulWidget {
  final AdminModel admin;
  const ProfilPageAdmin({super.key, required this.admin});

  @override
  State<ProfilPageAdmin> createState() => _ProfilPageAdminState();
}

class _ProfilPageAdminState extends State<ProfilPageAdmin> {
  @override
  Widget build(BuildContext context) {
    final admin = widget.admin;

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
                      admin.nomAdmin.toString(),
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
                      admin.prenomAdmin ?? 'Aucun Prenom',
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
                      admin.emailAdmin ?? 'Aucun Email',
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
                      admin.motDePasse ?? 'Aucun Mot de passe',
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
                onTap: () {
                  // Ajoutez ici la logique pour déconnecter l'administrateur
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

import '../models/utilisateurModel.dart';
import '../services/utilisateurService.dart';
import 'champsNomEditProfil.dart';

class ModifierProfilUserPage extends StatefulWidget {
  const ModifierProfilUserPage({super.key,});

  @override
  State<ModifierProfilUserPage> createState() => _ModifierProfilUserPageState();
}

class _ModifierProfilUserPageState extends State<ModifierProfilUserPage> {
  final utilisateurService = GetIt.instance<UtilisateurService>();
  late UserModel? user;

  @override
  void initState() {
    super.initState();
    user = utilisateurService.connectedUser;  // Utilisation correcte de la variable d'instance
  }

  Future<void> _navigateAndUpdate(String field) async {
    final updatedUser = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChampsEditNomProfil(
          utilisateurService: utilisateurService,  // Utilisation correcte de la variable d'instance
          field: field,
        ),
      ),
    );

    // Si l'utilisateur est mis à jour, actualiser l'état
    if (updatedUser != null) {
      setState(() {
        user = updatedUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff12343b),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, user);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: Transform.translate(
          offset: Offset(-30, 0),
          child: Text(
            "Modifier le profil",
            style: TextStyle(
                fontSize: 18,
                color: Colors.white
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Stack(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),

                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                        image: AssetImage('assets/logoHy.png'),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 120, // Ajuste la taille en fonction du rayon du CircleAvatar
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6), // Couleur sombre avec opacité
                    shape: BoxShape.circle,
                  ),
                ),
                Positioned(
                  top: 32, // Positionne l'icône au centre du CircleAvatar
                  left: 32,
                  child: IconButton(
                    icon: SvgPicture.asset(
                      "assets/svg/camera-rotate-svgrepo-com.svg",
                      width: 40,
                      height: 40,
                      color: Colors.white60,
                    ),
                    onPressed: () {
                      // Action pour changer la photo
                    },
                  ),
                ),
              ],
            ),

            TextButton(
              onPressed: () {},
              child: Text('Changer de photo'),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    "À propos de toi"
                ),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text(
                'Nom',
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              trailing: Text(
                user?.nomUtilisateur ?? "",
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              onTap: () {
                _navigateAndUpdate("nom");
              },
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text(
                'Prenom',
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              trailing: Text(
                user?.prenomUtilisateur ?? "",
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              onTap: () {
                _navigateAndUpdate("prenom");
              },
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(
                Icons.email, // L'icône que tu veux afficher
                color: Colors.black, // Couleur de l'icône
              ),
              title: Text(
                'E\'mail',
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              trailing: Text(
                user?.emailUtilisateur ?? "",
                style: TextStyle(
                    fontSize: 16
                ),
              ),
              onTap: () {
                _navigateAndUpdate("email");
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../services/utilisateurService.dart';
import 'createPasswordOnLigneUser.dart';

class VerifEmailResetNavBarOnLigneUser extends StatefulWidget {
  const VerifEmailResetNavBarOnLigneUser({super.key});

  @override
  State<VerifEmailResetNavBarOnLigneUser> createState() => _VerifEmailResetNavBarOnLigneUserState();
}

class _VerifEmailResetNavBarOnLigneUserState extends State<VerifEmailResetNavBarOnLigneUser> {
  final TextEditingController emailController = TextEditingController();
  final UtilisateurService utilisateurService = GetIt.I<UtilisateurService>();


  Future<void> _verifyEmail() async {
    String email = emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("L'email ne peut pas être vide."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Vérifier si l'email est valide
    bool emailExists = await utilisateurService.verifEmail(email);

    if (!emailExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email invalide ou non trouvé."),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreatePasswordNavBarOnLigneUser(email: email),
        ),
      );
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
              margin: EdgeInsets.only(top: 35, left: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 20,
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
                  "Vérification de l'e-mail",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Saisis ton email",
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff12343b).withOpacity(0.6)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    child: Text(
                      "Valider",
                      style: TextStyle(
                          color: Colors.white, letterSpacing: 1, fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff12343b),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _verifyEmail,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Valider votre identifiant unique pour créer un nouveau mot de passe.",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.9),
                      letterSpacing: 0.5,
                      fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

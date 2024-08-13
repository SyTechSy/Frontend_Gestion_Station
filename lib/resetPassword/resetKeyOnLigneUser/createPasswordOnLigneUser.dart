import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import '../../Utilisateur/changerPassword.dart';
import '../../Utilisateur/welcomePage.dart';
import '../../services/utilisateurService.dart';

class CreatePasswordNavBarOnLigneUser extends StatefulWidget {
  final String email;

  const CreatePasswordNavBarOnLigneUser({required this.email, super.key});

  @override
  State<CreatePasswordNavBarOnLigneUser> createState() => _CreatePasswordNavBarOnLigneUserState();
}

class _CreatePasswordNavBarOnLigneUserState extends State<CreatePasswordNavBarOnLigneUser> {
  bool _obscureText = true;
  final TextEditingController passwordController = TextEditingController();
  final utilisateurService = GetIt.I<UtilisateurService>();

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
                  "Créer un mot de passe",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  obscureText: _obscureText,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Saisis le mot de passe",
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff12343b).withOpacity(0.6)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    suffixIcon: IconButton(
                      icon: SvgPicture.asset(
                        _obscureText
                            ? 'assets/svg/eye_closed_leger.svg'
                            : 'assets/svg/eye_open_leger.svg',
                        width: 20,
                        height: 20,
                      ),
                      onPressed: _toggleVisibility,
                    ),
                    suffixIconConstraints: BoxConstraints(
                      minWidth: 30,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Ton mot de passe doit contenir :",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.9),
                      letterSpacing: 0.5,
                      fontSize: 14
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "8 caractère (20 maximum)",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 12
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "1 lettre et 1 chiffre",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 12
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "1 caratère spécial (par exemple : @ # ! & )",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 12
                  ),
                ),
                SizedBox(height: 20),
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
                    onPressed: () async {
                      String newPassword = passwordController.text.trim();
                      bool success = await utilisateurService.resetPassword(widget.email, newPassword);
                      if (success) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangerPasswordPage(),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Mot de passe réinitialisé avec succès.")),
                        );
                        // Vous pouvez rediriger l'utilisateur vers la page de connexion ici
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Échec de la réinitialisation du mot de passe.")),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../main.dart';
//import 'package:flutter/widgets.dart';
import 'package:frontend_gestion_station/services/adminService.dart';
import 'package:frontend_gestion_station/models/adminModel.dart';
import 'package:frontend_gestion_station/welcomePage.dart';
import 'package:get_it/get_it.dart';

import 'AdminAppHome.dart';



class WelcomeAdminPage extends StatefulWidget {
  WelcomeAdminPage({super.key});


  @override
  State<WelcomeAdminPage> createState() => _WelcomeAdminPageState();
}

class _WelcomeAdminPageState extends State<WelcomeAdminPage> {
  final _adminService = GetIt.instance<AdminService>();

  final _emailAdminController = TextEditingController();
  final _motDePasseController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailAdminController.dispose();
    _motDePasseController.dispose();
    super.dispose();
  }

  void _showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


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
                      "Je suis un gestionnaire ",
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomePage()));
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
                            "administrateur",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.4),
                                letterSpacing: 0.5
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 250,
                        height: 60,
                        child: TextFormField(
                          controller: _emailAdminController,
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
                        child: TextFormField(
                          controller: _motDePasseController,
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
                      SizedBox(height: 20),
                      Text(
                        "Mot de passe oublié?",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _isLoading ? null : () async {
                          setState(() {
                            _isLoading = true;
                          });

                          AdminModel newAdmin = AdminModel(
                            emailAdmin: _emailAdminController.text,
                            motDePasse: _motDePasseController.text
                          );

                          // Simulate a network call
                          await Future.delayed(Duration(seconds: 2));

                          // Redirigez vers ProfilPage
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AdminAppHomesPage()),
                          );*/

                          setState(() {
                            _isLoading = false;
                          });
                          /*try {
                            AdminModel loginedAdmin = await _adminService.loginAdmin(newAdmin);
                            print('Admin created: $loginedAdmin');
                            _showAlertDialog('Succès', 'Administrateur connecter avec succès!');
                          } catch (e) {
                            print('Error creating Admin: $e');
                            _showAlertDialog('Erreur', 'Échec de la connexion de admin.');
                          }*/
                        },
                        child: _isLoading ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ) : Text(
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
                              topRight: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
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

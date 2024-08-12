import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:frontend_gestion_station/services/adminService.dart';
import 'package:get_it/get_it.dart';
import '../../Administrateur/AdminAppHome.dart';
import '../../models/adminModel.dart';

class PageHeaderVerifEmail extends StatefulWidget {
  final String emailAdmin; // Ajout d'un paramètre pour récupérer l'email de l'admin
  final AdminModel admin;

  const PageHeaderVerifEmail({super.key, required this.emailAdmin, required this.admin});

  @override
  State<PageHeaderVerifEmail> createState() => _PageHeaderVerifEmailState();
}

class _PageHeaderVerifEmailState extends State<PageHeaderVerifEmail> {
  final _adminService = GetIt.instance<AdminService>();
  String? verificationCode;
  int _countdown = 20; // Initialisation du compte à rebours à 20 secondes
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Annulation du timer lorsque le widget est détruit
    super.dispose();
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Color(0xff12343b).withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      "Vérifie ton adresse e-mail",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Entrer votre code qui vous a été envoyé sur ",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      widget.emailAdmin, // Affichage de l'email administrateur
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      width: double.infinity,
                      child: Pinput(
                        length: 5,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                              border: Border.all(color: Colors.green)),
                        ),
                        onCompleted: (pin) {
                          setState(() {
                            verificationCode = pin; // Récupération du code saisi
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () async {
                        if (verificationCode != null) {
                          try {
                            bool isVerified = await _adminService.verifyAdmin(
                              widget.emailAdmin,
                              verificationCode!,
                            );

                            if (isVerified) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminAppHomesPage(admin: widget.admin)),
                                    (route) => false,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Code de vérification incorrect"),
                                ),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Erreur lors de la vérification"),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Veuillez entrer le code de vérification"),
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Text(
                          "Vérifier",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            letterSpacing: 1
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff12343b),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Renvoyer le code ",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${_countdown}s",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

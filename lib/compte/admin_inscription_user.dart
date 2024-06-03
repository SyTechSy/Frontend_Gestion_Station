import 'package:flutter/material.dart';
import 'custom_clipper.dart';

class InscriptionPage extends StatefulWidget {
  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  bool _isImageVisible = true;
  FocusNode _nomFocusNode = FocusNode();
  FocusNode _prenomFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _nomFocusNode.addListener(_onFocusChange);
    _prenomFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isImageVisible = !_nomFocusNode.hasFocus && !_prenomFocusNode.hasFocus;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFADC1B3),
      body: Stack(
        children: [
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.6,
            ),
          ),
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'Inscription User',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                if (_isImageVisible)
                  Image.asset(
                    'assets/logoHy.png',
                    height: 150,
                  ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "NOM",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextField(
                    focusNode: _nomFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Votre Nom ici',
                    ),
                  ),
                  SizedBox(height: 20),


                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "PRENOM",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextField(
                    focusNode: _prenomFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Votre Prénom ici',
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      // Handle login
                    },
                    child: Text(
                      "Inscrire",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff12343b),
                      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "En appuyant sur \"Inscrire\", l'email et le \nmot de passe de l'utilisateur sont \ngénérés automatiquement.",
                    style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'CreatePassworsOffLigneUser.dart';

class VerifEmailResetNavBarOffLigneUser extends StatelessWidget {
  const VerifEmailResetNavBarOffLigneUser({super.key});

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
          ChampsVerifEmailResetOffLigneUser(),
        ],
      ),
    );
  }
}

class ChampsVerifEmailResetOffLigneUser extends StatefulWidget {
  const ChampsVerifEmailResetOffLigneUser({super.key});

  @override
  State<ChampsVerifEmailResetOffLigneUser> createState() => _ChampsVerifEmailResetOffLigneUserState();
}

class _ChampsVerifEmailResetOffLigneUserState extends State<ChampsVerifEmailResetOffLigneUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Vérification de l'e-mail",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 10),
          TextField(
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              labelText: "Saisis votre email",
              labelStyle: TextStyle(
                color: Colors.black.withOpacity(0.6),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff12343b).withOpacity(0.6))
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green)
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Valider votre identifiant unique qui vous a été attribué, pour avoir un nouveau mot de passe.",
            style: TextStyle(
              color: Colors.black.withOpacity(0.9),
              letterSpacing: 0.5,
              fontSize: 14
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
                    color: Colors.white,
                    letterSpacing: 1,
                    fontSize: 18
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff12343b),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreatePasswordNavBarOffLigneUser(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

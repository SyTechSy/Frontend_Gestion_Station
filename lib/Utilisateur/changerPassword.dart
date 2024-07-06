import 'package:flutter/material.dart';

class ChangerPasswordPage extends StatelessWidget {
  const ChangerPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      children: [
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Color(0xff12343b),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 35, left: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 35, right: 35),
                child: Text(
                  "Changer le mot de passe",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white
                  ),
                ),
              ),

              Container(),
            ],
          ),
        ),

        //PageChampsInputChangerPassword()
        ConseilChangerPassword()
      ],

    ),
    );
  }
}

class ConseilChangerPassword extends StatelessWidget {
  const ConseilChangerPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, left: 10, right: 10),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Color(0xff12343b).withOpacity(0.2),
            borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 15.0),
                child: Text(
                  'Conseils pour le mot de passe',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Icon(
                        Icons.brightness_1_outlined, size: 8.0,
                      )
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        "Choisissez un mot de passe forte et eviter ton \nnumero de téléphone.",
                        style: TextStyle(
                          fontSize: 12
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Icon(
                          Icons.brightness_1_outlined, size: 8.0,
                        )
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        "Faites en sorte qu'il soit fasile à retenir pour vous, \net defficile à deviner pour les  autres.",
                        style: TextStyle(
                            fontSize: 12
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 15.0, bottom: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Icon(
                          Icons.brightness_1_outlined, size: 8.0,
                        )
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        "Ne partagez jamais votre mot de passe",
                        style: TextStyle(
                            fontSize: 12
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),

        PageChampsInputChangerPassword()
      ],
    );
  }
}

class PageChampsInputChangerPassword extends StatefulWidget {
  const PageChampsInputChangerPassword({super.key});

  @override
  State<PageChampsInputChangerPassword> createState() => _PageChampsInputChangerPasswordState();
}

class _PageChampsInputChangerPasswordState extends State<PageChampsInputChangerPassword> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Column(
            children: [
              Container(
                height: 60,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.6)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.green), // Set your desired color
                    ),
                    prefixIcon: Icon(
                      Icons.lock_outlined,
                      size: 20,
                    ),
                    hintText: "Mot de passe actuel"
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 60,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.6)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.green), // Set your desired color
                    ),
                    prefixIcon: Icon(
                      Icons.key,
                      size: 20,
                    ),
                    hintText: "Nouveau mot de passe"
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 60,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.6)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.green), // Set your desired color
                    ),
                    prefixIcon: Icon(
                      Icons.lock_open_outlined,
                      size: 20,
                    ),
                    hintText: "Confirmer le nouveau mot de passe"
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Enregistrer les modifications",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 0.8,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff12343b),
                    //padding: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Mot de passe oublié ?",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff12343b),
                ),
              ),
            ],
          ),
        )
    );
  }
}

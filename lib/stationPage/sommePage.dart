import 'package:flutter/material.dart';

class SommePage extends StatefulWidget {
  final double budgetObtenu;
  const SommePage({super.key, this.budgetObtenu = 0.0});

  @override
  State<SommePage> createState() => _SommePageState();
}

class _SommePageState extends State<SommePage> {
  late TextEditingController _sommeDevisController;

  @override
  void initState() {
    super.initState();
    _sommeDevisController = TextEditingController(text: widget.budgetObtenu.toString());
  }

  @override
  void dispose() {
    _sommeDevisController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.only(top: 20.0, left: 15, right: 15),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Transform.translate(offset: Offset(0, 5),
                      child: Text(
                        "Somme devis essence",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                TextField(
                  controller: _sommeDevisController,
                  decoration: InputDecoration(
                    hintText: 'Somme',
                  ),
                ),

                SizedBox(height: 20),

                Stack(
                  children: [
                    Transform.translate(offset: Offset(0, 5),
                      child: Text(
                        "Somme valeur de depart",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Somme',
                  ),
                ),

                SizedBox(height: 20),

                Stack(
                  children: [
                    Transform.translate(offset: Offset(0, 5),
                      child: Text(
                        "Somme total",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Somme',
                  ),
                ),

                SizedBox(height: 10),
                //Text(message, style: TextStyle(color: Colors.red)),

                SizedBox(height: 20),

                /*SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    "Modifier",
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
                  onPressed: () {},
                ),
              ),*/
              ],
            ),
          )
      ),
    );
  }
}

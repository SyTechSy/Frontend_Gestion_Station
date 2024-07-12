import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SommePage extends StatefulWidget {
  final double budgetEssence;
  final double budgetGasoil;
  const SommePage({super.key, this.budgetEssence = 0, this.budgetGasoil = 0});

  @override
  State<SommePage> createState() => _SommePageState();
}

class _SommePageState extends State<SommePage> {
  late TextEditingController _sommeDevisController;
  late TextEditingController _sommeDevisGasoilController;
  double _budgetEssence = 0.0;
  double _budgetGasoil = 0.0;

  @override
  void initState() {
    super.initState();
    //text: widget.budgetObtenu.toString()
    _sommeDevisController = TextEditingController(text: widget.budgetEssence.toString());
    _sommeDevisGasoilController = TextEditingController(text: widget.budgetGasoil.toString());
    _loadBudgets();
  }

  @override
  void dispose() {
    _sommeDevisController.dispose();
    _sommeDevisGasoilController.dispose();
    super.dispose();
  }

  Future<void> _loadBudgets() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _budgetEssence = prefs.getDouble('budgetObtenu') ?? 0.0;
      _budgetGasoil = prefs.getDouble('budgetObtenu') ?? 0.0;
    });
  }

  Future<void> _saveBudget(double budget) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('budgetObtenu', budget);
  }

  Future<void> _saveBudgetGasoil(double budget) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('budgetObtenu', budget);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //backgroundColor: Color(0xff12343b),
        backgroundColor: Colors.grey[350],
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xff12343b),
                size: 15,
              ),
            ),

             Container(
               margin: EdgeInsets.only(left: 10.0),
              child: Text(
                "Calculer la somme total",
                style: TextStyle(
                  color: Color(0xff12343b),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        )
      ),
      body: Container(
          margin: EdgeInsets.only(top: 10.0, left: 15, right: 15),
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
                  keyboardType: TextInputType.number,
                  controller: _sommeDevisController,
                  decoration: InputDecoration(
                    hintText: '$_budgetEssence',
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
                  keyboardType: TextInputType.number,
                  controller: _sommeDevisGasoilController,
                  decoration: InputDecoration(
                    hintText: '$_budgetGasoil',
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
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '${_budgetEssence + _budgetGasoil}',
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

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SommePage extends StatefulWidget {
  const SommePage({super.key});

  @override
  State<SommePage> createState() => _SommePageState();
}

class _SommePageState extends State<SommePage> {
  late TextEditingController _sommeDevisEssenceController;
  late TextEditingController _sommeDevisGasoilController;
  late TextEditingController _sommeTotalController;

  @override
  void initState() {
    super.initState();
    _sommeDevisEssenceController = TextEditingController();
    _sommeDevisGasoilController = TextEditingController();
    _sommeTotalController = TextEditingController();

    _loadValues();

    _sommeDevisEssenceController.addListener(_updateTotal);
    _sommeDevisGasoilController.addListener(_updateTotal);
  }

  Future<void> _loadValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _sommeDevisEssenceController.text = prefs.getString('sommeEssence') ?? '';
      _sommeDevisGasoilController.text = prefs.getString('sommeGasoil') ?? '';
      _updateTotal();
    });
  }

  Future<void> _saveValue(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> _clearFields() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _sommeDevisEssenceController.text = '';
      _sommeDevisGasoilController.text = '';
      _sommeTotalController.text = 'Total';
    });
    await prefs.setString('sommeEssence', '');
    await prefs.setString('sommeGasoil', '');
    await prefs.setString('sommeTotal', 'Total');
  }

  @override
  void dispose() {
    _sommeDevisEssenceController.dispose();
    _sommeDevisGasoilController.dispose();
    _sommeTotalController.dispose();
    super.dispose();
  }

  void _updateTotal() {
    double sommeDevisEssence = double.tryParse(_sommeDevisEssenceController.text) ?? 0;
    double sommeDevisGasoil = double.tryParse(_sommeDevisGasoilController.text) ?? 0;
    double total = sommeDevisEssence + sommeDevisGasoil;
    _sommeTotalController.text = total.toString();

    _saveValue('sommeEssence', _sommeDevisEssenceController.text);
    _saveValue('sommeGasoil', _sommeDevisGasoilController.text);
    _saveValue('sommeTotal', _sommeTotalController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[350],
        title: Row(
          children: [
            /*GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xff12343b),
                size: 15,
              ),
            ),*/
            Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Text(
                "Calculer la somme totale",
                style: TextStyle(
                  color: Color(0xff12343b),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.3,
                ),
              ),
            ),

            Spacer(),
            GestureDetector(
              onTap: _clearFields,
              child: Icon(
                Icons.auto_delete_outlined,
                size: 24,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Transform.translate(
                    offset: Offset(0, 5),
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
                controller: _sommeDevisEssenceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '0.0',
                ),
              ),
              SizedBox(height: 20),
              Stack(
                children: [
                  Transform.translate(
                    offset: Offset(0, 5),
                    child: Text(
                      "Somme devis gasoil",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              TextField(
                controller: _sommeDevisGasoilController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '0.0',
                ),
              ),
              SizedBox(height: 20),
              Stack(
                children: [
                  Transform.translate(
                    offset: Offset(0, 5),
                    child: Text(
                      "Somme totale",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              TextField(
                controller: _sommeTotalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Total',
                ),
                readOnly: true,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

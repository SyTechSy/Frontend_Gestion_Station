import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/devisStationModel.dart';
import '../services/devisStationService.dart';
import '../services/utilisateurService.dart';

class ModifierDevisEssence extends StatelessWidget {
  final int devisId;
  final DevisModel devis;
  const ModifierDevisEssence({super.key, required this.devisId, required this.devis});

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
                    "Modifier devis essence",
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

          PageChampsModifierInput(devisId: devisId, devis: devis,)
        ],

      ),
    );
  }
}

class PageChampsModifierInput extends StatefulWidget {
  final int devisId;
  final DevisModel devis;
  const PageChampsModifierInput({super.key, required this.devisId, required this.devis});

  @override
  State<PageChampsModifierInput> createState() => _PageChampsModifierInputState();
}

class _PageChampsModifierInputState extends State<PageChampsModifierInput> {
  final _devisService = GetIt.instance<DevisService>();
  final _utilisateurService = GetIt.instance<UtilisateurService>();

  late TextEditingController _valeurArriverController;
  late TextEditingController _valeurDeDepartController;
  late TextEditingController _prixUniteController;

  bool isLoading = true;

  String message = '';

  @override
  void initState() {
    super.initState();
    _valeurArriverController = TextEditingController(text: widget.devis.valeurArriver.toString());
    _valeurDeDepartController = TextEditingController(text: widget.devis.valeurDeDepart.toString());
    _prixUniteController = TextEditingController(text: widget.devis.prixUnite.toString());
  }

  @override
  void dispose() {
    _valeurArriverController.dispose();
    _valeurDeDepartController.dispose();
    _prixUniteController.dispose();
    super.dispose();
  }


  void _modifierDevisEssence() async {
    String valeurArriverStr = _valeurArriverController.text.trim();
    String valeurDeDepartStr = _valeurDeDepartController.text.trim();
    String prixUniteStr = _prixUniteController.text.trim();

    double? valeurArriver = double.tryParse(valeurArriverStr);
    double? valeurDeDepart = double.tryParse(valeurDeDepartStr);
    double? prixUnite = double.tryParse(prixUniteStr);

    if (valeurArriver == null || valeurDeDepart == null || prixUnite == null) {
      setState(() {
        message = 'Erreur: veuillez entrer des valeurs numériques valides';
        isLoading = false;
      });
      return;
    }
    if (valeurArriver <= valeurDeDepart) {
      setState(() {
        message = 'La valeur d\'arriver doit être supérieure à la valeur de départ';
      });
      return;
    }

    double consommation = valeurArriver - valeurDeDepart;
    double budgetObtenu = consommation * prixUnite;
    DateTime dateAddDevis = DateTime.now();

    // Assuming _utilisateurService.connectedUser is not null
    int? idUser = _utilisateurService.connectedUser?.idUser;
    String nomUtilisateur = _utilisateurService.connectedUser?.nomUtilisateur ?? 'N/A';
    String prenomUtilisateur = _utilisateurService.connectedUser?.prenomUtilisateur ?? 'N/A';

    final devis = DevisModel(
      valeurArriver: valeurArriver,
      valeurDeDepart: valeurDeDepart,
      prixUnite: prixUnite,
      consommation: consommation,
      budgetObtenu: budgetObtenu,
      dateAddDevis: dateAddDevis,
      idUser: idUser,
      nomUtilisateur: nomUtilisateur,
      prenomUtilisateur: prenomUtilisateur,
      id: widget.devisId, // assuming the id is being passed correctly
    );

    try {
      await _devisService.modifierDevisEssence(widget.devisId, devis);
      showSuccessMessage('Devis modifié avec succès');
      Navigator.pop(context);
      setState(() {
        isLoading = true;
      });// Navigate back after successful modification
    } catch (e) {
      print('Erreur lors de la modification du devis: $e');
      setState(() {
        message = 'Erreur lors de la modification du devis';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20.0, left: 15, right: 15),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Transform.translate(offset: Offset(0, 5),
                    child: Text(
                      "Valeur de d'arriver",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              TextField(
                controller: _valeurArriverController,
                decoration: InputDecoration(
                  hintText: 'Saisissez le montant trouvé à votre arrivée',
                ),
              ),

              SizedBox(height: 20),

              Stack(
                children: [
                  Transform.translate(offset: Offset(0, 5),
                    child: Text(
                      "Valeur de depart",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              TextField(
                controller: _valeurDeDepartController,
                decoration: InputDecoration(
                  hintText: 'Saisissez le montant trouvé à votre départ',
                ),
              ),

              SizedBox(height: 20),

              Stack(
                children: [
                  Transform.translate(offset: Offset(0, 5),
                    child: Text(
                      "Prix unité",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              TextField(
                controller: _prixUniteController,
                decoration: InputDecoration(
                  hintText: 'Saisissez le montant d\'unité d\'essence',
                ),
              ),

              SizedBox(height: 10),
              //Text(messageSucces, style: TextStyle(color: Color(0xff12343b))),
              Text(message, style: TextStyle(color: Colors.red)),

              SizedBox(height: 20),

              SizedBox(
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
                  onPressed: _modifierDevisEssence,
                ),
              ),
            ],
          ),
        )
    );
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
            color: Colors.white
        ),
      ),
      backgroundColor: Color(0xff12343b),
    );
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
  }
  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
            color: Colors.white
        ),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
  }
}

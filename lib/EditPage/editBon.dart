import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/bonModel.dart';
import '../services/bonService.dart';

class EditBonPage extends StatelessWidget {
  final int bonId;
  final BonModel bon;

  const EditBonPage({super.key, required this.bonId, required this.bon});

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
                  margin: const EdgeInsets.only(top: 35, left: 15),
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
                    "Modifier un bon",
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

          PageChampsInputModifierBon(bonId: bonId, bon: bon)
        ],

      ),
    );
  }
}

class PageChampsInputModifierBon extends StatefulWidget {
  final int bonId;
  final BonModel bon;

  const PageChampsInputModifierBon({super.key, required this.bonId, required this.bon});

  @override
  State<PageChampsInputModifierBon> createState() => _PageChampsInputModifierBonState();
}

class _PageChampsInputModifierBonState extends State<PageChampsInputModifierBon> {
  final _bonService = GetIt.instance<BonService>();
  late TextEditingController _nomDestinataireController;
  late TextEditingController _prixDemanderController;
  bool isLoading = true;

  String message = '';

  @override
  void initState() {
    super.initState();
    _nomDestinataireController = TextEditingController(text: widget.bon.nomDestinataire);
    _prixDemanderController = TextEditingController(text: widget.bon.prixDemander);
  }

  void _modifierBon() async {
    try {
      BonModel updatedBon = BonModel(
        idBon: widget.bon.idBon,
        nomDestinataire: _nomDestinataireController.text,
        prixDemander: _prixDemanderController.text,
        dateAddBon: widget.bon.dateAddBon,
        idUser: widget.bon.idUser,
        nomUtilisateur: widget.bon.nomDestinataire,
        prenomUtilisateur: widget.bon.prenomUtilisateur,
      );
      showSuccessMessage('Bon modifier avec succès');
      BonModel result = await _bonService.modifierBon(widget.bonId, updatedBon); // Utilisez le service pour appeler l'API
      Navigator.pop(context, result);
    } catch (e) {
      print('Error: $e');
      showSuccessMessage('Erreur de modification');
    }
  }

  @override
  void dispose() {
    _nomDestinataireController.dispose();
    _prixDemanderController.dispose();
    super.dispose();
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
                      "Nom destinataire",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              TextField(
                controller: _nomDestinataireController,
                decoration: InputDecoration(
                  hintText: 'Saisissez le nom de la personne',
                ),
              ),

              SizedBox(height: 20),

              Stack(
                children: [
                  Transform.translate(offset: Offset(0, 5),
                    child: Text(
                      "Prix à donner",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              TextField(
                controller: _prixDemanderController,
                decoration: InputDecoration(
                  hintText: 'Saisissez le prix donner à la personne',
                ),
              ),


              SizedBox(height: 10),
              //Text(message, style: TextStyle(color: Colors.red)),

              SizedBox(height: 10),

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
                  onPressed: _modifierBon,
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


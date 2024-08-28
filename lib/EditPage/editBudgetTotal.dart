import 'package:flutter/material.dart';
import 'package:frontend_gestion_station/models/budgetTotalModel.dart';
import 'package:get_it/get_it.dart';

import '../services/budgetTotalService.dart';
import '../services/utilisateurService.dart';


class ModifierBudgetTotal extends StatelessWidget {
  final int idBudgetTotal;
  final BudgetTotalModel budget;
  const ModifierBudgetTotal({super.key, required this.idBudgetTotal, required this.budget});

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
                    "Modifier budget total",
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

          PageChampsModifierBudgetInput(idBudgetTotal: idBudgetTotal, budget: budget,)
        ],

      ),
    );
  }
}


class PageChampsModifierBudgetInput extends StatefulWidget {
  final int idBudgetTotal;
  final BudgetTotalModel budget;
  const PageChampsModifierBudgetInput({super.key, required this.idBudgetTotal, required this.budget});

  @override
  State<PageChampsModifierBudgetInput> createState() => _PageChampsModifierBudgetInputState();
}

class _PageChampsModifierBudgetInputState extends State<PageChampsModifierBudgetInput> {
  final _budgetTotalService = GetIt.instance<BudgetTotalService>();
  final _utilisateurService = GetIt.instance<UtilisateurService>();

  late TextEditingController _budgetTotalEssenceController;
  late TextEditingController _budgetTotalGasoilController;
  late TextEditingController _argentRecuTravailController;

  bool isLoading = true;
  String message = '';

  @override
  void initState() {
    super.initState();
    _budgetTotalEssenceController = TextEditingController(text: widget.budget.budgetTotalEssence.toString());
    _budgetTotalGasoilController = TextEditingController(text: widget.budget.budgetTotalGasoil.toString());
    _argentRecuTravailController = TextEditingController(text: widget.budget.argentRecuTravail.toString());
  }

  @override
  void dispose() {
    _budgetTotalEssenceController.dispose();
    _budgetTotalGasoilController.dispose();
    _argentRecuTravailController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  void _onEditBudgetTotal() async {
    if (_formKey.currentState!.validate()) {
      String budgetTotalEssenceStr = _budgetTotalEssenceController.text.trim();
      String budgetTotalGasoilStr = _budgetTotalGasoilController.text.trim();
      String argentRecuTravailStr = _argentRecuTravailController.text.trim();

      double? budgetTotalEssence = double.tryParse(budgetTotalEssenceStr);
      double? budgetTotalGasoil = double.tryParse(budgetTotalGasoilStr);
      double? argentRecuTravail = double.tryParse(argentRecuTravailStr);

      int? idUser = _utilisateurService.connectedUser?.idUser;
      String nomUtilisateur = _utilisateurService.connectedUser?.nomUtilisateur ?? 'N/A';
      String prenomUtilisateur = _utilisateurService.connectedUser?.prenomUtilisateur ?? 'N/A';

      double finalBudgetTotalEssence = budgetTotalEssence ?? 0.0;
      double finalBudgetTotalGasoil = budgetTotalGasoil ?? 0.0;
      double finalArgentRecuTravail = argentRecuTravail ?? 0.0;

      double sommeTotalBudgets = finalBudgetTotalEssence + finalBudgetTotalGasoil;
      double perteArgent = finalArgentRecuTravail < sommeTotalBudgets
          ? finalArgentRecuTravail - sommeTotalBudgets
          : 0;
      double gainArgent = finalArgentRecuTravail >= sommeTotalBudgets
          ? finalArgentRecuTravail - sommeTotalBudgets
          : 0;

      DateTime dateAddBudgetTotal = DateTime.now();

      BudgetTotalModel budgetstation = BudgetTotalModel(
        //idBudgetTotal: null,
        budgetTotalEssence: finalBudgetTotalEssence,
        budgetTotalGasoil: finalBudgetTotalGasoil,
        sommeTotalBudgets: sommeTotalBudgets,
        argentRecuTravail: finalArgentRecuTravail,
        perteArgent: perteArgent,
        gainArgent: gainArgent,
        dateAddBudgetTotal: dateAddBudgetTotal,
        idUser: idUser,
        nomUtilisateur: nomUtilisateur,
        prenomUtilisateur: prenomUtilisateur,
        idBudgetTotal: widget.idBudgetTotal,
      );

      try {
        await _budgetTotalService.modifierBudgetTotal(widget.idBudgetTotal, budgetstation);
        // Renvoyer le budget modifié au parent
        Navigator.pop(context, budgetstation);
      } catch (e) {
        print('Erreur lors de la modification du budget total: $e');
        setState(() {
          message = 'Erreur lors de la modification du budget total station';
          isLoading = false;
        });
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, left: 15, right: 15),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _budgetTotalEssenceController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: "Total budget essence",
                labelStyle: TextStyle(color: Colors.black.withOpacity(0.8)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xff12343b).withOpacity(0.6)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer le budget essence';
                }
                if (double.tryParse(value) == null) {
                  return 'Veuillez entrer un nombre valide';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _budgetTotalGasoilController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: "Total budget gasoil",
                labelStyle: TextStyle(color: Colors.black.withOpacity(0.8)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xff12343b).withOpacity(0.6)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer le budget gasoil';
                }
                if (double.tryParse(value) == null) {
                  return 'Veuillez entrer un nombre valide';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _argentRecuTravailController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: "L'argent reçu",
                labelStyle: TextStyle(color: Colors.black.withOpacity(0.8)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: const Color(0xff12343b).withOpacity(0.6)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer l\'argent reçu';
                }
                if (double.tryParse(value) == null) {
                  return 'Veuillez entrer un nombre valide';
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            Text(message, style: const TextStyle(color: Color(0xff12343b))),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                child: Text(
                  "Enregistrer",
                  style: TextStyle(
                      color: Colors.white, letterSpacing: 1, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff12343b),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _onEditBudgetTotal,
              ),
            ),
          ],
        ),
      ),
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

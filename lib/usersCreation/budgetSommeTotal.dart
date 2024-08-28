import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frontend_gestion_station/models/budgetTotalModel.dart';
import 'package:frontend_gestion_station/services/budgetTotalService.dart';
import 'package:get_it/get_it.dart';

import '../EditPage/editBudgetTotal.dart';
import '../models/devisStationModel.dart';
import '../models/utilisateurModel.dart';
import '../services/devisStationService.dart';
import '../services/utilisateurService.dart';
import 'detailBudgetSommeTotal.dart';
import 'essence.dart';

class BudgetSommeTotal extends StatefulWidget {
  const BudgetSommeTotal({super.key});

  @override
  State<BudgetSommeTotal> createState() => _BudgetSommeTotalState();
}

class _BudgetSommeTotalState extends State<BudgetSommeTotal> {
  final _budgetTotalService = GetIt.instance<BudgetTotalService>();
  final _utilisateurService = GetIt.instance<UtilisateurService>();
  final _devisService = GetIt.instance<DevisService>();

  final _budgetTotalEssenceController = TextEditingController();
  final _budgetTotalGasoilController = TextEditingController();
  final _argentRecuTravailController = TextEditingController();


  final _formKey = GlobalKey<FormState>(); // Form key for validation

  String message = '';
  BudgetTotalModel? champsInBudgetTotal;

  void _onAddBudgetTotal() async {
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
        idBudgetTotal: null,
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
      );

      try {
        champsInBudgetTotal = await _budgetTotalService.createBudgetTotal(budgetstation);

        if (idUser != null && champsInBudgetTotal != null && champsInBudgetTotal!.idBudgetTotal != null) {
          setState(() {
            message = 'Budget Total créé avec succès';

            // Vider les champs après la validation et la soumission
            _budgetTotalEssenceController.clear();
            _budgetTotalGasoilController.clear();
            _argentRecuTravailController.clear();
          });
        } else {
          setState(() {
            message = 'Erreur: données de budget manquantes';
          });
        }
      } catch (e) {
        print('Erreur lors de la création de budget total: $e');
        showErrorMessage('Erreur de création de budget total, vérifiez que les champs ne sont pas vides');
        setState(() {
          message = 'Erreur de création: vérifiez vos informations';
        });
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Section de Auto Collage
  List<DevisModel> _devisStations = [];

  @override
  void initState() {
    super.initState();
    _fetchDevisStations();
  }

  void _fetchDevisStations() async {
    try {
      int? idUser = _utilisateurService.connectedUser?.idUser;
      if (idUser != null) {
        List<DevisModel> devisStations = await _devisService.fetchDevis(idUser);

        // Trier les devis par date de création, du plus récent au plus ancien
        devisStations.sort((a, b) => b.dateAddDevis.compareTo(a.dateAddDevis));

        setState(() {
          _devisStations = devisStations;
        });
      } else {
        print('ID utilisateur non disponible');
      }
    } catch (e) {
      print('Erreur lors de la récupération des devis: $e');
    }
  }


  void _autoFillBudget() {
    if (_devisStations.isNotEmpty) {
      // Récupérer le dernier devis (le plus récent)
      DevisModel latestDevis = _devisStations.first;
      double latestBudgetObtenu = latestDevis.budgetObtenu;

      setState(() {
        _budgetTotalEssenceController.text = latestBudgetObtenu.toString();
      });
    } else {
      print('Aucun devis disponible');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[350],
        title: Row(
          children: [
            Text(
              "Calculer la somme totale",
              style: TextStyle(
                color: Color(0xff12343b),
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap:  _autoFillBudget,
                    child: Text(
                      "Auto collage",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green
                      ),
                    ),
                  ),
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
                      contentPadding: const EdgeInsets.only(bottom: -5, top: -5),
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
                      contentPadding: const EdgeInsets.only(bottom: -5, top: -5),
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
                      contentPadding: const EdgeInsets.only(bottom: -5, top: -5),
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
                      onPressed: _onAddBudgetTotal,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Votre budgets créer",
              style: TextStyle(
                  color: Colors.black, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListBudgetSommeTotal(),
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

class ListBudgetSommeTotal extends StatefulWidget {
  const ListBudgetSommeTotal({super.key});

  @override
  State<ListBudgetSommeTotal> createState() => _ListBudgetSommeTotalState();
}

class _ListBudgetSommeTotalState extends State<ListBudgetSommeTotal> {
  final _budgetTotalService = GetIt.instance<BudgetTotalService>();
  final _utilisateurService = GetIt.instance<UtilisateurService>();
  bool isLoading = true;
  List<BudgetTotalModel> budgetTotalStation = [];

  @override
  void initState() {
    super.initState();
    _fetchBudgetTotal();
  }

  Future<void> _deleteBudgetTotal(int idBudget) async {
    print('Tentative de suppression de l\'essence devis avec ID: $idBudget');
    try {
      await _budgetTotalService.deleteBudgetTotal(idBudget);
      setState(() {
        budgetTotalStation.removeWhere((budget) => budget.idBudgetTotal == idBudget);
      });
      showSuccessMessage('Budget total supprimé avec succès');
    } catch (e) {
      print('Erreur lors de la suppression de budget total: $e');
      showErrorMessage('Erreur lors de la suppression de  station budget total');
    }
  }

  // FONCTION POUR LES LISTES DE BUDGET TOTAL
  Future<void> _fetchBudgetTotal() async {
    try {
      UserModel? connectedUser = _utilisateurService.connectedUser;

      if (connectedUser != null) {
        int? idUser = connectedUser.idUser; // Récupérer l'ID de l'utilisateur connecté

        List<BudgetTotalModel> budget = await _budgetTotalService.fetchBudgetTotal(idUser!);
        setState(() {
          budgetTotalStation = budget;
        });

        // Ajout de logs pour vérifier les valeurs récupérées
        for (var budget in budgetTotalStation) {
          print('idBudgetTotal: ${budget.idBudgetTotal}');
          print('budgetTotalEssence: ${budget.budgetTotalEssence}');
          print('budgetTotalGasoil: ${budget.budgetTotalGasoil}');
          print('sommeTotalBudgets: ${budget.sommeTotalBudgets}');
          print('argentRecuTravail: ${budget.argentRecuTravail}');
          print('perteArgent: ${budget.perteArgent}');
          print('gainArgent: ${budget.gainArgent}');
          print('dateAddBudgetTotal: ${budget.dateAddBudgetTotal}');
          print('id: ${budget.idUser}');
          print('nomUtilisateur: ${budget.nomUtilisateur}');
          print('prenomUtilisateur: ${budget.prenomUtilisateur}');
        }
      } else {
        print('Aucun utilisateur connecté pour afficher son budget');
      }

    } catch (e) {
      print('Erreur lors du chargement des budget total : $e');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
          onRefresh: _fetchBudgetTotal,
          child: ListView.builder(
            itemCount: budgetTotalStation.length,
            itemBuilder: (context, index) {
            final budget = budgetTotalStation[index];
            return Slidable(
            endActionPane: ActionPane(
                motion: StretchMotion(),
                children: [
                  SlidableAction(
                    backgroundColor: Colors.green,
                    onPressed: (context) async {
                      final result = await Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context) => ModifierBudgetTotal(idBudgetTotal: budget.idBudgetTotal!, budget: budget), // Passez le devisId ici
                      ),);
                      if (result != null) {
                        setState(() {
                          budgetTotalStation[index] = result;
                        });
                      }
                    },
                    icon: Icons.edit,
                    label: 'Modifier',
                  ),
                  SlidableAction(
                    backgroundColor: Colors.red,
                    onPressed: (context) {
                      if (budget.idBudgetTotal != null) {
                        _deleteBudgetTotal(budget.idBudgetTotal!);
                      } else {
                        print('Budget total ID is null, cannot delete');
                      }
                    },
                    icon: Icons.delete,
                    label: 'Supprimer',
                  ),
                ]),
            child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DetailBudgetSommeTotal(budget: budget )
              ));
            },
            child: Column(
              children: [
                ListTile(
                  /*leading: Container(
                    height: 50,
                    width: 50,
                    child: const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(
                        "assets/logo/profillllllll.png"
                      ),
                    ),
                  ),*/
                  title: Transform.translate(
                    offset: Offset(-8, 0),
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      '${budget.nomUtilisateur} ${budget.prenomUtilisateur}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  subtitle: Transform.translate(
                    offset: Offset(-8, 0),
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      budget.dateAddBudgetTotal.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${budget.sommeTotalBudgets.toString()} XOP',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${budget.perteArgent.toString()} XOP',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text('||'),
                          const SizedBox(width: 5),
                          Text(
                            '${budget.gainArgent.toString()} XOP',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1, color: Colors.grey.withOpacity(0.1)))
                  ),
                )
              ],
            ),
          ),
        );
      },
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

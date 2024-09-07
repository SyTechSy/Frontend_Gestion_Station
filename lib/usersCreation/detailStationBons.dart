import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

import '../Utilisateur/navBar.dart';
import '../models/bonModel.dart';
import '../models/utilisateurModel.dart';
import '../services/bonService.dart';
import '../services/utilisateurService.dart';

class SectionDetailStationBons extends StatefulWidget {
  const SectionDetailStationBons({super.key});

  @override
  State<SectionDetailStationBons> createState() => _SectionDetailStationBonsState();
}

class _SectionDetailStationBonsState extends State<SectionDetailStationBons> {
  bool _isAddingBon = false;

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
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 35, left: 15),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 35, right: 35),
                    child: Text(
                      "Liste",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),

          Expanded(
            child: ContenuSectionStationBons(),
          ),
        ],

      ),
    );
  }
}

class ContenuSectionStationBons extends StatefulWidget {
  const ContenuSectionStationBons({super.key});

  @override
  State<ContenuSectionStationBons> createState() => _ContenuSectionStationBonsState();
}

class _ContenuSectionStationBonsState extends State<ContenuSectionStationBons> {
  final _bonService = GetIt.instance<BonService>();
  final _utilisateurService = GetIt.instance<UtilisateurService>();

  final _nomDestinataireController = TextEditingController();
  final _prixDemanderController = TextEditingController();
  final _motifController = TextEditingController();
  bool isLoading = true;
  List<BonModel> bonStations = [];

  String message = '';
  BonModel? champsInBon;

  void _onAddBon() async {
    //String nomDestinataire = _nomDestinataireController.text.trim();
    String prixDemander = _prixDemanderController.text.trim();
    String motif = _motifController.text.trim();

    int? idUser = _utilisateurService.connectedUser?.idUser;
    String nomUtilisateur = _utilisateurService.connectedUser?.nomUtilisateur ?? 'N/A';
    String prenomUtilisateur = _utilisateurService.connectedUser?.prenomUtilisateur ?? 'N/A';
    DateTime dateAddBon = DateTime.now();

    BonModel bonstation = BonModel(
        idBon: null,
        //nomDestinataire: nomDestinataire,
        prixDemander: prixDemander,
        motif: motif,
        idUser: idUser,
        nomUtilisateur: nomUtilisateur,
        prenomUtilisateur: prenomUtilisateur,
        dateAddBon: dateAddBon
    );

    try {
      champsInBon = await _bonService.ajouterBon(bonstation);

      if (idUser != null && champsInBon != null && champsInBon!.idBon != null) {
        setState(() {
          message = 'Bon créé avec succès';
        });

        print('Bon créé avec succès:');
        print('Id Bon: ${champsInBon!.idBon}');
        //('Nom Destinataire: ${champsInBon!.nomDestinataire}');
        print('Prix Demander: ${champsInBon!.prixDemander}');
        print('Motif : ${champsInBon!.motif}');
        print('Date add bon: ${champsInBon!.dateAddBon}');
        print('Id User: ${champsInBon!.idUser}');
        print('Nom Utilisateur: ${champsInBon!.nomUtilisateur}');
        print('Prenom Utilisateur: ${champsInBon!.prenomUtilisateur}');
      } else {
        setState(() {
          message = 'Erreur: données de bon manquantes';
        });
      }

      /*Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) =>  NavBarSection(
            // utilisateur: utilisateurService.connectedUser!
            //initialTabIndexx: 0,
            //budgetObtenu: 0.0,
          ),
        ),
            (Route<dynamic> route) => false,
      );*/
      Navigator.pop(context, bonstation);

    } catch (e) {
      print('Erreur lors de la création de bon: $e');
      showErrorMessage('Erreur de création de bon, vérifiez que les champs ne sont pas vides');
      setState(() {
        message = 'Vérifiez vos informations, les champs ne doivent pas être vides';
      });
    }
  }

  void _addStationBons(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom
            ),
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Champ de texte avec icône
                  TextFormField(
                    controller: _prixDemanderController,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(
                          Icons.radio_button_unchecked
                      ),
                      //labelText: 'Le prix emprunté',
                      hintText: "Le prix emprunté",
                    ),
                  ),
                  //SizedBox(height: 20),
                  // Champ de texte pour "Motif du bon"
                  TextFormField(
                    controller: _motifController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xff12343b).withOpacity(0.1),
                      hintText: 'Motif du bon...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      child: Text(
                        "Enregistre",
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
                      onPressed: _onAddBon,
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
    );
  }

  String selectedState = 'payer';

  @override
  void initState() {
    super.initState();
    _fetchBons();
  }

  // Delete function
  Future<void> _deleteBon(int idBons) async {
    print('Tentative de suppression de l\'essence devis avec ID: $idBons');
    try {
      await _bonService.deleteBon(idBons);
      setState(() {
        bonStations.removeWhere((bon) => bon.idBon == idBons);
      });
      showSuccessMessage('Devis supprimé avec succès');
    } catch (e) {
      print('Erreur lors de la suppression de devis bonss: $e');
      showErrorMessage('Erreur lors de la suppression de devis bonssss');
    }
  }

  // Function list
  Future<void> _fetchBons() async {
    try {
      UserModel? connectedUser = _utilisateurService.connectedUser;

      if (connectedUser != null) {
        int? idUser = connectedUser.idUser; // Récupérer l'ID de l'utilisateur connecté

        List<BonModel> bons = await _bonService.fetchBons(idUser!);
        setState(() {
          bonStations = bons;
        });

        // Ajout de logs pour vérifier les valeurs récupérées
        for (var bons in bonStations) {
          print('idBon: ${bons.idBon}');
          //print('nomDestinataire: ${bons.nomDestinataire}');
          print('prixDemander: ${bons.prixDemander}');
          print('dateAddBon: ${bons.dateAddBon}');
          print('id: ${bons.idUser}');
          print('nomUtilisateur: ${bons.nomUtilisateur}');
          print('prenomUtilisateur: ${bons.prenomUtilisateur}');
        }
      } else {
        print('Aucun utilisateur connecté');
      }

    } catch (e) {
      print('Erreur lors du chargement des devis : $e');
    }
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 15, left: 10, right: 10),
          decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(5)
          ),
          child: ListTile(
            title: Text('Bon pour samedi'),
            trailing: Text(
              '200 000 XOP',
              style: TextStyle(
                  fontSize: 15
              ),
            ),
          ),
        ),
        Expanded(
          child: Visibility(
            visible: isLoading,
            child: Center(child: CircularProgressIndicator()),
            replacement: RefreshIndicator(
              onRefresh: _fetchBons,
              child: Visibility(
                  visible: bonStations.isNotEmpty,
                  replacement: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/AAAAMessage.svg",
                            width: 100,
                            height: 100,
                            color: Colors.black,
                          ),
                          SizedBox(height: 20),
                          Text(
                            textAlign: TextAlign.center,
                            "Vous n'avez pas encore créé de bon",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.red
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            textAlign: TextAlign.center,
                            "Créez votre bon, et il s'affichera ici. Commencez dès maintenant.",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                child: ListView.builder(
                    itemCount: bonStations.length,
                    itemBuilder: (context, index) {
                      final bons = bonStations[index];
                      return Container(
                        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        decoration: BoxDecoration(
                          //color: Colors.black12,
                            border: Border.all(color: Colors.black12, width: 1),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Transform.translate(
                                offset: Offset(-16, 0),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: selectedState == 'Payer',
                                      onChanged: (bool? value) {  },
                                      shape: CircleBorder(),
                                      activeColor: Colors.green,
                                      checkColor: Colors.white,
                                      side: BorderSide(width: 1.5, color: Colors.black38),
                                    ),
                                    Transform.translate(
                                      offset: Offset(-5, 0),
                                      child: Text(
                                        '${bons.prixDemander} Fcfa',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                bons.dateAddBon.toString(),
                                style: TextStyle(
                                    fontSize: 12
                                ),
                              )
                            ],
                          ),

                          subtitle: Text(
                            //maxLines: 2,
                              bons.motif,
                            //overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }
                )
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xff12343b)
          ),
          width: double.infinity,
          child: TextButton.icon(
            onPressed: () => _addStationBons(context),
            icon: Icon(
              Icons.add,
              size: 20,
              color: Colors.white,
            ),
            label: Text(
              'Ajouter un bon',
              style: TextStyle(
                color: Colors.white
              ),
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(10.0),
              backgroundColor: Colors.black12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
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

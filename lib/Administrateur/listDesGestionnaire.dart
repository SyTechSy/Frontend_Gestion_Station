import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../models/utilisateurModel.dart';
import '../services/utilisateurService.dart';

class ListGestionnairePage extends StatefulWidget {
  const ListGestionnairePage({super.key});

  @override
  State<ListGestionnairePage> createState() => _ListGestionnairePageState();
}

class _ListGestionnairePageState extends State<ListGestionnairePage> {
  final _utilisateurService = GetIt.instance<UtilisateurService>();
  bool isLoading = true;
  List<UserModel> utilisateurs = [];

  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }
  // Funtion pour les lists d'User
  Future<void> _fetchUsers() async {
    try {
      List<UserModel> users = await _utilisateurService.fetchUsers();
      setState(() {
        utilisateurs = users;

      });
    } catch (e) {
      print('Erreur lors du chargement des utilisateurs : $e');
    }
    setState(() {
      isLoading = false;
    });
  }
  // Function pour la suppression
  Future<void> _deleteUser(int idUser) async {
    try {
      await _utilisateurService.deleteUser(idUser);
      setState(() {
        utilisateurs.removeWhere((user) => user.idUser == idUser);
      });
      showSuccessMessage('Utilisateur supprimé avec succès');
    } catch (e) {
      print('Erreur lors de la suppression de l\'utilisateur : $e');
      showErrorMessage('Erreur lors de la suppression de l\'utilisateur');
    }
  }
  // Fonction pour envoyer un SMS
  /*void _sendSMS(String message, List<String> recipients) async {
    String result = await sendSMS(
      message: message,
      recipients: recipients,
    ).catchError((onError) {
      print(onError);
    });
    print(result);
  }*/
  // Fonction pour partager un utilisateur via SMS
  /*void _shareUser(UserModel utilisateur) {
    String message = 'Nom: ${utilisateur.nomUtilisateur}\n'
        'Prénom: ${utilisateur.prenomUtilisateur}\n'
        'Gestionnaire de service station';
    List<String> recipients = []; // Ajoutez des numéros de téléphone si nécessaire

    _sendSMS(message, recipients);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff12343b),
        title: Center(child: Text('Page ajout',style: TextStyle(color: Colors.white),)),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                  decoration: BoxDecoration(
                      color: Color(0xff12343b),
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Text(
                    'Mes Gestionnaires',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    child: Text(
                      'Ajouter',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff12343b),
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title: const Text("Inscription", style: TextStyle(fontSize: 18),),
                              content: Form(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "NOM",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        TextField(
                                          controller: _nomController,
                                          decoration: InputDecoration(
                                            hintText: 'Votre Nom ici',
                                          ),
                                        ),
                                        SizedBox(height: 20),

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "PRENOM",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        TextField(
                                          controller: _prenomController,
                                          decoration: InputDecoration(
                                            hintText: 'Votre Prénom ici',
                                          ),
                                        ),
                                        SizedBox(height: 30),
                                        ElevatedButton(
                                          onPressed: () async {

                                            UserModel newUser = UserModel(
                                                nomUtilisateur: _nomController.text,
                                                prenomUtilisateur: _prenomController.text
                                            );

                                            try {
                                              UserModel createdUser = await _utilisateurService.createUser(newUser);
                                              print('Creation de l\'utilisateur a été effectuer avec succès: $createdUser');
                                              showSuccessMessage('Creation avec succès');

                                              Navigator.pop(context);

                                              _nomController.text = '';
                                              _prenomController.text = '';

                                              setState(() {
                                                _fetchUsers();
                                              });

                                            } catch (e) {
                                              print('Erreur lors de la creation de l\'utilisateur: $e');
                                              showErrorMessage('Erreur de creation verifie que je champs ne sont pas vide');
                                            }

                                          },
                                          child: Text(
                                            "Inscrire",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xff12343b),
                                            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          "En appuyant sur \"Inscrire\", l'email et le \nmot de passe de l'utilisateur sont \ngénérés automatiquement.",
                                          style: TextStyle(
                                            fontSize: 13,
                                            letterSpacing: 0.5,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 60),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                      );
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: Visibility(
                visible: isLoading,
                child: Center(child: CircularProgressIndicator()),
                replacement: RefreshIndicator(
                  onRefresh: _fetchUsers,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5.0,
                      // crossAxisSpacing: 0.0,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: utilisateurs.length,
                    itemBuilder: (context, index) {
                      return buildGestionnaireCard(
                        // Afficher
                        nomUtilisateur: utilisateurs[index].nomUtilisateur!,
                        prenomUtilisateur: utilisateurs[index].prenomUtilisateur!,
                        // Supprimer
                        utilisateur: utilisateurs[index],
                      );
                    },
                  ),
                ),
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

  Widget buildGestionnaireCard({
    required String nomUtilisateur,
    required String prenomUtilisateur,
    required UserModel utilisateur
  }) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert),
                    onSelected: (String result) {
                      switch (result) {
                        case 'Modifier':
                        // Logique pour modifier
                          print('Modifier sélectionné');
                          break;
                        case 'Supprimer':
                          _deleteUser(utilisateur.idUser!);
                          print('Supprimer sélectionné');
                          break;
                        case 'Partager':
                          //_shareUser(utilisateur);
                          print('Partager sélectionné');
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'Modifier',
                        child: Text('Modifier'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Supprimer',
                        child: Text('Supprimer'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Partager',
                        child: Text('Partager'),
                      ),
                    ],
                  ),
                ],
              ),
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage("assets/logoHy.png"),
              ),
              SizedBox(height: 8),
              Text(
                '${utilisateur.nomUtilisateur} ${utilisateur.prenomUtilisateur}',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                'Gestionnaire de service station',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

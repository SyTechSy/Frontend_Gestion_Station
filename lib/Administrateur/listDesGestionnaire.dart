import 'dart:ui';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Gestionnaires'),
        ),
        body: GestionnairesPage(),
      ),
    );
  }
  
}
 
class GestionnairesPage extends StatefulWidget {
  const GestionnairesPage({super.key});

  @override
  State<GestionnairesPage> createState() => _GestionnairesPageState();
}

class _GestionnairesPageState extends State<GestionnairesPage> with SingleTickerProviderStateMixin {
  final _utilisateurService = GetIt.instance<UtilisateurService>();
  bool isLoading = true;
  List<UserModel> utilisateurs = [];

  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    _nomController.dispose();
    _prenomController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
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

  late AnimationController _controller;

  void _showBottomSheetAjoutUsers(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.grey[50],
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          child: Wrap(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20,),
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Création de gestionnaire",
                      style: TextStyle(
                        fontSize: 20,

                      ),
                    ),
                    const SizedBox(height: 20),
                    Form(
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
                                fontSize: 16,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff12343b),
                              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 12),
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
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section "Ajouter un Gestionnaire"
          GestureDetector(
            onTap: () => _showBottomSheetAjoutUsers(context),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return DashedBorder(
                  progress: _controller.value,
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    child: Center(
                      child: Icon(
                        Icons.person_add,
                        size: 40,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          // Titre "Les Gestionnaires"
          Text(
            'Tous les Gestionnaires',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 10),
          // Gestionnaire existant
          Expanded(
            child: Visibility(
              visible: isLoading,
              child: Center(child: CircularProgressIndicator()),
              replacement: RefreshIndicator(
                onRefresh: _fetchUsers,
                child: ListView.builder(
                  itemCount: utilisateurs.length,
                  itemBuilder: (context, index) {
                    return buildGestionnaireCard(
                      // Afficher
                      nomUtilisateur: utilisateurs[index].nomUtilisateur,
                      prenomUtilisateur: utilisateurs[index].prenomUtilisateur,
                      // Supprimer
                      utilisateur: utilisateurs[index],
                    );
                  }
                ),
              ),
            ),
          )
        ],
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
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.5, color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              '${utilisateur.nomUtilisateur} ${utilisateur.prenomUtilisateur}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            trailing: Transform.translate(
              offset: Offset(25, 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, size: 20, color: Colors.blue,),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, size: 20, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirmation"),
                            content: Text("Êtes-vous sûr de vouloir supprimer cet utilisateur ?"),
                            actions: <Widget>[
                              TextButton(
                                child: Text("Annuler"),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Ferme la boîte de dialogue
                                },
                              ),
                              TextButton(
                                child: Text("Confirmer"),
                                onPressed: () {
                                  _deleteUser(utilisateur.idUser!); // Appelle la méthode de suppression
                                  Navigator.of(context).pop(); // Ferme la boîte de dialogue
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 130,
            margin: EdgeInsets.only(left: 10, bottom: 10, right: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Color(0xff12343b).withOpacity(0.2)),
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage("assets/logo/image_icon_homme_femme.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class DashedBorder extends StatelessWidget {
  final Widget child;
  final double progress;

  DashedBorder({required this.child, required this.progress});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(progress),
      child: child,
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final double progress;

  DashedBorderPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(10)));

    final dashWidth = 5.0;
    final dashSpace = 5.0;
    double distance = (progress * (dashWidth + dashSpace)) % (dashWidth + dashSpace);

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        final extractPath = pathMetric.extractPath(
          distance,
          distance + dashWidth,
        );
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
      distance -= pathMetric.length;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


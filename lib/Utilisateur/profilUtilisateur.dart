import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend_gestion_station/Utilisateur/welcomePage.dart';
import 'package:frontend_gestion_station/models/utilisateurModel.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../services/utilisateurService.dart';
import 'changerPassword.dart';
import 'modifierProfilUtilisateur.dart';

class ProfilPageUtilisateur extends StatefulWidget {
  final UserModel utilisateur;
  const ProfilPageUtilisateur({super.key, required this.utilisateur});

  @override
  State<ProfilPageUtilisateur> createState() => _ProfilPageUtilisateurState();
}

class _ProfilPageUtilisateurState extends State<ProfilPageUtilisateur> {
  final utilisateurService = GetIt.instance<UtilisateurService>();
  late Future<UserModel> futureUser;
  late UserModel? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDevis();
    futureUser = _fetchUpdatedUser();
    user = utilisateurService.connectedUser;
  }

  Future<void> _navigateAndUpdate() async {
    final updatedUser = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ModifierProfilUserPage(),
      ),
    );

    // Si l'utilisateur est mis à jour, actualiser l'état
    if (updatedUser != null) {
      setState(() {
        user = updatedUser;
      });
    }
  }

  Future<UserModel> _fetchUpdatedUser() async {
    UserModel? connectedUser = utilisateurService.connectedUser;

    if (connectedUser != null) {
      int? idUser = connectedUser.idUser;
      // Récupérer l'utilisateur complet par son ID
      return await utilisateurService.getUserById(idUser!);
    } else {
      throw Exception('Utilisateur non connecté');
    }
  }

  Future<void> _fetchDevis() async {
    try {
      UserModel? connectedUser = utilisateurService.connectedUser;

      if (connectedUser != null) {
        int? idUser = connectedUser.idUser; // Récupérer l'ID de l'utilisateur connecté

        // Récupérer l'utilisateur complet par son ID
        UserModel user = await utilisateurService.getUserById(idUser!);

        // Affichage des informations de l'utilisateur dans le terminal ou dans les logs
        print('Informations de l\'utilisateur:');
        print('id: ${user.idUser}');
        print('nomUtilisateur: ${user.nomUtilisateur}');
        print('prenomUtilisateur: ${user.prenomUtilisateur}');
        print('emailUtilisateur: ${user.emailUtilisateur}');
        print('motDePasse: ${user.motDePasse}');
        print('photoUrl: ${user.photoUrl}');
        // Affichez d'autres informations si nécessaire

      } else {
        print('Aucun utilisateur connecté');
      }
    } catch (e) {
      print('Erreur lors du chargement des profil!: $e');
    }
    setState(() {
      isLoading = false;
    });
  }

  // Section la modification de Profil
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    final utilisateur = widget.utilisateur;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff12343b),
        title: Center(
          child: Text(
            'Profil',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            futureUser = _fetchUpdatedUser(); // Met à jour la Future pour actualiser les champs
          });
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 15),
            child: Column(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff12343b).withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 0,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: imageFile == null
                        ? Image.asset('assets/svg/avaProfil.png', height: 120.0, width: 120.0, fit: BoxFit.fill,)
                        : ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image.file(imageFile!, height: 120.0, width: 120.0, fit: BoxFit.fill,)
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(50, -30),
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xff12343b),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        Map<Permission, PermissionStatus> statuses = await [
                          Permission.storage, Permission.camera,
                        ].request();
                        if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                          showImagePicker(context);
                        } else {
                          print('no permission provided');
                        }
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                /*Stack(
                  children: [
                    imageFile == null
                        ? Image.asset('assets/logoHy.png', height: 140.0, width: 140.0,)
                        : ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image.file(imageFile!, height: 140.0, width: 140.0, fit: BoxFit.fill,)
                    ),
                    Positioned(
                      bottom: 5,
                      right: 0,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xff12343b),
                        ),
                        child: IconButton(
                          onPressed: () async {
                            Map<Permission, PermissionStatus> statuses = await [
                              Permission.storage, Permission.camera,
                            ].request();
                            if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                              showImagePicker(context);
                            } else {
                              print('no permission provided');
                            }
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        )
                      ),
                    ),
                    GestureDetector(
                      onTap: () ,
                      child: SvgPicture.asset(
                        "assets/svg/addIcon.svg",
                        width: 100,
                        height: 100,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),*/
                //const SizedBox(height: 25),
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    child: Text(
                      "Modifier le profil",
                      style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1,
                          fontSize: 16
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade50, // Couleur de fond
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.green, width: 0.5), // Bordure verte
                      ),
                      elevation: 0, // Enlève l'ombre
                    ),
                    onPressed: _navigateAndUpdate,
                  ),
                ),
                const SizedBox(height: 15),
                // INFORMATION PERSONNELS
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Information personnelle',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      futureUser = _fetchUpdatedUser(); // Recharger les données
                    });
                  },
                  child: FutureBuilder<UserModel>(
                    future: futureUser,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Erreur: ${snapshot.error}'));
                        } else if (!snapshot.hasData) {
                          return Center(child: Text('Aucune donnée disponible'));
                        } else {
                          final utilisateur = snapshot.data!;
                          return Column(
                            children: [
                              // NOM
                              Container(
                                width: double.maxFinite,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xff12343b).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Nom',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      user?.nomUtilisateur ?? 'Aucun Nom',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // PRENOM
                              Container(
                                width: double.maxFinite,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xff12343b).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Prénom',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      user?.prenomUtilisateur ?? 'Aucun Nom',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // EMAIL
                              Container(
                                width: double.maxFinite,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xff12343b).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Email',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      user?.emailUtilisateur ?? 'Aucun Nom',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // MOT DE PASSE
                              Container(
                                width: double.maxFinite,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xff12343b).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Mot de passe',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      utilisateur.motDePasse ?? 'Aucun Nom',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                      }
                  ),
                ),
                // DIVIDER
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Divider(
                    color: Color(0xff12343b).withOpacity(0.1),
                    height: 0.5,
                  ),
                ),
                // INFORMATION SUR LE DEV
                ListTile(
                  leading: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xff12343b).withOpacity(0.1),
                    ),
                    child: Icon(
                      Icons.info_outline,
                      color: Color(0xff12343b),
                      size: 16,
                    ),
                  ),
                  title: Text(
                    'Information sur le DEV',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  trailing: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: Color(0xff12343b),
                      size: 16,
                    ),
                  ),
                ),
                // CHANGER VOTRE MOT DE PASS
                ListTile(
                  leading: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xff12343b).withOpacity(0.1),
                    ),
                    child: Icon(
                      Icons.key,
                      color: Color(0xff12343b),
                      size: 16,
                    ),
                  ),
                  title: Text(
                    'Changer votre mot de passe',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  trailing: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: Color(0xff12343b),
                      size: 16,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context) => ChangerPasswordPage()
                    ));
                  },
                ),
                // DECONNEXION
                ListTile(
                  leading: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xff12343b).withOpacity(0.1),
                    ),
                    child: Icon(
                      Icons.exit_to_app,
                      color: Color(0xff12343b),
                      size: 16,
                    ),
                  ),
                  title: Text(
                    'Déconnectez-vous',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                  onTap: () async {
                    bool shouldLogout = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirmation'),
                          content: Text('Voulez-vous vraiment vous déconnecter ?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Annuler'),
                              onPressed: () {
                                Navigator.of(context).pop(false); // Retourner false si l'utilisateur annule
                              },
                            ),
                            TextButton(
                              child: Text('Déconnecter'),
                              onPressed: () {
                                Navigator.of(context).pop(true); // Retourner true si l'utilisateur confirme
                              },
                            ),
                          ],
                        );
                      },
                    );

                    if (shouldLogout == true) {
                      // Appeler la méthode de déconnexion
                      await utilisateurService.logout();

                      // Naviguer vers la page de connexion
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => WelcomeUserPage()),
                      );
                    }
                  },

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final picker = ImagePicker();

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder){
          return Card(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/5.2,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                          child: Column(
                            children: const [
                              Icon(Icons.image, size: 60.0,),
                              SizedBox(height: 12.0),
                              Text(
                                "Gallery",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              )
                            ],
                          ),
                          onTap: () {
                            _imgFromGallery();
                            Navigator.pop(context);
                          },
                        )),
                    Expanded(
                        child: InkWell(
                          child: SizedBox(
                            child: Column(
                              children: const [
                                Icon(Icons.camera_alt, size: 60.0,),
                                SizedBox(height: 12.0),
                                Text(
                                  "Camera",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            _imgFromCamera();
                            Navigator.pop(context);
                          },
                        ))
                  ],
                )),
          );
        }
    );
  }

  _imgFromGallery() async {
    await  picker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage(File(value.path));
      }
    });
  }

  _imgFromCamera() async {
    await picker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage(File(value.path));
      }
    });
  }

  _cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imgFile.path,
      //compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Image Cropper ok',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
          ],
        ),
        IOSUiSettings(
          title: 'Image Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio4x3,
          ],
        ),
        WebUiSettings(
          context: context,
          presentStyle: WebPresentStyle.dialog,
          size: const CropperSize(
            width: 520,
            height: 520,
          ),
        ),
      ]
    );

    if (croppedFile != null) {
      imageCache.clear();
      setState(() {
        imageFile = File(croppedFile.path);
      });
      // reload();
    }
  }




}

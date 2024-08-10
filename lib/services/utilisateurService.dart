import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:frontend_gestion_station/models/utilisateurModel.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UtilisateurService {
  final String baseUrl = 'http://10.0.2.2:8000';
  UserModel? _connectedUser;

  UserModel? get connectedUser => _connectedUser;

  Future<void> initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('connectedUser');
    if (userJson != null) {
      _connectedUser = UserModel.fromJson(jsonDecode(userJson));
    }
  }

  Future<UserModel> loginUtilisateur(UserModel utilisateur) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(utilisateur.toJson()),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData.containsKey('utilisateur')) {
        _connectedUser = UserModel.fromJson(responseData['utilisateur']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('connectedUser', jsonEncode(_connectedUser!.toJson())); // Sauvegarde de l'utilisateur connecté
        return _connectedUser!;
      }
    }
    throw Exception('Erreur de connexion');
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('connectedUser');
    _connectedUser = null;
  }

  // Creation des utilisateur
  Future<UserModel> createUser(UserModel user) async {
    // Vérifiez si le nomUtilisateur et prenomUtilisateur ne sont pas null
    final response = await http.post(
      Uri.parse('$baseUrl/add/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint(jsonDecode(response.body).toString());
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user');
    }
  }

  // List des utilisateur
  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(
        Uri.parse('$baseUrl/list/users')
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<UserModel> users = body.map((dynamic item) => UserModel.fromJson(item)).toList();
      print('Utilisateurs récupérés: $users');
      return users;
    } else {
      print('Erreur lors de la récupération des devis: ${response.statusCode}');
      throw Exception('Failed to load devis');
    }

  }

  // Suppression des utilisateur
  Future<void> deleteUser(int idUser) async {
    final response = await http.delete(
        Uri.parse('$baseUrl/delete/user/$idUser')
    );

    if (response.statusCode != 200) {
      print('Erreur lors de la suppression de l\'utilisateur : ${response.statusCode} - ${response.body}');
      throw Exception('Erreur lors de la suppression de l\'utilisateur');
    }
  }

  // Méthode pour récupérer les informations de l'administrateur par ID
  Future<UserModel> getUserById(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/profil/user/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erreur lors de la récupération de l\'utilisateur: ${response.statusCode}');
    }
  }

}


/*Future<UserModel> createUser(UserModel utilisateur) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(utilisateur.toJson()),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData.containsKey('user')) {
        // Affichez la réponse de l'API pour le débogage
        print('Réponse de l\'API: ${response.body}');

        // Traitez les données de l'administrateur ici
        UserModel user = UserModel.fromJson(responseData['admin']);

        // Par exemple, vous pouvez accéder à ses propriétés ainsi
        print('ID de l\'admin: ${user.id}');
        print('Nom de l\'admin: ${user.nomUtilisateur}');
        print('Prénom de l\'admin: ${user.prenomUtilisateur}');
        print('Email de l\'admin: ${user.emailUtilisateur}');
        print('Mot de passe de l\'admin: ${user.motDePasse}');
        print('PhotoUrl de l\'admin: ${user.photoUrl}');

        return user;
      } else {
        throw Exception('Données de l\'utilisateur manquantes dans la réponse');
      }
    } else {
      throw Exception('Erreur lors de la connexion: ${response.statusCode}');
    }
  }*/


/*Future<UserModel> loginUtilisateur(UserModel utilisateur) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(utilisateur.toJson()),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData.containsKey('utilisateur')) {
        // Affichez la réponse de l'API pour le débogage
        print('Réponse de l\'API: ${response.body}');

        // Traitez les données de l'administrateur ici
        UserModel utilisateur = UserModel.fromJson(responseData['utilisateur']);

        // Par exemple, vous pouvez accéder à ses propriétés ainsi
        print('ID de l\'utilisateur: ${utilisateur.idUser}');
        print('Nom de l\'utilisateur: ${utilisateur.nomUtilisateur}');
        print('Prénom de l\'utilisateur: ${utilisateur.prenomUtilisateur}');
        print('Email de l\'utilisateur: ${utilisateur.emailUtilisateur}');
        print('Mot de passe de l\'utilisateur: ${utilisateur.motDePasse}');
        print('Photo Url de l\'utilisateur: ${utilisateur.photoUrl}');

        return utilisateur;
      } else {
        throw Exception('Données de l\'Utilisateur manquantes dans la réponse');
      }
    } else {
      throw Exception('Erreur lors de la connexion utilisate: ${response.statusCode}');
    }
  }*/
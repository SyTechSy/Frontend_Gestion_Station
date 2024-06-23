
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:frontend_gestion_station/models/adminModel.dart';
import '../models/adminModel.dart';

class AdminService {
  final String baseUrl = 'http://10.0.2.2:8000';

  // SERVICE CONNEXION ADMIN
  /*Future<AdminModel> loginAdmin(AdminModel admin) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login/admin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(admin.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return AdminModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create Admin');
    }
  }*/

  Future<AdminModel> loginAdmin(AdminModel admin) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login/admin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(admin.toJson()),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData.containsKey('admin')) {
        // Affichez la réponse de l'API pour le débogage
        print('Réponse de l\'API: ${response.body}');

        // Traitez les données de l'administrateur ici
        AdminModel admin = AdminModel.fromJson(responseData['admin']);

        // Par exemple, vous pouvez accéder à ses propriétés ainsi
        print('ID de l\'admin: ${admin.idAdmin}');
        print('Nom de l\'admin: ${admin.nomAdmin}');
        print('Prénom de l\'admin: ${admin.prenomAdmin}');
        print('Email de l\'admin: ${admin.emailAdmin}');
        print('Mot de passe de l\'admin: ${admin.motDePasse}');

        return admin;
      } else {
        throw Exception('Données de l\'administrateur manquantes dans la réponse');
      }
    } else {
      throw Exception('Erreur lors de la connexion: ${response.statusCode}');
    }
  }


  // Méthode pour récupérer les informations de l'administrateur par ID
  Future<AdminModel> getAdminById(String idAdmin) async {
    final response = await http.get(
      Uri.parse('$baseUrl/profil/admin/$idAdmin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return AdminModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Échec de l\'obtention du profil administrateur');
    }
  }


}
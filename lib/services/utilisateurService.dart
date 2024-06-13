import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend_gestion_station/models/utilisateurModel.dart';


class UtilisateurService {
  final String baseUrl = 'http://10.0.2.2:9000/api/user';

  Future<UserModel> createUser(UserModel user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/ajouter'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user');
    }
  }
}

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/BonDuJourModel.dart';

class BonDuJourService {
  final String baseUrl = 'http://10.0.2.2:8000';

  // Ajouter une seul bon par jour
  Future<BonDuJourModel> ajouterBonDuJour(BonDuJourModel bonsdujours) async {
    try {
      final Map<String, dynamic> requestData = bonsdujours.toJson();
      print('Request Data: $requestData');

      final response = await http.post(
        Uri.parse('$baseUrl/add/bon/du/jour'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print('Response Data: $responseData');

        // Ensure responseData is a map and contains expected keys
        if (responseData is Map<String, dynamic>) {
          return BonDuJourModel.fromJson(responseData);
        } else {
          throw Exception('Invalid response data');
        }
      } else {
        print('Error: ${response.body}');
        throw Exception('Échec de la création de la réponse bon du jour');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Échec de la création de bon du jour de la station');
    }
  }

  // Liste de tout les bons du jours
  Future<List<BonDuJourModel>> fetchBonDuJour(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/list/bon/du/jour/$id'),
    );

    if (response.statusCode == 200) {
      debugPrint(jsonDecode(response.body).toString());
      List<dynamic> body = jsonDecode(response.body);
      List<BonDuJourModel> bons = body.map((dynamic item) => BonDuJourModel.fromJson(item)).toList();
      print('Bons du jour pour Station récupérés: $bons');
      return bons;
    } else if (response.statusCode == 404) {
      // Gérer le cas où l'utilisateur n'a pas créé de devis
      print('L\'utilisateur n\'a pas créé de bon du jour');
      return []; // Retourner une liste vide dans ce cas
    } else {
      // Gérer les autres codes d'erreur
      print('Erreur lors de la récupération des bon du jour de Station: ${response.statusCode}');
      throw Exception('Échec du chargement de bon du jour: ${response.statusCode}');
    }
  }
}
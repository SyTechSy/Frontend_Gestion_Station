import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/devisStationModel.dart';

class DevisService {
  final String baseUrl = 'http://10.0.2.2:8000';

  // Ajouter un devis
  Future<DevisModel> createDevis(DevisModel devis) async {
    try {
      final Map<String, dynamic> requestData = devis.toJson();
      print('Request Data: $requestData');

      final response = await http.post(
        Uri.parse('$baseUrl/add/devis'),
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
          return DevisModel.fromJson(responseData);
        } else {
          throw Exception('Invalid response data');
        }
      } else {
        print('Error: ${response.body}');
        throw Exception('Failed to create devis response');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to create devis station');
    }
  }

  // List des Devis
  Future<List<DevisModel>> fetchDevis(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/list/devis/$id'),
    );

    if (response.statusCode == 200) {
      debugPrint(jsonDecode(response.body).toString());
      List<dynamic> body = jsonDecode(response.body);
      List<DevisModel> devis = body.map((dynamic item) => DevisModel.fromJson(item)).toList();
      print('Devis Station récupérés: $devis');
      return devis;
    } else if (response.statusCode == 404) {
      // Gérer le cas où l'utilisateur n'a pas créé de devis
      print('L\'utilisateur n\'a pas créé de devis');
      return []; // Retourner une liste vide dans ce cas
    } else {
      // Gérer les autres codes d'erreur
      print('Erreur lors de la récupération des devis Station: ${response.statusCode}');
      throw Exception('Failed to load devis: ${response.statusCode}');
    }
  }

  // Suppression des devis essence
  Future<void> deleteDevisEssence(int id) async {
    final response = await http.delete(
        Uri.parse('$baseUrl/delete/devis/$id')
    );

    if (response.statusCode != 200) {
      print('Error lors de la suppression devis essence: ${response.statusCode} - ${response.body}');
      throw Exception('Erreur lors de la suppression de devis essence');
    }
  }

}


/*Future<List<DevisModel>> fetchDevis() async {
    final response = await http.get(
      Uri.parse('$baseUrl/list/devis'),
    );

    if (response.statusCode == 200) {
      debugPrint(jsonDecode(response.body).toString());
      List<dynamic> body = jsonDecode(response.body);
      List<DevisModel> devis = body.map((dynamic item) => DevisModel.fromJson(item)).toList();
      print('Devis Station récupérés: $devis');
      return devis;
    } else {
      print('Erreur lors de la récupération des devis Station: ${response.statusCode}');
      throw Exception('Failed to load devis: ${response.statusCode}');
    }
  }*/

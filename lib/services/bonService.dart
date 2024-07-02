import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/bonModel.dart';

class BonService {
  final String baseUrl = 'http://10.0.2.2:8000';

  Future<BonModel> ajouterBon(BonModel bons) async {
    try {
      final Map<String, dynamic> requestData = bons.toJson();
      print('Request Data: $requestData');

      final response = await http.post(
        Uri.parse('$baseUrl/add/bon'),
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
          return BonModel.fromJson(responseData);
        } else {
          throw Exception('Invalid response data');
        }
      } else {
        print('Error: ${response.body}');
        throw Exception('Échec de la création de la réponse bon');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Échec de la création de bon de la station');
    }
  }

  Future<List<BonModel>> fetchBons(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/list/bons/$id'),
    );

    if (response.statusCode == 200) {
      debugPrint(jsonDecode(response.body).toString());
      List<dynamic> body = jsonDecode(response.body);
      List<BonModel> bons = body.map((dynamic item) => BonModel.fromJson(item)).toList();
      print('Bons Station récupérés: $bons');
      return bons;
    } else if (response.statusCode == 404) {
      // Gérer le cas où l'utilisateur n'a pas créé de devis
      print('L\'utilisateur n\'a pas créé de bons');
      return []; // Retourner une liste vide dans ce cas
    } else {
      // Gérer les autres codes d'erreur
      print('Erreur lors de la récupération des bon de Station: ${response.statusCode}');
      throw Exception('Échec du chargement de bon: ${response.statusCode}');
    }
  }

  // Suppression des devis essence
  Future<void> deleteBon(int id) async {
    final response = await http.delete(
        Uri.parse('$baseUrl/delete/bon/$id')
    );

    if (response.statusCode != 200) {
      print('Error lors de la suppression bon : ${response.statusCode} - ${response.body}');
      throw Exception('Erreur lors de la suppression de bon');
    }
  }
}
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:frontend_gestion_station/models/budgetTotalModel.dart';
import 'package:http/http.dart' as http;

class BudgetToatlService {
  final String baseUrl = 'http://10.0.2.2:8000';

  // Ajouter un budget toatl
  Future<BudgetTotalModel> createBudgetTotal(BudgetTotalModel budgetTotal) async {
    try {
      final Map<String, dynamic> requestData = budgetTotal.toJson();
      print('Request Data: $requestData');

      final response = await http.post(
        Uri.parse('$baseUrl/create/budgets_total'),
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
          return BudgetTotalModel.fromJson(responseData);
        } else {
          throw Exception('Invalid response data budget total');
        }
      } else {
        print('Error: ${response.body}');
        throw Exception('Failed to create budget total response');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to create budget total station');
    }
  }
  // Moification de budget total
  Future<BudgetTotalModel> modifierBudgetTotal(int id, BudgetTotalModel budgetTotalEdit) async {
    try {
      final Map<String, dynamic> requestData = budgetTotalEdit.toJson();
      print('Request Data Edit Budget: $requestData');

      final response = await http.put(
        Uri.parse('$baseUrl/edit/budgetTotal/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Response Data: $responseData');

        // Ensure responseData is a map and contains expected keys
        if (responseData is Map<String, dynamic>) {
          return BudgetTotalModel.fromJson(responseData);
        } else {
          throw Exception('Invalid response data edit budget');
        }
      } else {
        print('Error: ${response.body}');
        throw Exception('Échec de la mise à jour du budget total');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Échec de la mise à jour du budget total station');
    }
  }
  // List des Budgets total
  Future<List<BudgetTotalModel>> fetchBudgetTotal(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/list/budgetTotal/$id'),
    );

    if (response.statusCode == 200) {
      debugPrint(jsonDecode(response.body).toString());
      List<dynamic> body = jsonDecode(response.body);
      List<BudgetTotalModel> budgets = body.map((dynamic item) => BudgetTotalModel.fromJson(item)).toList();
      print('Budget total récupérés: $budgets');
      return budgets;
    } else if (response.statusCode == 404) {
      // Gérer le cas où l'utilisateur n'a pas créé de devis
      print('L\'utilisateur n\'a pas créé de budget total');
      return []; // Retourner une liste vide dans ce cas
    } else {
      // Gérer les autres codes d'erreur
      print('Erreur lors de la récupération des budgets total de Station: ${response.statusCode}');
      throw Exception('Failed to load budget total: ${response.statusCode}');
    }
  }
  // Suppression des budget total
  Future<void> deleteBudgetTotal(int id) async {
    final response = await http.delete(
        Uri.parse('$baseUrl/delete/budgetTotal/$id')
    );

    if (response.statusCode != 200) {
      print('Error lors de la suppression budget total: ${response.statusCode} - ${response.body}');
      throw Exception('Erreur lors de la suppression de budget total station');
    }
  }
}
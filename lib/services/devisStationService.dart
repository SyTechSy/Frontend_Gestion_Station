import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/devisStationModel.dart';

class DevisService {
  final String baseUrl = 'http://10.0.2.2:8000';

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
        return DevisModel.fromJson(jsonDecode(response.body));
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
  Future<List<DevisModel>> fetchDevis() async {
    final response = await http.get(
      Uri.parse('$baseUrl/list/devis'),
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<DevisModel> devis = body.map((dynamic item) => DevisModel.fromJson(item)).toList();
      print('Devis Station récupérés: $devis');
      return devis;
    } else {
      print('Erreur lors de la récupération des devis Station: ${response.statusCode}');
      throw Exception('Failed to load devis: ${response.statusCode}');
    }

  }

}
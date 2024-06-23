import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/devisStationModel.dart';

class DevisService {
  final String baseUrl = 'http://10.0.2.2:8000';

  Future<DevisModel> createDevis(DevisModel devis) async {
    try {
      final Map<String, dynamic> requestData = devis.toJson();
      print('Request Data: $requestData'); // Vérifiez les données envoyées

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
        print('Error: ${response.body}'); // Affichez le message d'erreur
        throw Exception('Failed to create devis response');
      }
    } catch (e) {
      print('Exception: $e'); // Affichez l'exception
      throw Exception('Failed to create devis station');
    }
  }
}
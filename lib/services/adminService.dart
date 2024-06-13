
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:frontend_gestion_station/models/adminModel.dart';

class AdminService {
  final String baseUrl = 'http://10.0.2.2:8000';

  // SERVICE CONNEXION ADMIN
  Future<AdminModel> loginAdmin(AdminModel admin) async {
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
  }
}
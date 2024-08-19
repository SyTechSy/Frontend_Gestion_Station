import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frontend_gestion_station/main.dart';
import 'package:frontend_gestion_station/services/adminService.dart';
import 'package:frontend_gestion_station/services/utilisateurService.dart';
import 'package:frontend_gestion_station/models/utilisateurModel.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Créer des instances factices pour les services
    final utilisateurService = UtilisateurService();
    final adminService = AdminService();
    final utilisateur = UserModel(
      idUser: 1,
      nomUtilisateur: '',
      prenomUtilisateur: '',
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(utilisateurService: utilisateurService, adminService: adminService,));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

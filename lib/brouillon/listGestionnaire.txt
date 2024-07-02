import 'package:flutter/material.dart';

class GestionnairePages extends StatelessWidget {
  const GestionnairePages({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestionnairesPage(),
    );
  }
}

class GestionnairesPage extends StatelessWidget {
  final List<Gestionnaire> gestionnaires = [
    Gestionnaire(
      name: 'Traoré Mamoutou',
      role: 'Gestionnaire de service station',
    ),
    Gestionnaire(
      name: 'Amadou Quitteye',
      role: 'Gestionnaire de service station',
    ),
    Gestionnaire(
      name: 'Amara Diakhaby',
      role: 'Gestionnaire de service station',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
            'Page ajout',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  text: 'Mes Gestionnaires',
                  onPressed: () {},
                ),
                CustomButton(
                  text: 'Ajouter',
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: gestionnaires.length,
              itemBuilder: (context, index) {
                return GestionnaireCard(gestionnaire: gestionnaires[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFD8E9B8), // Light green color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}

class Gestionnaire {
  final String name;
  final String role;

  Gestionnaire({
    required this.name,
    required this.role,
  });
}

class GestionnaireCard extends StatelessWidget {
  final Gestionnaire gestionnaire;

  const GestionnaireCard({
    required this.gestionnaire,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/logoHy.png'), // Ajoutez votre image par défaut ici
        ),
        title: Text(
          gestionnaire.name,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          gestionnaire.role,
          style: TextStyle(color: Colors.grey),
        ),
        trailing: TextButton(
          onPressed: () {
            // Action pour envoyer un SMS
          },
          child: Text(
            'Envoyer par SMS',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ),
    );
  }
}

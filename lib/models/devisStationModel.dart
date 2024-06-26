class DevisModel {
  int? id; // Ajoutez cette propriété si elle est nécessaire
  double valeurArriver;
  double valeurDeDepart;
  double prixUnite;
  double consommation;
  double budgetObtenu;
  DateTime dateAddDevis;
  int? idUser;

  DevisModel({
    required this.id, // Assurez-vous d'inclure toutes les propriétés requises ici
    required this.valeurArriver,
    required this.valeurDeDepart,
    required this.prixUnite,
    required this.consommation,
    required this.budgetObtenu,
    required this.dateAddDevis,
    required this.idUser,
  });

  factory DevisModel.fromJson(Map<String, dynamic> json) {
    return DevisModel(
      id: json['id'],
      valeurArriver: json['valeurArriver'] != null ? json['valeurArriver'].toDouble() : 0.0,
      valeurDeDepart: json['valeurDeDepart'] != null ? json['valeurDeDepart'].toDouble() : 0.0,
      prixUnite: json['prixUnite'] != null ? json['prixUnite'].toDouble() : 0.0,
      consommation: json['consommation'] != null ? json['consommation'].toDouble() : 0.0,
      budgetObtenu: json['budgetObtenu'] != null ? json['budgetObtenu'].toDouble() : 0.0,
      dateAddDevis: json['dateAddDevis'] != null ? DateTime.parse(json['dateAddDevis']) : DateTime.now(),
      //idUser: json['utilisateur']['id'] ?? 0,
      idUser: json['utilisateur']['id'] != null ? json['utilisateur']['id'] : 0,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'valeurArriver': valeurArriver,
      'valeurDeDepart': valeurDeDepart,
      'prixUnite': prixUnite,
      'consommation': consommation,
      'budgetObtenu': budgetObtenu,
      'dateAddDevis': dateAddDevis.toIso8601String(),
      'utilisateur': {'id' : idUser},
    };
  }
}

class BonDuJourModel {
  int? idBonJour;
  int? idUser;
  String dateAddBonDuJour; // Changement ici, on utilise String au lieu de DateTime
  String nomUtilisateur;
  String prenomUtilisateur;

  BonDuJourModel({
    this.idBonJour,
    required this.dateAddBonDuJour,
    required this.idUser,
    required this.nomUtilisateur,
    required this.prenomUtilisateur,
  });

  factory BonDuJourModel.fromJson(Map<String, dynamic> json) {
    return BonDuJourModel(
      idBonJour: json['idBonJour'],
      // Assurez-vous que la valeur est une chaîne
      dateAddBonDuJour: json['dateAddBonDuJour'] ?? '', // On attend une chaîne ici
      idUser: json['utilisateur'] != null ? json['utilisateur']['id'] : null,
      nomUtilisateur: json['utilisateur'] != null ? json['utilisateur']['nomUtilisateur'] : '',
      prenomUtilisateur: json['utilisateur'] != null ? json['utilisateur']['prenomUtilisateur'] : '',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'idBonJour': idBonJour,
      'dateAddBonDuJour': dateAddBonDuJour, // Utilise la chaîne sans conversion
      'utilisateur': {
        'id': idUser,
        'nomUtilisateur': nomUtilisateur,
        'prenomUtilisateur': prenomUtilisateur,
      },
    };
  }
}

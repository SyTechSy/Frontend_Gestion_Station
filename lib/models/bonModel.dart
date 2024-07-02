class BonModel {
  int? idBon;
  String nomDestinataire;
  String prixDemander;
  DateTime dateAddBon;
  int? idUser;
  String nomUtilisateur;
  String prenomUtilisateur;

  BonModel({
    this.idBon,
    required this.nomDestinataire,
    required this.prixDemander,
    required this.dateAddBon,
    required this.idUser,
    required this.nomUtilisateur,
    required this.prenomUtilisateur,
  });

  factory BonModel.fromJson(Map<String, dynamic> json) {
    return BonModel(
      idBon: json['idBon'],
      nomDestinataire: json['nomDestinataire'] ?? '',
      prixDemander: json['prixDemander'] ?? '',
      dateAddBon: json['dateAddDevis'] != null && json['dateAddDevis'] is Map<String, dynamic>
          ? DateTime.parse(json['dateAddDevis']['date'])
          : DateTime.now(),
      idUser: json['utilisateur'] != null ? json['utilisateur']['id'] : null,
      nomUtilisateur: json['utilisateur'] != null ? json['utilisateur']['nomUtilisateur'] : '',
      prenomUtilisateur: json['utilisateur'] != null ? json['utilisateur']['prenomUtilisateur'] : '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'idBon': idBon,
      'nomDestinataire': nomDestinataire,
      'prixDemander': prixDemander,
      'dateAddBon': dateAddBon.toIso8601String(),
      'utilisateur': {
        'id': idUser,
        'nomUtilisateur': nomUtilisateur,
        'prenomUtilisateur': prenomUtilisateur,
      },
    };
    return data;
  }
}
class BonModel {
  int? idBon;
  //String nomDestinataire;
  String prixDemander;
  String motif;
  DateTime dateAddBon;
  int? idUser;
  String nomUtilisateur;
  String prenomUtilisateur;
  int? idBonJour;

  BonModel({
    this.idBon,
    required this.prixDemander,
    required this.motif,
    required this.dateAddBon,
    required this.idUser,
    required this.nomUtilisateur,
    required this.prenomUtilisateur,
    required this.idBonJour,
  });

  factory BonModel.fromJson(Map<String, dynamic> json) {
    return BonModel(
      idBon: json['idBon'],
      //nomDestinataire: json['nomDestinataire'] ?? '',
      prixDemander: json['prixDemander'] ?? '',
      motif: json['motif'] ?? '',
      dateAddBon: json['dateAddDevis'] != null && json['dateAddDevis'] is Map<String, dynamic>
          ? DateTime.parse(json['dateAddDevis']['date'])
          : DateTime.now(),
      idUser: json['utilisateur'] != null ? json['utilisateur']['id'] : null,
      nomUtilisateur: json['utilisateur'] != null ? json['utilisateur']['nomUtilisateur'] : '',
      prenomUtilisateur: json['utilisateur'] != null ? json['utilisateur']['prenomUtilisateur'] : '',
      idBonJour: json['bondujour'] != null ? json['bondujour']['id'] : null,
    );
  }

  /*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'idBon': idBon,
      'nomDestinataire': nomDestinataire,
      'prixDemander': prixDemander,
      'motif': motif,
      'dateAddBon': dateAddBon,
      'utilisateur': {
        'id': idUser,
        'nomUtilisateur': nomUtilisateur,
        'prenomUtilisateur': prenomUtilisateur,
      },
    };
    return data;
  }*/

  Map<String, dynamic> toJson() {
    return {
      'idBon': idBon,
      //'nomDestinataire': nomDestinataire,
      'prixDemander': prixDemander,
      'motif': motif,
      'dateAddBon': dateAddBon.toIso8601String(),
      'utilisateur': {
        'id': idUser,
        'nomUtilisateur': nomUtilisateur,
        'prenomUtilisateur': prenomUtilisateur,
      },
      'bondujour': {
        'id': idBonJour,
      },
    };
  }
}
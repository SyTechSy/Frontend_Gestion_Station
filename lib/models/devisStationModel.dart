class DevisModel {
  int? idDevis;
  double? valeurArriver;
  double? valeurDeDepart;
  double? prixUnite;
  String? consommation;
  String? budgetObtenu;
  String? dateAddDevis;
  int? idUser; // Défini comme int

  DevisModel({
    this.idDevis,
    this.valeurArriver,
    this.valeurDeDepart,
    this.prixUnite,
    this.consommation,
    this.budgetObtenu,
    this.dateAddDevis,
    this.idUser,
  });

  factory DevisModel.fromJson(Map<String, dynamic> json) {
    return DevisModel(
      idDevis: json['idDevis'],
      valeurArriver: (json['valeurArriver'] as num?)?.toDouble(),
      valeurDeDepart: (json['valeurDeDepart'] as num?)?.toDouble(),
      prixUnite: (json['prixUnite'] as num?)?.toDouble(),
      consommation: json['consommation'] as String?,
      budgetObtenu: json['budgetObtenu'] as String?,
      dateAddDevis: json['dateAddDevis'] as String?,
      idUser: json['utilisateur']['id'] as int, // Assurez-vous que 'id' est bien un int
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': idDevis,
      'valeurArriver': valeurArriver,
      'valeurDeDepart': valeurDeDepart,
      'prixUnite': prixUnite,
      'consommation': consommation,
      'budgetObtenu': budgetObtenu,
      'dateAddDevis': dateAddDevis,
      'utilisateur': {
        'id': idUser, // Assurez-vous que idUser est correctement défini
      },
    };
  }
}

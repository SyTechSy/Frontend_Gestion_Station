class DevisGasoilModel {
  int? id;
  double valeurArriver;
  double valeurDeDepart;
  double prixUnite;
  double consommation;
  double budgetObtenu;
  DateTime dateAddDevis;
  int? idUser;
  String nomUtilisateur;
  String prenomUtilisateur;

  DevisGasoilModel({
    required this.id,
    required this.valeurArriver,
    required this.valeurDeDepart,
    required this.prixUnite,
    required this.consommation,
    required this.budgetObtenu,
    required this.dateAddDevis,
    required this.idUser,
    required this.nomUtilisateur,
    required this.prenomUtilisateur,
  });

  factory DevisGasoilModel.fromJson(Map<String, dynamic> json) {
    /*print('Received JSON: $json');
    print('Type of idDevis: ${json['idDevis'].runtimeType}');
    print('Type of valeurArriver: ${json['valeurArriver'].runtimeType}');
    print('Type of valeurDeDepart: ${json['valeurDeDepart'].runtimeType}');
    print('Type of prixUnite: ${json['prixUnite'].runtimeType}');
    print('Type of consommation: ${json['consommation'].runtimeType}');
    print('Type of budgetObtenu: ${json['budgetObtenu'].runtimeType}');
    print('Type of dateAddDevis: ${json['dateAddDevis'].runtimeType}');
    print('Type of idUser: ${json['utilisateur']?['id'].runtimeType}');*/
    return DevisGasoilModel(
      id: json['idDevis'] != null ? (json['idDevis'] is int ? json['idDevis'] : int.tryParse(json['idDevis'].toString())) : null,
      valeurArriver: json['valeurArriver'] != null ? (json['valeurArriver'] as num).toDouble() : 0.0,
      valeurDeDepart: json['valeurDeDepart'] != null ? (json['valeurDeDepart'] as num).toDouble() : 0.0,
      prixUnite: json['prixUnite'] != null ? (json['prixUnite'] as num).toDouble() : 0.0,
      consommation: json['consommation'] != null ? (json['consommation'] as num).toDouble() : 0.0,
      budgetObtenu: json['budgetObtenu'] != null ? (json['budgetObtenu'] as num).toDouble() : 0.0,
      //dateAddDevis: json['dateAddDevis'] != null ? DateTime.parse(json['dateAddDevis']['date']) : DateTime.now(),
      dateAddDevis: json['dateAddDevis'] != null && json['dateAddDevis'] is Map<String, dynamic>
          ? DateTime.parse(json['dateAddDevis']['date'])
          : DateTime.now(),
      idUser: json['utilisateur'] != null ? (json['utilisateur']['id'] is int ? json['utilisateur']['id'] : int.tryParse(json['utilisateur']['id'].toString())) : null,
      nomUtilisateur: json['utilisateur'] != null ? json['utilisateur']['nomUtilisateur'] : null,
      prenomUtilisateur: json['utilisateur'] != null ? json['utilisateur']['prenomUtilisateur'] : null,
      /*dateAddDevis: json['dateAddDevis'] != null ? DateTime.parse(json['dateAddDevis']) : DateTime.now(),
      dateAddDevis: json['dateAddDevis'] != null ? DateTime.parse(json['dateAddDevis']['date']) : DateTime.now(),
      idUser: json['utilisateur'] != null && json['utilisateur']['id'] is int ? json['utilisateur']['id'] : int.tryParse(json['utilisateur']?['id'].toString() ?? '0'),
      idUser: json['utilisateur']['id'],*/
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idDevis': id,
      'valeurArriver': valeurArriver,
      'valeurDeDepart': valeurDeDepart,
      'prixUnite': prixUnite,
      'consommation': consommation,
      'budgetObtenu': budgetObtenu,
      'dateAddDevis': dateAddDevis.toIso8601String(),
      'utilisateur': {
        'id': idUser,
        'nomUtilisateur': nomUtilisateur,
        'prenomUtilisateur': prenomUtilisateur,
      },
    };
  }
}
